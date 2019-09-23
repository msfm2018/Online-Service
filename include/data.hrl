%%%---------------------------------------------
%%% 文件自动生成
%%%
%%% 根据data.config 自动生成 record
%%%
%%% 请勿手动修改
%%%---------------------------------------------
-ifndef(DATA_HRL).
-define(DATA_HRL, true).

-record(data_city,{
    id,
    city_id,
    city_name,
    x_min,
    x_max,
    y_min,
    y_max
}).

-record(data_goods,{
    id,
    type,
    stack_flag,
    use_flag,
    transaction_flag,
    attributes
}).

-record(data_sheet,{
    goods_template_id,
    needed,
    produce
}).

-record(data_pet_sheet,{
    id,
    type,
    min,
    max
}).

-record(data_task,{
    id,
    receive_condition,
    conditions,
    award
}).

-record(data_drop,{
    drop_id,
    trigger_probability,
    drop_group_id
}).

-record(data_drop_group,{
    drop_group_id,
    goods_template_id,
    num,
    probability_max
}).

-record(data_pet_machine_repair,{
    id,
    need,
    reduce_durable
}).

-record(data_auction,{
    auction_id,
    x1,
    y1,
    x2,
    y2
}).

-record(data_achievement,{
    id,
    type,
    sub_type,
    param1,
    param2,
    param3,
    param4,
    param5,
    award,
    points,
    name
}).

-endif.