%%%-------------------------------------------------------------------
%%% @author Administrator
%%% @copyright (C) 2016, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 07. 三月 2016 11:43
%%%-------------------------------------------------------------------
-author("Administrator").
-ifndef(SERVER_COMMON_HRL).
-define(SERVER_COMMON_HRL, true).

-define(GOODS_TYPE_MARTERIAL, 1).
-define(GOODS_TYPE_SHEET, 2).
-define(GOODS_TYPE_DRUG, 3).
-define(GOODS_TYPE_MACHINE_PARTS, 4).
-define(GOODS_TYPE_LIVING_PARTS, 5).
-define(GOODS_TYPE_LIVING, 6).
-define(GOODS_TYPE_MACHINE, 7).
-define(GOODS_TYPE_NOT_IN_BAG, 8). % 不进背包的道具，根据id特殊处理，比如加钱的道具模板id为0

-define(ATTRIBUTE_QUALITY, 1).
-define(ATTRIBUTE_LIVING_TYPE, 2).
-define(ATTRIBUTE_SPEED, 3).
-define(ATTRIBUTE_ATTACK, 4).
-define(ATTRIBUTE_DEF, 5).
-define(ATTRIBUTE_HP, 6).
-define(ATTRIBUTE_DURABLE, 7).
-define(ATTRIBUTE_LIFE, 8).
-define(ATTRIBUTE_DEF_FIRE, 9).
-define(ATTRIBUTE_DEF_ELECTROMAGNETISM, 10).
-define(ATTRIBUTE_DEF_RADIATION, 11).
-define(ATTRIBUTE_DEF_BIOCHEMISTRY, 12).
-define(ATTRIBUTE_DEF_CORROSION, 13).
-define(ATTRIBUTE_FLY, 14).
-define(ATTRIBUTE_DIVING, 15).
-define(ATTRIBUTE_PHYSICAL_STRENGTH, 16).
-define(ATTRIBUTE_LIVING_ACTIVE, 17).
-define(ATTRIBUTE_MACHINE_INTEGRITY, 18).
-define(ATTRIBUTE_VIEW, 19).
-define(ATTRIBUTE_PRODUCE_GOODS_ID, 20).
-define(ATTRIBUTE_BUJIAN_TYPE, 21).
-define(ATTRIBUTE_PET_POS_X, 22).
-define(ATTRIBUTE_PET_POS_Y, 23).
-define(ATTRIBUTE_PET_START_POS_X, 24).
-define(ATTRIBUTE_PET_START_POS_Y, 25).


-define(EVENT_TYPE_WORLD_NORMAL, 1).
-define(EVENT_TYPE_PERSON_AREA, 2).
-define(EVENT_TYPE_GROUP_AREA, 3).
-define(EVENT_TYPE_PERSON_AREA_WORLD, 4). % 广播给全世界的
-define(EVENT_TYPE_GROUP_AREA_WORLD, 5).  % 广播给全世界的
-define(EVENT_TYPE_PERIODICITY, 6).       % 周期性的事件类型

