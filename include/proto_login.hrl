%%%---------------------------------------------
%%% 文件自动生成
%%%
%%% 模块proto_login的相关记录
%%%
%%% 请勿手动修改
%%%---------------------------------------------

-record(mod_login_server_c2s, {}).

-record(mod_login_server_s2c, {ip,port}).

-record(mod_login_ask_gateway_c2s, {}).

-record(mod_login_ask_gateway_s2c, {ip,port,time,verification}).

-record(mod_login_verification_c2s, {accname,password,time,verification}).

-record(mod_login_verification_s2c, {}).

-record(mod_login_register_c2s, {accname,password,time,verification}).

-record(mod_login_register_s2c, {}).

