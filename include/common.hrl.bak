%%%-------------------------------------------------------------------
%%% @author ASUS
%%% @copyright (C) 2014, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 14. 十二月 2014 下午4:50
%%%-------------------------------------------------------------------
-author("ASUS").



-ifndef(COMMON_HRL).
-define(COMMON_HRL, true).

-include("log_common.hrl").
-include("error.hrl").
-include("server.hrl").

-record(tb1, {id , ip,port, cpu , mem }).
-define(Tb1,tb1).




-record(localcfg, {id,port,acceptor_num,externalip}).
-define(LocalCfg,localcfg).

-define(SYNC_SEND(Socket, Data), catch erlang:port_command(Socket, Data, [force])).
%% 网关最大连接数
-define(MAX_GATEWAY_CONNECTIONS, 10000).
-define(CONNECTION_FIRST_DATA_TIME, 5000).  % 连接建立成功之后 在这个时间之内没有发数据则断开
-define(HEART_BREAK_TIME, 120000).   % 心跳时长
-define(HEART_BREAK_CLIENT_TIME, 50000).   % 客户端心跳包间隔
-define(HEART_BREAK_TIME_HTTP, 5000).   % http连接超时时长

-define(SEND_MAX_SECONDS, 4294967). % send_after 的最大秒数
%% work_process 参数
-record(work_process_param, {
    id_key = undefined,
    num,
    type,
    call_back = undefined
}).

%% alone 启动的tcp连接进程是否挂在supervisor下，加上这个用来观察以后效率情况，觉得可以不挂在supervisor下
-record(t_tcp_sup_options, {
    is_websocket = false,
    t_tcp_sup_name = t_tcp_sup,
    t_client_sup_name = t_client_sup,
    t_accept_sup_name = t_accept_sup,
    t_listen_server_name = t_listen_server,
    port = 8888,
    acceptor_num = 10,
    max_connections = 10000,
    tcp_opts =undefined,
    call_back = undefined,
    alone = false
}).

%% pg2_agent 参数
-record(pg2_agent_options,{
    pg2_name,
    name,   % 这个name只是用来注册名称时用的
    type = local,   % type 用来是local或者global
    callback
}).

-record(cluster_server_option, {
    name,
    callback = undefined
}).



-record(wc_gateway_opts, {
    name,
    wcip,
    wcport,
    tcp_opts,
    callback
}).

%%%-----------------------------------------
%%%  定义一些函数宏
%%%-----------------------------------------
-define(TO_L(A), utils:to_list(A)).
-define(TO_A(A), utils:to_atom(A)).
-define(TO_B(A), utils:to_binary(A)).
-define(TO_I(A), utils:to_integer(A)).
-define(TO_T(A), utils:to_tuple(A)).

%% "[]" -> []
-define(STRING_TO_TERM(A), utils:list_to_term(A)).
%% [] -> "[]"
-define(TERM_TO_STRING(A), lists:flatten(io_lib:format("~w",[A]))).
%% 数据中存的 "[{xxx}]"　等形式　　　　取出来后是<<"[{xxx}]">> 这个define将转换为 [{xxx}]
-define(DB_STRING_TO_TERM(A), ?STRING_TO_TERM(?TO_L(A))).


%% 向下取整
-define(TRUNC(A), erlang:trunc(A)).

-define(CHECK(A),
    case A of
        true -> ok;
        _ -> ?THROW(A)
    end).

-define(IF(A, B), ((A) andalso (B))).
-define(IF(A, B, C),
    (case (A) of
        true -> (B);
        _ -> (C)
    end)).

-define(MONITOR_PROCESS(A), erlang:monitor(process, A)).
-define(TRAP_EXIT, erlang:process_flag(trap_exit, true)).

-define(TRACE_STACK, erlang:process_info(self(), current_stacktrace)).

-define(UNDEFINED, undefined).
-define(NULL, null).

-ifdef(TEST).
-define(LOG_LEVEL, 5).
-else.
-define(LOG_LEVEL, 3).
-endif.

-define(R_FIELDS(Record), record_info(fields, Record)).
-define(THROW(E), throw({error, E})).
-define(THROW_ERROR, error).

-define(ETS_LOOKUP_ELEMENT(TABLE, KEY, POS), utils:ets_lookup_element(TABLE, KEY, POS)).



%%%-----------------------------------------
%%%  定义ｔｉｍｅｒ记录
%%%-----------------------------------------
%% 存盘timer
-record(player_save_timer, {
    time
}).

%% 每天零点定时器
-record(player_int24_timer, {
    time
}).

%% 针对某个模块的timer
-record(player_timer,{
    mod,
    function,
    time
}).

%%%-----------------------------------------
%%%  定义ｔｉｍｅｒ记录　ｅｎｄ
%%%-----------------------------------------

%%%-----------------------------------------
%%%  ｅｔｓ表
%%%-----------------------------------------
%% ｉｄ表
-define(ID_TABLE, id_table).

%% kv_cache表
-define(KV_TABLE, kv_table).


%% un
-define(EXTERNAL_NODE_ACCEPT_INFO, external_node_accept_info).
%% un   end


-define(ETS_READ_CONCURRENCY, {read_concurrency, true}).
-define(ETS_WRITE_CONCURRENCY, {write_concurrency, true}).

%%%-----------------------------------------
%%%  ｅｔｓ表 end
%%%-----------------------------------------

-define(IDKEY_GNUM(Node), {gnum, Node}).
-endif.