% 事件条件
-define(CONDITIONS_EVENT_TYPE, 1).
-define(CONDITIONS_EVENT_PLAYER_PARTICIPATE_CD, 2).
-define(CONDITIONS_EVENT_PET_PARTICIPATE_CD, 3).
-define(CONDITIONS_EVENT_RECEIVER_NUM, 4).
-define(CONDITIONS_EVENT_HP, 5).
-define(CONDITIONS_EVENT_RANDOM_HURT_CD, 6).
-define(CONDITIONS_EVENT_RANDOM_HURT_PROBABILITY, 7).
-define(CONDITIONS_EVENT_RANDOM_HURT_NO_PROBABILITY, 8).
-define(CONDITIONS_EVENT_RANDOM_HURT_NO_VALUE, 9).
-define(CONDITIONS_EVENT_RANDOM_HURT_FIRE_PROBABILITY, 10).
-define(CONDITIONS_EVENT_RANDOM_HURT_FIRE_VALUE_MAX, 11).
-define(CONDITIONS_EVENT_RANDOM_HURT_FIRE_VALUE_MIN, 12).
-define(CONDITIONS_EVENT_RANDOM_HURT_ELECTRIC_PROBABILITY, 13).
-define(CONDITIONS_EVENT_RANDOM_HURT_ELECTRIC_VALUE_MAX, 14).
-define(CONDITIONS_EVENT_RANDOM_HURT_ELECTRIC_VALUE_MIN, 15).
-define(CONDITIONS_EVENT_RANDOM_HURT_RADIATION_PROBABILITY, 16).
-define(CONDITIONS_EVENT_RANDOM_HURT_RADIATION_VALUE_MAX, 17).
-define(CONDITIONS_EVENT_RANDOM_HURT_RADIATION_VALUE_MIN, 18).
-define(CONDITIONS_EVENT_RANDOM_HURT_BIOCHEMISTRY_PROBABILITY, 19).
-define(CONDITIONS_EVENT_RANDOM_HURT_BIOCHEMISTRY_VALUE_MAX, 20).
-define(CONDITIONS_EVENT_RANDOM_HURT_BIOCHEMISTRY_VALUE_MIN, 21).
-define(CONDITIONS_EVENT_RANDOM_HURT_CORROSION_PROBABILITY, 22).
-define(CONDITIONS_EVENT_RANDOM_HURT_CORROSION_VALUE_MAX, 23).
-define(CONDITIONS_EVENT_RANDOM_HURT_CORROSION_VALUE_MIN, 24).
-define(CONDITIONS_EVENT_BATTLE_HURT_CD, 25).
-define(CONDITIONS_EVENT_BATTLE_HURT_PROBABILITY, 26).
-define(CONDITIONS_EVENT_BATTLE_HURT_TYPE, 27).
-define(CONDITIONS_EVENT_BATTLE_HURT_VALUE_MAX, 28).
-define(CONDITIONS_EVENT_BATTLE_HURT_VALUE_MIN, 29).


% 宠物类型
-define(PET_TYPE_LUDI, 1).
-define(PET_TYPE_FEIXING, 2).
-define(PET_TYPE_SHUISHENG, 3).
-define(PET_TYPE_KUNCHONG, 4).
-define(PET_TYPE_JIEXIE, 5).

% 21宠物部位：1躯干部件，2四肢部件，3头部部件，4尾部部件，5主体部件，6移动部件，7探测部件，8能源部件，9武器部件，10防御部件，11生物的其他部件，12机械的其他部件
-define(BUJIAN_TYPE_QUGAN, 1).
-define(BUJIAN_TYPE_SIZHI, 2).
-define(BUJIAN_TYPE_TOUBU, 3).
-define(BUJIAN_TYPE_WEIBU, 4).
-define(BUJIAN_TYPE_ZHUTI, 5).
-define(BUJIAN_TYPE_YIDONG, 6).
-define(BUJIAN_TYPE_TANCE, 7).
-define(BUJIAN_TYPE_NENGYUAN, 8).
-define(BUJIAN_TYPE_WUQI, 9).
-define(BUJIAN_TYPE_FANGYU, 10).
-define(BUJIAN_TYPE_QITA, 11).
-define(BUJIAN_TYPE_QITA_JIXIE, 12).


% 任务完成奖励类型
-define(TASK_AWARD_NEXT_TASK, 1). % 后续任务

%% 被踢下线原因
-define(KICKED_CHAOSHI, 1). % 超时

%% 获得道具来源定义
-define(TYPE_GET_GOODS_EMAIL, 1).               % 邮件中获得道具
-define(TYPE_GET_GOODS_TASK, 2).                % 新手引导获得道具
-define(TYPE_GET_GOODS_AUCTION_RETURN, 3).      % 拍卖时间到了的返回
-define(TYPE_GET_GOODS_AUCTION_BUY, 4).         % 交易行买来的物品


%% kvtable index
-define(KV_INDEX_1, 1).
-define(KV_INDEX_2, 2).


-endif.