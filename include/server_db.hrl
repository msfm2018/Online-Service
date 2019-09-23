%%%-------------------------------------------------------------------
%%% @author Administrator
%%% @copyright (C) 2016, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 02. 二月 2016 17:04
%%%-------------------------------------------------------------------
-author("Administrator").
-ifndef(SERVER_DB_HRL).
-define(SERVER_DB_HRL, true).

-define(TABLE_PLAYER, player).
-define(TABLE_PLAYER_ALL_FIELDS, "player_id,nick_name,x,y,sign,lv,exp,coin,mileage,city_id,city_name,addr,pwd,pet1,pet2,pet3,pet4,pet5,pet6,chat_time1,chat_time2,chat_time3,sheet_list").
-record(table_player, {
  player_id,
  nick_name,
  x,
  y,
  sign,
  lv,
  exp,
  coin,
  mileage,
  city_id,
  city_name,
  addr,
  pwd,
  pet1,
  pet2,
  pet3,
  pet4,
  pet5,
  pet6,
  chat_time1,
  chat_time2,
  chat_time3,
	sheet_list
}).

-define(TABLE_EVENT, event).
-define(TABLE_EVENT_ALL_FIELDS, "id,type,x,y,area,start_time,end_time,continued_time,participate_num,conditions,award,name,description,account,status,award1,title_id,zone_type").
-record(table_event, {
  id,
  type,
  x,
  y,
  area,
  start_time,
  end_time,
  continued_time,
  participate_num,
  conditions,
  award,
  name,
  description,
  account,
  status,
  award1,
  title_id,
  zone_type
}).

-define(TABLE_GOODS, goods).
-define(TABLE_GOODS_ALL_FIELDS, "id,player_id,type_id,get_time,attributes,num,dispatch_eventid,dispatch_event_time,dispatch_time,key_event").
-record(table_goods, {
  id,
  player_id,
  type_id,
  get_time,
  attributes,
  num,
  dispatch_eventid = 0,
  dispatch_event_time = 0,
  dispatch_time = 0,
  key_event = ""
}).

-define(TABLE_PLAYER_EVENT, player_event).
-define(TABLE_PLAYER_EVENT_ALL_FIELDS, "player_id,received_event,found_event").
-record(table_player_event, {
  player_id,
  received_event,
  found_event
}).


-define(TABLE_PLAYER_TASK, player_task).
-define(TABLE_PLAYER_TASK_ALL_FIELDS, "player_id,task").
-record(table_player_task, {
  player_id,
  task
}).

-define(TABLE_PLAYER_EMAIL, player_email).
-define(TABLE_PLAYER_EMAIL_ALL_FIELDS, "player_id,email").
-record(table_player_email, {
  player_id,
  email
}).

-define(TABLE_EMAIL, email).
-define(TABLE_EMAIL_ALL_FIELDS, "receiver_id,sender_id,sender_name,type,title,content,goods,send_time,goods_flag,read_flag,param").
-record(table_email,{
  receiver_id,
  sender_id,
  sender_name,
  type,
  title,
  content,
  goods,
  send_time,
  goods_flag,
  read_flag,
	param
}).
% table_email中param参数eep 事件的一些东西
-record(eep, {
	event_id,
	start_time,
	hurt_list
}).
% table_email中param参数change_auction_record 拍卖相关的一些东西
-record(change_auction_record,{
	auction_id,
	record_id,
	new_num % 如果为0 那么用户删除掉即可
}).

-define(TABLE_AUCTION, auction).
-define(TABLE_AUCTION_ALL_FIELDS, "auction_id, record_id, record").
-record(table_auction, {
	auction_id,
	record_id,
	record  % #stack_record或者#unstack_record
}).
-record(stack_record, {
	record_id,
	player_id,
	player_record_id,
	template_id,
	num,
	time,
	end_time,
	price
}).
-record(unstack_record, {
	record_id,
	player_id,
	player_record_id,
	goods, % table_goods
	time,
	end_time,
	price
}).

-define(TABLE_PLAYER_AUCTION, player_auction).
-define(TABLE_PLAYER_AUCTION_ALL_FIELDS, "player_id,auction_record").
-record(table_player_auction, {
	player_id,
	auction_record  % [#pae{}, ...]
}).
-record(pae, {
	auction_id,
	record  % #stack_record或者#unstack_record
}).
-record(pre, {
	auction_id,
	player_record_id,
	record  % #stack_record或者#unstack_record
}).

-define(TABLE_PLAYER_ACHIEVEMENT, player_achievement).
-define(TABLE_PLAYER_ACHIEVEMENT_ALL_FIELDS, "player_id,completed_achievement,achievement_data").
-record(table_player_achievement, {
	player_id,
	completed_achievement,
	achievement_data
}).

-endif.