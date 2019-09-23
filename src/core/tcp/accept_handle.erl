-module(accept_handle).
-include("common.hrl").
-behaviour(gen_server).

-compile(export_all).

-record(state, {option, socket, ref}).

start_link(Option, Socket) ->
  gen_server:start_link(?MODULE, [Option, Socket], []).

init([Option, Socket]) ->
  gen_server:cast(self(), accept),
  {ok, #state{option = Option, socket = Socket}}.

handle_call(_Request, _From, State) ->
  {reply, ok, State}.

handle_cast(accept, State) ->

  accept(State);

handle_cast(_Request, State) ->
  {noreply, State}.

handle_info({inet_async, LSock, Ref, {ok, Sock}}, State = #state{option = Option, socket = LSock, ref = Ref}) ->
  case set_sockopt(LSock, Sock) of
    ok -> ok;
    {error, Reason} -> exit({set_sockopt, Reason})
  end,
  start_client(Option, Sock),
  accept(State);

handle_info({inet_async, LSock, Ref, {error, closed}}, State = #state{socket = LSock, ref = Ref}) ->
  {stop, normal, State};

handle_info(_Info, State) ->
  {noreply, State}.

terminate(_Reason, _State) ->
  ok.

code_change(_OldVsn, State, _Extra) ->
  {ok, State}.

%%%===================================================================
%%% Internal functions
%%%===================================================================
accept(State = #state{socket = LSock}) ->
  case prim_inet:async_accept(LSock, -1) of
    {ok, Ref} -> {noreply, State#state{ref = Ref}};
    Error -> {stop, {cannot_accept, Error}, State}
  end.

set_sockopt(LSock, Sock) ->
  true = inet_db:register_socket(Sock, inet_tcp),
  case prim_inet:getopts(LSock, [active, nodelay, keepalive, delay_send, priority, tos]) of
    {ok, Opts} ->
      case prim_inet:setopts(Sock, Opts) of
        ok -> ok;
        Error ->
          gen_tcp:close(Sock),
          Error
      end;
    Error ->
      gen_tcp:close(Sock),
      Error
  end.

start_client(#t_tcp_sup_options{alone = true} = Option, Sock) ->

  {ok, Child} = client_handle:start(Option, Sock),
  gen_tcp:controlling_process(Sock, Child)

.
