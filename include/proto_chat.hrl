%%%---------------------------------------------
%%% 文件自动生成
%%%
%%% 模块proto_chat的相关记录
%%%
%%% 请勿手动修改
%%%---------------------------------------------

-record(mod_chat_zone_c2s, {type,words}).

-record(mod_chat_zone_s2c, {type,player_id,nick_name,words}).

-record(mod_chat_person_c2s, {player_id,words}).

-record(mod_chat_person_s2c, {player_id,nick_name,words}).

-record(mod_chat_person_offline_s2c, {player_id}).

-record(mod_chat_gm_command_c2s, {words}).

