-module(utils).
-include("common.hrl").
-compile(export_all).


% ets 为非关键字 的查询删除

  del_player(So) ->
Key = ets:first(users),
case Key of
'$end_of_table' -> void;
_ ->
RT = ets:lookup(users, Key),
case RT of
[] -> void;
_ ->
[{_, _, _, _, B}] = RT,
case B == So of
true ->
ets:delete(users, Key);
false ->
nx(Key, So)
end
end

end.

nx(Keys, So) ->
  Key1 = ets:next(users, Keys),
  case Key1 of
    '$end_of_table' -> void;
    _ ->
      RT = ets:lookup(users, Key1),
      [{_, _, _, _, B}] = RT,
      case B == So of
        true ->
%%          io:format("ok~n"),
          ets:delete(users, Key1);

        false ->
%%          io:format("next2~n"),
          nx(Key1, So)
      end

  end.


%删除 代理IP
del_gateway_ip([], _OldVal, Vals) -> db:set_value("gateway_ip", Vals);
del_gateway_ip([H | T], OldVal, Vals) ->
  case re:run(binary_to_list(H), OldVal) of
    {match, _} ->
      New = Vals;
    _ -> case H of
           <<>> -> New = Vals;
           _ -> H1 = binary_to_list(H) ++ " ", New = [H1 | Vals]
         end
  end,
  del_gateway_ip(T, OldVal, New).


local_port() ->
  [{gc_gateway,[{port,Port},{acceptor_num,_}]}] = ets:lookup(?LocalCfg, gc_gateway), Port.

 local_accetpnum() ->
%%  [{gc_gateway,[{port,_},{acceptor_num,Num},{localexternal_ip,_}]}] = ets:lookup(?LocalCfg, gc_gateway), Num.
[{gc_gateway,[{port,_},{acceptor_num,Num}]}] = ets:lookup(?LocalCfg, gc_gateway),Num.

