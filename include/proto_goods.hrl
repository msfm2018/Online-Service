%%%---------------------------------------------
%%% 文件自动生成
%%%
%%% 模块proto_goods的相关记录
%%%
%%% 请勿手动修改
%%%---------------------------------------------

-record(mod_goods_allgoodslist_c2s, {}).

-record(mod_goods_allgoodslist_s2c, {goods_list}).
-record(mod_goods_allgoodslist_s2c_list, {id,template,num,equipped_id}).

-record(mod_goods_goods_detail_c2s, {id}).

-record(mod_goods_goods_detail_s2c, {id,template,get_time,num,key,dispatch_starttime,dispatch_time,attributes_list}).
-record(mod_goods_goods_detail_s2c_attribute, {key1,key2,value}).

-record(mod_goods_delete_c2s, {id}).

-record(mod_goods_delete_s2c, {id}).

-record(mod_goods_add_s2c, {id,template}).

-record(mod_goods_produce_c2s, {sheet_id}).

-record(mod_goods_produce_s2c, {error_id}).

-record(mod_goods_produce_pet_c2s, {style,id1,id2,id3,id4,id5}).

-record(mod_goods_produce_pet_s2c, {error_id}).

-record(mod_goods_dispatch_pet_c2s, {key,x,y,time,pet_pos_list}).
-record(mod_goods_dispatch_pet_c2s_pet_pos_list, {pet}).

-record(mod_goods_pet_up_c2s, {pet,goods_id1,goods_id2}).

-record(mod_goods_pet_up_s2c, {pet,goods_id1,goods_id2}).

-record(mod_goods_undispatch_pet_c2s, {pet}).

-record(mod_goods_attribute_change_s2c, {list}).
-record(mod_goods_attribute_change_s2c_list, {goods_id,attributes_list}).
-record(mod_goods_attribute_change_s2c_attribute_list, {key,value}).

-record(mod_goods_use_c2s, {goods_id}).

-record(mod_goods_produce_sheet_c2s, {}).

-record(mod_goods_produce_sheet_s2c, {list}).
-record(mod_goods_produce_sheet_s2c_list, {goods_template_id}).

