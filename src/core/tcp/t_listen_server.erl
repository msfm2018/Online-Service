-module(t_listen_server).

-behaviour(gen_server).


-include("common.hrl").
%% API
-compile(export_all).

-define(SERVER, ?MODULE).
%%{Listen_Name, {t_listen_server, start_link, [T_tcp_options]}, transient, 1000, worker, [t_listen_server]}
start_link(#t_tcp_sup_options{t_accept_sup_name = Accept_sup, t_listen_server_name = Name, port = Port, acceptor_num = Acceptor_num, tcp_opts = Opts}) ->

  gen_server:start_link({local, Name}, ?MODULE, [Port, Acceptor_num, Accept_sup, Opts], []).

init([Port, Acceptor_num, Accept_sup, Opts]) ->
  process_flag(trap_exit, true),
%%  utils:log(["myport ",Port]),
  case gen_tcp:listen(Port, Opts) of
    {ok, ListenSocket} ->
      lists:foreach(fun (_) ->
        {ok, _} = supervisor:start_child(Accept_sup, [ListenSocket])
      end,
        lists:seq(1, Acceptor_num)),
      {ok, ListenSocket};
    {error, Reason} ->
      {stop, {cannot_listen, Reason}}
  end.


handle_call(_Request, _From, State) ->
  {reply, ok, State}.


handle_cast(_Request, State) ->
  {noreply, State}.


handle_info(_Info, State) ->
  {noreply, State}.


terminate(_Reason, _State) ->
  ok.

code_change(_OldVsn, State, _Extra) ->
  {ok, State}.

%%%===================================================================
%%% Internal functions
%%%===================================================================
