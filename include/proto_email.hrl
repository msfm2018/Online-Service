%%%---------------------------------------------
%%% 文件自动生成
%%%
%%% 模块proto_email的相关记录
%%%
%%% 请勿手动修改
%%%---------------------------------------------

-record(mod_email_id_list_c2s, {type}).

-record(mod_email_id_list_sc2, {type,id_list}).
-record(mod_email_id_list_sc2_list, {id}).

-record(mod_email_title_list_c2s, {id_list}).
-record(mod_email_title_list_c2s_list, {id}).

-record(mod_email_title_list_s2c, {id_list}).
-record(mod_email_title_list_s2c_list, {id,sender_name,type,read_flag,goods_flag,send_time,title}).

-record(mod_email_detail_c2s, {id}).

-record(mod_email_detail_s2c, {id,sender_id,content,goods_list}).
-record(mod_email_detail_s2c_goods_list, {template,num}).

-record(mod_email_delete_c2s, {id}).

-record(mod_email_delete_s2c, {id}).

-record(mod_email_delete_all_c2s, {type,status}).

-record(mod_email_delete_all_s2c, {type,status}).

-record(mod_email_get_goods_c2s, {id}).

-record(mod_email_get_goods_s2c, {id}).

-record(mod_email_get_goods_all_c2s, {}).

-record(mod_email_get_goods_all_s2c, {}).

