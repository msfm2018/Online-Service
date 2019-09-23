-module(entry).
-author("Administrator").
-include("common.hrl").
-compile(export_all).

start(AppList) ->
  spawn(fun() ->
    start_app(sasl),
    lists:foreach(fun(App) -> start_app(App) end, AppList)
  end).

start_app(A) ->
  case application:start(A) of
    ok ->
      ok;
    {error, {already_started, _}} -> ok;
    {error, _R} ->
%%      ?PRINT("start app ~p error  reason is ~p~n ", [A, _R]),
      throw({A, _R, application_start_error})
  end.
