-author("Administrator").
-ifndef(SERVER_PARAM_HRL).
-define(SERVER_PARAM_HRL, true).

-define(PARAM_FULL_VIEW, 100).
-define(PARAM_CURVE_ADJUSTMENT, 1).

-record(param_fun_1, {
	pet_list,
	time_list,
	last_calc_time,
	diff_time,
	join_time,
	hp,
	def_list,
	event_award,
	participate_type,
	pet_base_cd,
	player_base_cd,
	random_hurt_cd,
	random_hurt_probability,
	random_hurt_Calculate_max,
	random_hurt_Calculate_list,
	random_hurt_type_value_list,
	battle_hurt_cd,
	battle_hurt_probability,
	battle_hurt_type,
	battle_hurt_value_min,
	battle_hurt_value_max,
	award_list = [],
	pet_be_hit_info_list = [],
	pet_hurt_info_list = [],
	temp_pet_list = [],
	current_diff_time = 0
}).

-endif.