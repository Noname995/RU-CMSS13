/datum/caste_datum/destroyer
	caste_type = XENO_CASTE_DESTROYER
	caste_desc = "The end of the line."
	tier = 1

	// All to change
	melee_damage_lower = XENO_DAMAGE_TIER_6
	melee_damage_upper = XENO_DAMAGE_TIER_8
	melee_vehicle_damage = XENO_DAMAGE_TIER_5
	max_health = XENO_HEALTH_DESTROYER
	plasma_gain = XENO_PLASMA_GAIN_TIER_3
	plasma_max = XENO_PLASMA_TIER_10
	xeno_explosion_resistance = XENO_EXPLOSIVE_ARMOR_TIER_7
	armor_deflection = XENO_ARMOR_FACTOR_TIER_5
	speed = XENO_SPEED_TIER_1

	evolves_to = null
	deevolves_to = null
	can_vent_crawl = FALSE

	behavior_delegate_type = /datum/behavior_delegate/destroyer_base

	tackle_min = 2
	tackle_max = 4

	minimap_icon = "defender"

	fire_immunity = FIRE_IMMUNITY_NO_DAMAGE

/mob/living/carbon/xenomorph/destroyer
	caste_type = XENO_CASTE_DESTROYER
	name = XENO_CASTE_DESTROYER
	desc = "A massive alien covered in spines and armoured plates."
	icon = 'icons/mob/xenos/destroyer.dmi'
	icon_size = 64
	icon_state = "Destroyer Walking"
	plasma_types = list(PLASMA_CHITIN)
	pixel_x = -16
	old_x = -16
	mob_size = MOB_SIZE_IMMOBILE
	tier = 4
	small_explosives_stun = FALSE
	counts_for_slots = FALSE
	tackle_min = 5
	tackle_max = 8
	tackle_chance = 10

	claw_type = CLAW_TYPE_VERY_SHARP
	age = -1

	base_actions = list(
		/datum/action/xeno_action/onclick/xeno_resting,
		/datum/action/xeno_action/onclick/regurgitate,
		/datum/action/xeno_action/watch_xeno,
		/datum/action/xeno_action/activable/tail_stab,
		/datum/action/xeno_action/onclick/rend,
		/datum/action/xeno_action/activable/doom,
		/datum/action/xeno_action/activable/destroy,
		/datum/action/xeno_action/onclick/destroyer_shield,
	)

	icon_xeno = 'icons/mob/xenos/destroyer.dmi'
	weed_food_states = list()
	weed_food_states_flipped = list()

/mob/living/carbon/xenomorph/destroyer/Initialize()
	. = ..()
	AddComponent(/datum/component/footstep, 2 , 35, 11, 4, "alien_footstep_large")
	RegisterSignal(src, COMSIG_MOVABLE_PRE_MOVE, PROC_REF(check_block))

/mob/living/carbon/xenomorph/destroyer/proc/check_block(mob/destroyer, turf/new_loc)
	SIGNAL_HANDLER
	for(var/mob/living/carbon/carbon in new_loc.contents)
		if(isxeno(carbon))
			var/mob/living/carbon/xenomorph/xeno = carbon
			if(xeno.hivenumber == src.hivenumber)
				xeno.KnockDown((5 DECISECONDS) / GLOBAL_STATUS_MULTIPLIER)
			else
				xeno.KnockDown((1 SECONDS) / GLOBAL_STATUS_MULTIPLIER)
		else
			if(carbon.stat != DEAD)
				carbon.apply_armoured_damage(20)
				carbon.KnockDown((1 SECONDS) / GLOBAL_STATUS_MULTIPLIER)
		
		playsound(src, 'sound/weapons/alien_knockdown.ogg', 25, 1)

/datum/behavior_delegate/destroyer_base
	name = "Base Destroyer Behavior Delegate"
