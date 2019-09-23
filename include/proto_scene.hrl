%%%---------------------------------------------
%%% 文件自动生成
%%%
%%% 模块proto_scene的相关记录
%%%
%%% 请勿手动修改
%%%---------------------------------------------

-record(mod_scene_new_player_s2c, {player_list}).
-record(mod_scene_new_player_s2c_player_list, {accname,job,x,y,weapon}).

-record(mod_scene_del_player_s2c, {player_list}).
-record(mod_scene_del_player_s2c_player_list, {accname}).

-record(mod_scene_move_xy_c2s, {rx,ry,dx,dy}).

-record(mod_scene_move_xy_s2c, {accname,rx,ry,dx,dy}).

-record(mod_scene_jump_c2s, {accname}).

-record(mod_scene_jump_s2c, {accname}).

