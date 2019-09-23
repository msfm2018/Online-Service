-module(gc_gateway_app).

-behaviour(application).
-include("common.hrl").
-compile(export_all).

start(_StartType, _StartArgs) ->
  {ok, Pid} = server_sup:start_link(?MODULE),
  reloader:start(?MODULE),
  install_table(),
 load_cfg(),
  run(),
  {ok, Pid}.

quit() ->
  exit(whereis(?MODULE), kill).

stop(_State) ->  %
  ok.

run() ->


  %tcp start
  Opt = #t_tcp_sup_options{
    is_websocket=case init:get_argument(tcp) of
                   error-> true;
                   _-> false
                 end,

    t_tcp_sup_name = hub_client_gc_wc,
    port = utils:local_port(),
    acceptor_num = utils:local_accetpnum(),
    max_connections = infinity,% MaxConnection,
    tcp_opts = [binary, {packet, 0}, {reuseaddr, true}, {nodelay, true}, {delay_send, false}, {send_timeout, 5000}, {keepalive, true}, {exit_on_close, true}],
    call_back = fun hub_client_gc_wc:loop/2,
    alone = true
  },
  t_tcp_sup:start_child(?MODULE, Opt),
  ok.

install_table() ->
    catch ets:new(?LocalCfg, [public, set, named_table,  ?ETS_READ_CONCURRENCY, ?ETS_WRITE_CONCURRENCY]),
    catch ets:new(?GC_PLAYER_INFO_ETS, [{keypos, #gc_player_info_ets.player_id}, public, named_table, set, ?ETS_READ_CONCURRENCY, ?ETS_WRITE_CONCURRENCY]),
  ok.



load_cfg() ->
  File = "config.cfg",
  case file:consult(File) of
    {ok, L} ->
      ets:insert(?LocalCfg, L);
    E ->
      ?THROW(E)
  end.
