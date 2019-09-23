%%%---------------------------------------------
%%% 文件自动生成
%%%
%%% 模块proto_auction的相关记录
%%%
%%% 请勿手动修改
%%%---------------------------------------------

-record(mod_auction_get_auction_id_list_c2s, {}).

-record(mod_auction_get_auction_id_list_s2c, {default_id,auction_id_list}).
-record(mod_auction_get_auction_id_list_s2c_list, {id}).

-record(mod_auction_get_auction_page_c2s, {id,page,time}).

-record(mod_auction_get_auction_page_s2c, {id,page,time,all_page_count,list}).
-record(mod_auction_get_auction_page_s2c_list, {template_id,min_price,all_count}).

-record(mod_auction_get_template_page_c2s, {id,template_id,time}).

-record(mod_auction_get_template_page_s2c, {id,time,template_id,list}).
-record(mod_auction_get_template_page_s2c_list, {record_id,price,count}).

-record(mod_auction_get_record_detail_c2s, {id,record_id,template_id}).

-record(mod_auction_get_record_detail_s2c, {id,record_id,template_id,list}).
-record(mod_auction_get_record_detail_s2c_attribute_list, {key,value}).

-record(mod_auction_sell_c2s, {id,goods_id,num,price,time}).

-record(mod_auction_sell_s2c, {result}).

-record(mod_auction_cancel_sell_c2s, {id,record_id}).

-record(mod_auction_cancel_sell_s2c, {list}).
-record(mod_auction_cancel_sell_s2c_list, {id,record_id}).

-record(mod_auction_self_record_c2s, {}).

-record(mod_auction_self_record_s2c, {list}).
-record(mod_auction_self_record_s2c_list, {auction_id,record_id,start_time,end_time,template,num,price}).

-record(mod_auction_buy_c2s, {auction_id,record_id,num}).

-record(mod_auction_buy_s2c, {result}).

