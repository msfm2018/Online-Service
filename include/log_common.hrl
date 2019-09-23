%%%-------------------------------------------------------------------
%%% @author ASUS
%%% @copyright (C) 2014, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 14. 十二月 2014 下午5:09
%%%-------------------------------------------------------------------
-author("ASUS").
-ifndef(LOG_COMMON_HRL).
-define(LOG_COMMON_HRL, true).

-define(TEST_MSG(Format), logger:test_msg(?MODULE,?LINE,Format, [])).
-define(TEST_MSG(Format, Args), logger:test_msg(?MODULE,?LINE,Format, Args)).
-define(DEBUG(Format), logger:debug_msg(?MODULE,?LINE,Format, [])).
-define(DEBUG(Format, Args), logger:debug_msg(?MODULE,?LINE,Format, Args)).
-define(INFO_MSG(Format), logger:info_msg(?MODULE,?LINE,Format, [])).
-define(INFO_MSG(Format, Args), logger:info_msg(?MODULE,?LINE,Format, Args)).
-define(WARNING_MSG(Format), logger:warning_msg(?MODULE,?LINE,Format, [])).
-define(WARNING_MSG(Format, Args), logger:warning_msg(?MODULE,?LINE,Format, Args)).
-define(ERROR_MSG(Format), logger:error_msg(?MODULE,?LINE,Format, [])).
-define(ERROR_MSG(Format, Args), logger:error_msg(?MODULE,?LINE,Format, Args)).
-define(CRITICAL_MSG(Format), logger:critical_msg(?MODULE,?LINE,Format,[])).
-define(CRITICAL_MSG(Format, Args), logger:critical_msg(?MODULE,?LINE,Format,Args)).

-define(E(Msg), ?ERROR_MSG("~p~n", [Msg])).

%% 调试
-ifdef(debug).
-define(PRINT(A),
  begin
    io:format(A)
  end).
-define(PRINT(Format, Args),
  begin
    io:format(Format, Args)
  end).
-else.
-define(PRINT(_A), ok).
-define(PRINT(_Format, _Args), ok).
-endif.

-endif.