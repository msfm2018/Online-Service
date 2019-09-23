%%%-------------------------------------------------------------------
%%% @author wl
%%% @copyright (C) 2015, <COMPANY>
%%% @doc
%%% ebin目录为beam目录，ebin_update为更新beam放的目录  ，详见do/0
%%% @end
%%% Created : 06. 二月 2015 19:43
%%%-------------------------------------------------------------------
-module(reloader).

-include("common.hrl").
-behaviour(gen_server).

%% API
-export([
  start/1,
  start_link/0
]).
-include_lib("kernel/include/file.hrl").
-define(DEFAULT_TIME, 10).
%% gen_server callbacks
-export([init/1,
  handle_call/3,
  handle_cast/2,
  handle_info/2,
  terminate/2,
  code_change/3]).

-define(SERVER, ?MODULE).
-record(state, {
  r_time,
  m_time
}).

%%%===================================================================
%%% API
%%%===================================================================
start(Sup) ->
  case erlang:whereis(?MODULE) of
    P when is_pid(P) ->
      ok;
    _ ->
      supervisor:start_child(Sup, {reloader, {reloader, start_link, []}, permanent, infinity, worker, [reloader]})
  end.


start_link() ->
  gen_server:start_link({local, ?MODULE},  ?MODULE, [], []).


init([]) ->
  Now = erlang:localtime(),
  Time1 =3000,% utils:local_reloader_time(),%%?CONFIG(reloader_time),
%%  utils:log(["time::::::::::::::::::::::::::::++++++++++++++++++++++++++++++++++++",Time1]),
  Time = ?IF(is_integer(Time1), Time1, ?DEFAULT_TIME),
%%  ?PRINT("reloader init! the reloader time is ~p~n", [Time]),
  ?IF(Time > 0, erlang:send_after(Time, self(), auto_reload)),
  {ok, #state{m_time = Now, r_time = Time}}.



handle_call(_Request, _From, State) ->
  {reply, ok, State}.


handle_cast(_Request, State) ->
  {noreply, State}.


handle_info(auto_reload, #state{r_time = R_Time} = State) ->
  catch do(),
  erlang:send_after(R_Time, self(), auto_reload),
  {noreply, State};
handle_info(_Info, State) ->
  {noreply, State}.


terminate(_Reason, _State) ->

  ok.


code_change(_OldVsn, State, _Extra) ->
  {ok, State}.


do() ->
	EBinUpdate = "../ebin_update",
	Destination = "../ebin",
	{ok, L} = file:list_dir(EBinUpdate),
	if
		L =/= [] ->
			lists:foreach( fun(File) ->
				FileName = lists:last(string:tokens(File,"/\\")),
				file:copy(File, filename:join([Destination,FileName])),
				[ModStr, _] = string:tokens(FileName, "."),
				c:l(list_to_atom(ModStr)),
%%				?PRINT("热更模块~p~n", [ModStr]),
				file:delete(File)
			end, filelib:wildcard(filename:join([EBinUpdate,"*.beam"])) ),
			ok;
		true ->
			ok
	end,
	ok.