string_to_term(Str) ->
  case catch erl_scan:string(Str ++ ". ") of
    {ok, ScannedStr, _No} ->
      case erl_parse:parse_term(ScannedStr) of
        {ok, Term} ->
          {ok, Term};
        _Other ->
          %% May be a PID, have to check this, since erl_scan
          %% currently cannot handle this case...  :-(
          case catch list_to_pid(Str) of
            Pid when is_pid(Pid) ->
              {ok, Pid};
            _Error ->
              case get(error_msg_mode) of
                normal ->
                  {error, {not_a_term, "Please enter a valid term!"}};
                haiku ->
                  {error, {not_a_term, ["Aborted effort.",
                    "Reflect, repent and retype:",
                    "Enter valid term."]}}
              end
          end
      end;
    _Error ->
      case get(error_msg_mode) of
        normal ->
          {error, {not_a_term, "Please enter a valid term!"}};
        haiku ->
          {error, {not_a_term, ["Aborted effort.",
            "Reflect, repent and retype:",
            "Enter valid term."]}}
      end
  end.

get_my_ip() ->
  case init:get_argument(ip) of
    {ok, [[Ip | _]]} ->
      ?TO_B(Ip);
    _ ->
      get_ip_by_node(node())
  end.

get_local_ip() ->
  [_, LocalIp] = string:tokens(atom_to_list(node()), "@"), LocalIp.
get_gateway_name() ->
  [Name, _] = string:tokens(atom_to_list(node()), "@"), Name.

get_redis_host() ->
  case init:get_argument(redis) of
    {ok, [[Ip | _]]} ->
      ?TO_B(Ip);
    _ ->
      get_ip_by_node(node())
  end.

get_ip_by_node(Node) ->
  S = ?TO_L(Node),
  [_, Ip] = string:tokens(S, "@"),
  ?TO_B(Ip).

ets_lookup_element(T, K, P) ->
  case catch ets:lookup_element(T, K, P) of
    {'EXIT', _} ->
      ?NULL;
    R ->
      R
  end.


%% @doc 删除操作  不在乎顺序的删除
delete_list_member_no_order(Member, List) ->
  delete_list_member_no_order(Member, List, []).
delete_list_member_no_order(_, [], RList) ->
  RList;
delete_list_member_no_order(Member, [H | L], RList) ->
  ?IF(Member =:= H, delete_list_member_no_order(Member, L, RList), delete_list_member_no_order(Member, L, [H | RList])).

%% @doc 获取元组列表中对应k的v
get_v_by_k(K, L) ->
  get_v_by_k(K, L, ?UNDEFINED).
get_v_by_k(K, L, Default) ->
  case lists:keyfind(K, 1, L) of
    {_, V} ->
      V;
    _ ->
      Default
  end.

%% @doc list去重 不保持顺序
quchong_no_order(L) ->
  quchong1(L, []).
quchong1([], L1) ->
  L1;
quchong1([H | L], L1) ->
  case lists:member(H, L1) of
    true -> quchong1(L, L1);
    false -> quchong1(L, [H | L1])
  end.



local_node() -> list_to_binary(atom_to_list(node())).
local_node_size() -> size(local_node()).


%% @doc get IP address string from Socket
ip(Socket) ->
  {ok, {IP, _Port}} = inet:peername(Socket),
  {Ip0, Ip1, Ip2, Ip3} = IP,
  list_to_binary(integer_to_list(Ip0) ++ "." ++ integer_to_list(Ip1) ++ "." ++ integer_to_list(Ip2) ++ "." ++ integer_to_list(Ip3)).


%% @doc quick sort
sort([]) ->
  [];
sort([H | T]) ->
  sort([X || X <- T, X < H]) ++ [H] ++ sort([X || X <- T, X >= H]).

%% for
for(Max, Max, F) -> [F(Max)];
for(I, Max, F) -> [F(I) | for(I + 1, Max, F)].


%% @doc convert float to string,  f2s(1.5678) -> 1.57
f2s(N) when is_integer(N) ->
  integer_to_list(N) ++ ".00";
f2s(F) when is_float(F) ->
  [A] = io_lib:format("~.2f", [F]),
  A.


%% @doc convert other type to atom
to_atom(Msg) when is_atom(Msg) ->
  Msg;
to_atom(Msg) when is_binary(Msg) ->
  utils:list_to_atom2(binary_to_list(Msg));
to_atom(Msg) when is_list(Msg) ->
  utils:list_to_atom2(Msg);
to_atom(_) ->
  throw(other_value).

%% @doc convert other type to list
to_list(Msg) when is_list(Msg) ->
  Msg;
to_list(Msg) when is_atom(Msg) ->
  atom_to_list(Msg);
to_list(Msg) when is_binary(Msg) ->
  binary_to_list(Msg);
to_list(Msg) when is_integer(Msg) ->
  integer_to_list(Msg);
to_list(Msg) when is_float(Msg) ->
  f2s(Msg);
to_list(Msg) when is_tuple(Msg) ->
  tuple_to_list(Msg);
to_list(_) ->
  throw(other_value).

%% @doc convert other type to binary
to_binary(Msg) when is_binary(Msg) ->
  Msg;
to_binary(Msg) when is_atom(Msg) ->
  list_to_binary(atom_to_list(Msg));
%%atom_to_binary(Msg, utf8);
to_binary(Msg) when is_list(Msg) ->
  list_to_binary(Msg);
to_binary(Msg) when is_integer(Msg) ->
  list_to_binary(integer_to_list(Msg));
to_binary(Msg) when is_float(Msg) ->
  list_to_binary(f2s(Msg));
to_binary(_Msg) ->
  throw(other_value).

%% @doc convert other type to float
to_float(Msg) ->
  Msg2 = to_list(Msg),
  list_to_float(Msg2).

%% @doc convert other type to integer
-spec to_integer(Msg :: any()) -> integer().
to_integer(Msg) when is_integer(Msg) ->
  Msg;
to_integer(Msg) when is_binary(Msg) ->
  Msg2 = binary_to_list(Msg),
  list_to_integer(Msg2);
to_integer(Msg) when is_list(Msg) ->
  list_to_integer(Msg);
to_integer(Msg) when is_float(Msg) ->
  round(Msg);
to_integer(_Msg) ->
  throw(other_value).

to_bool(D) when is_integer(D) ->
  D =/= 0;
to_bool(D) when is_list(D) ->
  length(D) =/= 0;
to_bool(D) when is_binary(D) ->
  to_bool(binary_to_list(D));
to_bool(D) when is_boolean(D) ->
  D;
to_bool(_D) ->
  throw(other_value).

%% 不支持binary到tuple的直接转换　因为这种往往是直接从数据库取出来的<<"{1,2,3}">>等形式，单独做
to_tuple(D) when is_integer(D) ->
  list_to_tuple(integer_to_list(D));
to_tuple(D) when is_list(D) ->
  list_to_tuple(D);
to_tuple(D) when is_atom(D) ->
  list_to_tuple(atom_to_list(D));
to_tuple(_D) ->
  throw(other_value).


%% @doc get a random integer between Min and Max
random(Min, Max) ->
  Min2 = Min - 1,
  rand:uniform(Max - Min2) + Min2.

%% @doc 取整 大于X的最小整数
ceil(X) ->
  T = trunc(X),
  if
    X - T == 0 ->
      T;
    true ->
      if
        X > 0 ->
          T + 1;
        true ->
          T
      end
  end.

%% @doc 取整 小于X的最大整数
floor(X) ->
  T = trunc(X),
  if
    X - T == 0 ->
      T;
    true ->
      if
        X > 0 ->
          T;
        true ->
          T - 1
      end
  end.


md5(S) ->
  Md5_bin = erlang:md5(S),
  Md5_list = binary_to_list(Md5_bin),
  lists:flatten(list_to_hex(Md5_list)).

list_to_hex(L) ->
  lists:map(fun(X) -> int_to_hex(X) end, L).

int_to_hex(N) when N < 256 ->
  [hex(N div 16), hex(N rem 16)].
hex(N) when N < 10 ->
  $0 + N;
hex(N) when N >= 10, N < 16 ->
  $a + (N - 10).

list_to_atom2(List) when is_list(List) ->
  case catch (list_to_existing_atom(List)) of
    {'EXIT', _} -> erlang:list_to_atom(List);
    Atom when is_atom(Atom) -> Atom
  end.

combine_lists(L1, L2) ->
  Rtn =
    lists:foldl(
      fun(T, Acc) ->
        case lists:member(T, Acc) of
          true ->
            Acc;
          false ->
            [T | Acc]
        end
      end, lists:reverse(L1), L2),
  lists:reverse(Rtn).


get_process_info_and_zero_value(InfoName) ->
  PList = erlang:processes(),
  ZList = lists:filter(
    fun(T) ->
      case erlang:process_info(T, InfoName) of
        {InfoName, 0} -> false;
        _ -> true
      end
    end, PList),
  ZZList = lists:map(
    fun(T) -> {T, erlang:process_info(T, InfoName), erlang:process_info(T, registered_name)}
    end, ZList),
  [length(PList), InfoName, length(ZZList), ZZList].

get_process_info_and_large_than_value(InfoName, Value) ->
  PList = erlang:processes(),
  ZList = lists:filter(
    fun(T) ->
      case erlang:process_info(T, InfoName) of
        {InfoName, VV} ->
          if VV > Value -> true;
            true -> false
          end;
        _ -> true
      end
    end, PList),
  ZZList = lists:map(
    fun(T) -> {T, erlang:process_info(T, InfoName), erlang:process_info(T, registered_name)}
    end, ZList),
  [length(PList), InfoName, Value, length(ZZList), ZZList].

get_msg_queue() ->
  io:fwrite("process count:~p~n~p value is not 0 count:~p~nLists:~p~n",
    get_process_info_and_zero_value(message_queue_len)).

get_memory() ->
  io:fwrite("process count:~p~n~p value is large than ~p count:~p~nLists:~p~n",
    get_process_info_and_large_than_value(memory, 1048576)).

get_memory(Value) ->
  io:fwrite("process count:~p~n~p value is large than ~p count:~p~nLists:~p~n",
    get_process_info_and_large_than_value(memory, Value)).

get_heap() ->
  io:fwrite("process count:~p~n~p value is large than ~p count:~p~nLists:~p~n",
    get_process_info_and_large_than_value(heap_size, 1048576)).

get_heap(Value) ->
  io:fwrite("process count:~p~n~p value is large than ~p count:~p~nLists:~p~n",
    get_process_info_and_large_than_value(heap_size, Value)).

get_processes() ->
  io:fwrite("process count:~p~n~p value is large than ~p count:~p~nLists:~p~n",
    get_process_info_and_large_than_value(memory, 0)).


list_to_term(String) ->
  {ok, T, _} = erl_scan:string(String ++ "."),
  case erl_parse:parse_term(T) of
    {ok, Term} ->
      Term;
    {error, Error} ->
      Error
  end.

string_to_fun(S) ->
  string_to_fun(S, []).
string_to_fun(S, Binding) ->
  {ok, Ts, _} = erl_scan:string(S),
  Ts1 = case lists:reverse(Ts) of
          [{dot, _} | _] -> Ts;
          TsR -> lists:reverse([{dot, 1} | TsR])
        end,
  {ok, Expr} = erl_parse:parse_exprs(Ts1),
  {value, Fun, _} = erl_eval:exprs(Expr, Binding),
  Fun.


substr_utf8(Utf8EncodedString, Length) ->
  substr_utf8(Utf8EncodedString, 1, Length).
substr_utf8(Utf8EncodedString, Start, Length) ->
  ByteLength = 2 * Length,
  Ucs = xmerl_ucs:from_utf8(Utf8EncodedString),
  Utf16Bytes = xmerl_ucs:to_utf16be(Ucs),
  SubStringUtf16 = lists:sublist(Utf16Bytes, Start, ByteLength),
  Ucs1 = xmerl_ucs:from_utf16be(SubStringUtf16),
  xmerl_ucs:to_utf8(Ucs1).

ip_str(IP) ->
  case IP of
    {A, B, C, D} ->
      lists:concat([A, ".", B, ".", C, ".", D]);
    {A, B, C, D, E, F, G, H} ->
      lists:concat([A, ":", B, ":", C, ":", D, ":", E, ":", F, ":", G, ":", H]);
    Str when is_list(Str) ->
      Str;
    _ ->
      []
  end.

%%去掉字符串空格
remove_string_black(L) ->
  lists:reverse(remove_string_loop(L, [])).

remove_string_loop([], L) ->
  L;
remove_string_loop([I | L], LS) ->
  case I of
    32 ->
      remove_string_loop(L, LS);
    _ ->
      remove_string_loop(L, [I | LS])
  end.


%%获取协议操作的时间戳，true->允许；false -> 直接丢弃该条数据
%%spec is_operate_ok/1 param: Type -> 添加的协议类型(atom); return: true->允许；false -> 直接丢弃该条数据
is_operate_ok(Type, TimeStamp) ->
  NowTime = util:unixtime(),
  case get(Type) of
    undefined ->
      put(Type, NowTime),
      true;
    Value ->
      case (NowTime - Value) >= TimeStamp of
        true ->
          put(Type, NowTime),
          true;
        false ->
          false
      end
  end.

%%替换指定的列表的指定的位置N的元素
%%eg: replace([a,b,c,d], 2, g) -> [a,g,c,d]
replace(List, Key, NewElem) ->
  NewList = lists:reverse(List),
  Len = length(List),
  case Key =< 0 orelse Key > Len of
    true ->
      List;
    false ->
      replace_elem(Len, [], NewList, Key, NewElem)
  end.
replace_elem(0, List, _OldList, _Key, _NewElem) ->
  List;
replace_elem(Num, List, [Elem | OldList], Key, NewElem) ->
  NewList =
    case Num =:= Key of
      true ->
        [NewElem | List];
      false ->
        [Elem | List]
    end,
  replace_elem(Num - 1, NewList, OldList, Key, NewElem).
