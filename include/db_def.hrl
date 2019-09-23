%%%-------------------------------------------------------------------
%%% @author lzq
%%% @copyright (C) 2015, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 21. 七月 2015 13:30
%%%-------------------------------------------------------------------
-author("lzq").

-define(db_mongos, [pool_mongos_1,
                    pool_mongos_2,
                    pool_mongos_3]).

-define(DocAt(Field,Doc), bson:at(Field,Doc)).