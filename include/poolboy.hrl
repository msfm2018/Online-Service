%%%-------------------------------------------------------------------
%%% @author lzq
%%% @copyright (C) 2015, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 15. 七月 2015 16:00
%%%-------------------------------------------------------------------
-author("lzq").

-export_type([pool/0]).

-define(TIMEOUT, 5000).

-ifdef(pre17).
-type pid_queue() :: queue().
-else.
-type pid_queue() :: queue:queue().
-endif.

-type pool() ::
Name :: (atom() | pid()) |
{Name :: atom(), node()} |
{local, Name :: atom()} |
{global, GlobalName :: any()} |
{via, Module :: atom(), ViaName :: any()}.