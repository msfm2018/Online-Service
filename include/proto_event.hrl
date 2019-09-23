%%%---------------------------------------------
%%% 文件自动生成
%%%
%%% 模块proto_event的相关记录
%%%
%%% 请勿手动修改
%%%---------------------------------------------

-record(mod_event_eventlist_c2s, {}).

-record(mod_event_eventlist_s2c, {event_list}).
-record(mod_event_eventlist_s2c_event_conditions, {k,v}).
-record(mod_event_eventlist_s2c_event_award, {time,drop_id}).
-record(mod_event_eventlist_s2c_event_award1, {template,num}).
-record(mod_event_eventlist_s2c_list, {key,id,name,type,desc,x,y,area,start_time,end_time,participate_num,conditions,award,award1,state,camp,player_camp,player_score,limit_player_max_num,limit_event_max_times,limit_player_also_num,limit_event_also_times,wave_number_standard}).

-record(mod_event_worldeventlist_c2s, {}).

-record(mod_event_joinevent_c2s, {key}).

-record(mod_event_joinevent_s2c, {key,game_type,error_id}).

-record(mod_event_exitevent_c2s, {key}).

-record(mod_event_exitevent_s2c, {key}).

-record(mod_event_completeevent_s2c, {key}).

-record(mod_event_received_event_list_c2s, {}).

-record(mod_event_received_event_list_s2c, {event_list}).
-record(mod_event_received_event_list_s2c_list, {key}).

-record(mod_event_received_event_over_s2c, {key}).

-record(mod_event_pet_joinevent_c2s, {key}).

-record(mod_event_return_pet_c2s, {key}).

-record(mod_event_award_info_s2c, {key,list,pet_hurt_list}).
-record(mod_event_award_info_s2c_goods_list, {template,num}).
-record(mod_event_award_info_s2c_pet_list, {pet_goods_id,list}).
-record(mod_event_award_info_s2c_hurt_list, {attack_type,attack_count,hurt}).

-record(mod_event_all_award_s2c, {key,list}).
-record(mod_event_all_award_s2c_goods_list, {template,num}).

-record(mod_event_set_normal_xy_c2s, {list}).
-record(mod_event_set_normal_xy_c2s_list, {key,x,y}).

-record(mod_event_dispear_s2c, {list}).
-record(mod_event_dispear_s2c_list, {key}).

-record(mod_event_world_not_normal_id_list_c2s, {}).

-record(mod_event_world_not_normal_id_list_s2c, {id_list}).
-record(mod_event_world_not_normal_id_list_s2c_list, {id}).

-record(mod_event_ask_world_not_normal_list_c2s, {id_list}).
-record(mod_event_ask_world_not_normal_list_c2s_list, {id}).

-record(mod_event_featureeventlist_c2s, {}).

-record(mod_event_set_feature_xy_c2s, {list}).
-record(mod_event_set_feature_xy_c2s_list, {key,x,y}).

-record(mod_part_event_eventlist_c2s, {player_x,player_y}).

-record(mod_part_event_ranklist_c2s, {key}).

-record(mod_part_event_ranklist_s2c, {key,playerid,eventscore,playercamp,rank,scorelist}).
-record(mod_part_event_sumscorelist_s2c_list, {campid,scores}).
-record(mod_part_event_ranklist_s2c_list, {playerid,playerName,playerScore,playercamp}).

-record(mod_event_small_event_score_c2s, {key,playerscore}).

-record(mod_event_small_event_score_s2c, {key,playerscore}).

-record(mod_feature_id_c2s, {feature_id}).

-record(mod_feature_id_s2c, {feature_id}).

-record(mod_set_camp_evet_c2s, {key,campid}).

-record(mod_set_camp_evet_s2c, {key,campid}).

-record(mod_event_limit_info_c2s, {key}).

-record(mod_event_limit_info_s2c, {key,limit_player_max_num,limit_player_also_num,limit_event_max_times,limit_event_also_times}).

-record(mod_event_request_quest_c2s, {key,quest_id,quest_num,is_review_event}).

-record(mod_event_request_quest_s2c, {quest_id,describe,answer1,answer2,answer3,right_answer_list}).
-record(mod_event_quest_right_answer_list, {right_answer}).

-record(mod_event_request_redpacket_c2s, {key}).

-record(mod_event_request_redpacket_s2c, {key,score}).

-record(mod_event_petfondventlist_c2s, {pet_x,pet_y}).

-record(mod_event_featurevent_review_list_c2s, {}).

-record(mod_event_featurevent_review_list_s2c, {event_list}).
-record(mod_event_revieweventlist_conditions, {k,v}).
-record(mod_event_revieweventlist_award, {time,drop_id}).
-record(mod_event_revieweventlist_award1, {template,num}).
-record(mod_event_revieweventlist_s2c_event_conditions, {k,v}).
-record(mod_event_revieweventlist_s2c_event_award, {time,drop_id}).
-record(mod_event_revieweventlist_s2c_event_award1, {template,num}).
-record(mod_event_revieweventlist_s2c_list, {key,id,name,type,desc,x,y,area,start_time,end_time,participate_num,conditions,award,award1,state,camp,player_camp,player_score,limit_player_max_num,limit_event_max_times,limit_player_also_num,limit_event_also_times,wave_number_standard}).

-record(mod_event_small_featurereviewevent_score_c2s, {key,playerscore}).

-record(mod_event_small_featurereviewevent_score_s2c, {key,playerscore}).

-record(mod_event_sign_on_info_c2s, {key}).

-record(mod_event_sign_on_info_s2x, {key,selfscore,totalscore,totalplayernum}).

-record(mod_event_slidemap_fondventlist_c2s, {focus_x,focus_y}).

-record(mod_event_updata_limit_info_s2c, {key,limit_player_max_num,limit_player_also_num,limit_event_max_times,limit_event_also_times}).

-record(mod_event_collective_eventlist_s2c, {event_list}).
-record(mod_event_collective_eventlist_s2c_event_conditions, {k,v}).
-record(mod_event_collective_eventlist_s2c_event_award, {time,drop_id}).
-record(mod_event_collective_eventlist_s2c_event_award1, {template,num}).
-record(mod_event_collective_eventlist_s2c_list, {key,id,name,type,desc,x,y,area,start_time,end_time,participate_num,conditions,award,award1,state,camp,player_camp,player_score,limit_player_max_num,limit_event_max_times,limit_player_also_num,limit_event_also_times,wave_number_standard}).

