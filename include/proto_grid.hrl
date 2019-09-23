%%%---------------------------------------------
%%% 文件自动生成
%%%
%%% 模块proto_grid的相关记录
%%%
%%% 请勿手动修改
%%%---------------------------------------------

-record(mod_grid_get_grid_list_c2s, {player_x,player_y,flag}).

-record(mod_grid_get_grid_list_s2c, {grid_list}).
-record(mod_grid_get_grid_type_c2s_list, {grid_type}).
-record(mod_grid_build_zone_c2s_list, {zone_x,zone_y}).
-record(mod_grid_get_grid_info_s2c_list, {period_stage,period_type,period_tid,period_starttime,is_who,gm,angle,durability,move_x,move_y,build_zone_list}).
-record(mod_grid_get_grid_list_s2c_list, {zone_x,zone_y,is_who,price,grid_type_list,grid_info_list}).

-record(mod_grid_plant_crop_c2s, {tid,angle,plant_list}).
-record(mod_grid_plant_c2s_list, {zone_x,zone_y}).

-record(mod_grid_plant_crop_s2c, {isplant,tid,plant_list,angle}).
-record(mod_grid_plant_s2c_list, {zone_x,zone_y}).

-record(mod_grid_harvest_crop_c2s, {grid_x,grid_y,preiod}).

-record(mod_grid_harvest_crop_s2c, {isharvest,zone_x,zone_y}).

-record(mod_grid_destroy_crop_c2s, {grid_x,grid_y,preiod}).

-record(mod_grid_destroy_crop_s2c, {isdestory,zone_x,zone_y,babygrid}).
-record(grid_xy_s2c, {zone_x,zone_y}).

-record(mod_get_pushinfo_c2s, {}).

-record(mod_get_pushinfo_s2c, {id,destoryer_name,destoryer_animal_tid,period_tid,push_type,time,num,zone_x,zone_y}).

-record(mod_grid_aoi_list_s2c, {grid_list}).
-record(mod_grid_build_zone_c2s_list1, {zone_x,zone_y}).
-record(period_info_s2c, {period_stage,period_tid,move_x,move_y,angle,build_zone_list}).
-record(mod_grid_aoi_info, {zone_x,zone_y,periodlist}).

