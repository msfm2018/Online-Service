-module(t_accept_sup).

-behaviour(supervisor).
-include("common.hrl").
%% API
-export([start_link/1]).

%% Supervisor callbacks
-export([init/1]).

-define(SERVER, ?MODULE).

start_link(#t_tcp_sup_options{t_client_sup_name = _Client_Sup,t_accept_sup_name = Name, alone = _Alone, call_back = _CallBack} = Option) ->
  supervisor:start_link({local,Name}, ?MODULE, [Option]).

init([Option]) ->

  SupFlags = {simple_one_for_one, 10, 10},

  AChild = {accept_handle, {accept_handle, start_link, [Option]},
    temporary, brutal_kill, worker, [accept_handle]},

  {ok, {SupFlags, [AChild]}}.

%%%===================================================================
%%% Internal functions
%%%===================================================================
