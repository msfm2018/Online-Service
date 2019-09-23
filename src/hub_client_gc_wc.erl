%% coding: utf-8
-module(hub_client_gc_wc).
-include("common.hrl").
-include("proto_player.hrl").
-compile(export_all).

loop(Socket, {init}) ->
  ok;

loop(Socket, {terminate, Reason}) ->
  case get(player_id) of
    ?UNDEFINED -> ok;
    Player_Id ->
      OldPid = ?ETS_LOOKUP_ELEMENT(?GC_PLAYER_INFO_ETS, Player_Id, #gc_player_info_ets.pid),
      ?IF(OldPid =:= self(),
        begin
          ets:delete(?GC_PLAYER_INFO_ETS, Player_Id)
        end)
  end,
  ok;

loop(_Socket, <<>>) ->
  ok;
loop(Socket, Data) ->
  [{Protocol, JsonData}] = jsx:decode(Data),
  receive_data(Socket, binary_to_list(Protocol), JsonData).


%匿名访问者 请求账号
receive_data(Socket, "0x01", _) ->
  PrivateKey = uuid:to_string(uuid:uuid1()),

  Login_name = erlang:phash2(PrivateKey),
  Json = jsx:encode([{<<"resultCode">>, 0}, {<<"resultMsg">>, <<"ok">>}, {<<"protocol">>, 16#01},
    {
      <<"data">>,
      [[ %%[[ 为了客户端好解析 
        {<<"account">>, integer_to_binary(Login_name)}
      ]]
    }
  ]),

  gen_tcp:send(Socket, ?packwebtxtmsg(Json)),
  ok;


receive_data(Socket, "0x02", NewPlayerId) ->

  case ets:lookup(?GC_PLAYER_INFO_ETS, NewPlayerId) of
    [#gc_player_info_ets{status = OldStatus, pid = OldPid}] ->
      if
        OldStatus =:= ?PLAYER_REGISTER_STATUS andalso OldPid =:= self() ->  % 先前是注册状态，
          ets:insert(?GC_PLAYER_INFO_ETS, #gc_player_info_ets{player_id = NewPlayerId, socket = Socket, status = ?PLAYER_LOGIN_STATUS, pid = self()}),
          put(player_id, NewPlayerId);

        OldStatus =:= ?PLAYER_LOGINED_STATUS andalso OldPid =/= self() ->
          % 当前用户顶掉同节点上的用户
          Msg = "13",% proto:pack(#mod_player_login_s2c{}),
          gen_tcp:send(Socket, ?packwebtxtmsg(Msg)),
          ok;

        ok;
        OldStatus =:= ?PLAYER_LOGINED_STATUS andalso OldPid =:= self() ->
          % 已经登陆了 这里暂时不做处理 todo 添加log 为什么客户端会发送了两次login消息
          ok;
        true ->
          io:format("444444444444444444~n"),% 登陆失败，当前这个账号正在登陆或者注册状态 直接返回稍后登陆
          Msg = jsx:encode([{<<"resultCode">>, -5}, {<<"resultMsg">>, <<"ok">>}, {<<"protocol">>, 16#01},
            {
              <<"data">>,
              []
            }
          ]),
          gen_tcp:send(Socket, ?packwebtxtmsg(Msg)),
          ok
      end;
    _ ->  % 当前节点没有用户登陆此账号，直接登陆
      put(player_id, NewPlayerId),
      ets:insert(?GC_PLAYER_INFO_ETS, #gc_player_info_ets{player_id = NewPlayerId, pid = self(), socket = Socket, status = ?PLAYER_LOGIN_STATUS})
  end;


%%访客给客服消息    0x03_web
receive_data(Socket, "0x03_web_visitor", Json_data) ->

  put(send_flag_0x03, no),

  [{<<"senderid">>, Senderid},
    {<<"toid">>, Toid},
    {<<"nick">>, Nick},
    {<<"msgtype">>, Msgtype},
    {<<"content">>, Content},
    {<<"sendtime">>, Sendtime},
    {<<"msgid">>, Msgid}] = Json_data,


  if Toid == <<>>
    ->
    UsrLst = ets:tab2list(?GC_PLAYER_INFO_ETS),

    lists:dropwhile(
      fun(L) ->

        %%false 跳出循环
        #gc_player_info_ets{socket = So, player_id = NewPlayerId} = L,
        Left_value = string:left(binary_to_list(NewPlayerId), 2),
        io:format("Left_value ~p~n", [Left_value]),
        if Left_value == "kf"
          ->
          Json_t = jsx:encode([{<<"resultCode">>, 0}, {<<"resultMsg">>, <<"ok">>}, {<<"protocol">>, 16#05},
            {
              <<"data">>, Json_data
            }
          ]),
          %%      $05   给客服消息
          gen_tcp:send(So, ?packwebtxtmsg(Json_t)),


          %% 0x06 协议    给顾客 返回客服id
          Json = jsx:encode([{<<"resultCode">>, 0}, {<<"resultMsg">>, <<"ok">>}, {<<"protocol">>, 16#06},
            {
              <<"data">>,
              [[
                {<<"toid">>, NewPlayerId}
              ]]
            }
          ]),
          gen_tcp:send(Socket, ?packwebtxtmsg(Json)),

          put(send_flag_0x03, yes),
          false;
          true ->
            true
        end


      end, UsrLst),

    Flag = get(send_flag_0x03),
    if Flag == no ->
      io:format("客服未在线 返回错误码 -1~n"),

      Json = jsx:encode([{<<"resultCode">>, -1}, {<<"resultMsg">>, <<"leave">>}, {<<"protocol">>, 16#03},
        {
          <<"data">>,
          [
          ]
        }
      ]),
      gen_tcp:send(Socket, ?packwebtxtmsg(Json));
      true -> ok
    end;

    true ->
%%      io:format("~ts~n", [{"与 ", Toid, " 对话 "}]),
      UsrLst = ets:tab2list(?GC_PLAYER_INFO_ETS),


      lists:dropwhile(
        fun(L) ->

%%false 跳出循环
          #gc_player_info_ets{socket = So, player_id = NewPlayerId} = L,
          io:format("~p~n", [{NewPlayerId, Toid}]),
          if Toid == NewPlayerId
            ->
            io:format("客服在线 推送信息~n"),


            Json_t1 = jsx:encode([{<<"resultCode">>, 0}, {<<"resultMsg">>, <<"ok">>}, {<<"protocol">>, 16#05},
              {
                <<"data">>, Json_data
              }
            ]),
            gen_tcp:send(So, ?packwebtxtmsg(Json_t1)),
            put(send_flag_0x03, yes),
            false;
            true ->
              true
          end
        end,
        UsrLst),

      Flag = get(send_flag_0x03),
      if Flag == no ->
        io:format("客服已离线 返回错误码 -2~n"),

        Json = jsx:encode([{<<"resultCode">>, -2}, {<<"resultMsg">>, <<"leave">>}, {<<"protocol">>, 16#03},
          {
            <<"data">>,
            [
            ]
          }
        ]),
        gen_tcp:send(Socket, ?packwebtxtmsg(Json));
        true -> ok
      end
  end,
%%  io:format("~p~n", [Json_list]),
  ok;




%%  0x04    客服 给 访客消息
receive_data(Socket, "0x04", Json_data) ->
  Json_list = jsx:decode(Json_data),


  [{<<"senderid">>, Senderid},
    {<<"toid">>, Toid},
    {<<"nick">>, Nick},
    {<<"msgtype">>, Msgtype},
    {<<"content">>, Content},
    {<<"sendtime">>, Sendtime},
    {<<"msgid">>, Msgid}] = Json_list,

%%  io:format("~ts~n", [{"与 ", Toid, " 对话 "}]),
  io:format("aaaaaaaaaaaaaaaaaaaaaaaaaaa~n"),
  UsrLst = ets:tab2list(?GC_PLAYER_INFO_ETS),
  put(send_flag_0x04, no),

  io:format("bbbbbbbbbbbbbbbbbbbbbbbbbbb~n"),
  lists:dropwhile(
    fun(L) ->

%%false 跳出循环
      #gc_player_info_ets{socket = So, player_id = NewPlayerId} = L,
      io:format("~p~n", [{NewPlayerId, Toid}]),
      if Toid == NewPlayerId
        ->
        io:format("顾客在线 推送信息 ~n"),


        Json_t1 = jsx:encode([{<<"resultCode">>, 0}, {<<"resultMsg">>, <<"ok">>}, {<<"protocol">>, 16#05},
          {
            <<"data">>, Json_data

          }
        ]),
        gen_tcp:send(So, ?packwebtxtmsg(Json_t1)),
        put(send_flag_0x04, yes),
        false;
        true ->
          true
      end
    end,
    UsrLst),
  Flagg = get(send_flag_0x04),
  if Flagg == no
    ->  %%  访客已离线
    Json_err = jsx:encode([{<<"resultCode">>, -3}, {<<"resultMsg">>, <<"leave">>}, {<<"protocol">>, 16#03},
      {
        <<"data">>, Toid
        %[
        %]
      }
    ]),
    gen_tcp:send(Socket, ?packwebtxtmsg(Json_err));
    true -> ok
  end,
  ok;


receive_data(Socket, "0x07", _) ->

  {ok, {IP_Address, Port}} = inet:peername(Socket),


  io:format("心跳包 ~p~n~n", [{IP_Address, Port}]),
  ok.


%%%%%%% internal function
