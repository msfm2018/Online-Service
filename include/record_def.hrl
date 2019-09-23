%%%-------------------------------------------------------------------
%%% @author lzq
%%% @copyright (C) 2015, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 21. 七月 2015 13:28
%%%-------------------------------------------------------------------

-define(RecordInfo(Name),record_info(fields,Name)).
-define(ToDoc(R,I),recordToDoc(R,I)).

recordToDoc(Record,RecordInfo) ->
  [_ | Values] = erlang:tuple_to_list(Record),
  ZipL = lists:zip(RecordInfo,Values),
  L = [erlang:tuple_to_list(T) || T <- ZipL],
  Doc = erlang:list_to_tuple(lists:append(L)),
  Doc
.

-record(baseinfo,{
  lv,
  money,
  exp,
  sex,
  isQQvip
}).

-record(baseAttr,{
  'STR',
  'AGI',
  'INT'
}).

-record(captain,{
  id,
  name,
  lv,
  super = false
}).

-record(data, {
  id,
  nickname,
  email,
  baseinfo = #baseinfo{},
  baseAttr = #baseAttr{},
  other1,
  other2,
  captions = [],
  questIds = [],
  bagitems = []
}).

-define(dataTodoc(Data),[
  Data#data.id,
  Data#data.nickname,
  Data#data.email,
  ?ToDoc(Data#data.baseinfo,?RecordInfo(baseinfo)),
  ?ToDoc(Data#data.baseAttr,?RecordInfo(baseAttr)),
  Data#data.other1,
  Data#data.other2,
  [?ToDoc(Cap,?RecordInfo(captain)) || Cap <- Data#data.captions],
  Data#data.questIds,
  Data#data.bagitems
]).


-record(item, {
  id,
  name,
  type,
  lv,
  color,
  templateId,
  price,
  scirpt,
  changeId
}).