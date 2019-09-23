%%%-------------------------------------------------------------------
%%% @author Administrator
%%% @copyright (C) 2016, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 10. 八月 2016 16:56
%%%-------------------------------------------------------------------
-author("Administrator").
-ifndef(SERVER_ACHIEVEMENT_HRL).
-define(SERVER_ACHIEVEMENT_HRL, true).

%% 定义的{K, DefaultValue}
-define(ADK_FIRST_LOGIN_POS, {1, {0, 0}}). % 第一次登陆位置 V -> {x, y}
-define(ADK_FIRST_LOGIN_POS_DISTANCE, {2, 0}). % 距离第一次登陆位置最大距离
-define(ADK_MOVE_DISTANCE, {3, 0}). % 移动距离包含宠物
-define(ADK_MOVE_DISTANCE_SELF, {4, 0}). % 移动距离不包含宠物
-define(ADK_PRODUCE_BUJIAN_NUM, {5, []}). % 生产部件数量 2-1 V -> [{部件类型， Num}, ...]
-define(ADK_PRODUCE_QUA4_BUJIAN_NUM, {6, []}). % 生产品质为4的部件数量
-define(ADK_PRODUCE_PET, {7, 0}). % 生产宠物数量
-define(ADK_PRODUCE_TYPE_PET, {8, []}). % 生产指定类型宠物的数量 2-8
-define(ADK_COMPLETE_TYPE_EVENT, {9, []}). % 完成指定类型事件数量 3-1
-define(ADK_COMPLETE_TYPE_EVENT_SELF, {10, []}). % 自己完成指定类型事件的数量 3-3
-define(ADK_DROP_GOODS_NUM, {11, 0}). % 丢弃道具数量
-define(ADK_SELL_GOODS_NUM, {12, 0}). % 卖掉道具数量
-define(ADK_COINS_MAX, {13, 0}). % 最大有过的金钱数量
-define(ADK_SPEND_COINS, {14, 0}). % 累计花费货币数量
-define(ADK_SPEND_COINS_MAX_ONCE, {15, 0}). % 单次花费货币最大数量
-define(ADK_GET_COINS_MAX_ONEDAY, {16, {0, 0}}). % 单日获取货币最高 V -> {时间戳， num}
-define(ADK_POINTS, {17, 0}). % 成就点数
-define(ADK_ONE_DAY_MAX_COIN, {18, 0}). % 单日获得的最高记录

-record(achievement_param,{
	type,
	sub_type,
	data
}).
-endif.