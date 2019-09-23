%%%---------------------------------------------
%%% 文件自动生成
%%%
%%% 模块proto_player的相关记录
%%%
%%% 请勿手动修改
%%%---------------------------------------------

-record(mod_player_ask_gateway_c2s, {countrycode,citycode}).

-record(mod_player_ask_gateway_s2c, {ip,port}).

-record(mod_player_login_c2s, {id,pwd,token,x,y}).

-record(mod_player_login_s2c, {}).

-record(mod_player_regist_c2s, {id,name,pwd,camp_id,gm}).

-record(mod_player_regist_s2c, {}).

-record(mod_player_setgps_c2s, {x,y}).

-record(mod_player_setuserdata_c2s, {citycode,cityname,address}).

-record(mod_player_alluser_c2s, {}).

-record(mod_player_alluser_s2c, {user_list}).
-record(mod_player_alluser_s2c_list, {id,name,x,y,citycode,cityname,address}).

-record(mod_player_ask_self_data_c2s, {}).

-record(mod_player_ask_self_data_s2c, {id,name,x,y,citycode,cityname,address,mileage,lv,exp,coin,sign,pet1,pet2,pet3,pet4,pet5,pet6,feature_id,camp_id}).

-record(mod_player_sync_time_c2s, {}).

-record(mod_player_sync_time_s2c, {time}).

-record(mod_player_sync_coin_s2c, {coin}).

-record(mod_player_min_camp_id_s2c, {camp_id}).

-record(mod_player_attrlist_c2s, {}).

-record(mod_player_attrlist_s2c, {attr_list}).
-record(mod_player_attrlist_s2c_list, {type,num}).

-record(mod_player_errno_s2c, {error_id}).

-record(mod_player_herat_c2s, {}).

