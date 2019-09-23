%%%-------------------------------------------------------------------
%%% @author ASUS
%%% @copyright (C) 2014, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 14. 十二月 2014 下午8:04
%%%-------------------------------------------------------------------
-module(server_sup).
-author("ASUS").

-behaviour(supervisor).
-include("common.hrl").
%% API
-export([start_link/1]).

%% Supervisor callbacks
-export([init/1]).


start_link(SupName) ->
  supervisor:start_link({local, SupName}, ?MODULE, []).



init([]) ->
  {ok, {{one_for_one, 3, 10}, []}}.

