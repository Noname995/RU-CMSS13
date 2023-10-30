/obj/item/device/simi_chip
	name = "PK-130 SIMI programmable circuit (NOT FOR USE)"
	desc = "A programmable computer circuit used within the PK-130 SINI wrist-mounted computer to add or unlock various functions."
	icon = 'icons/obj/items/synth/bracer.dmi'
	icon_state = "simi_chip"

	/// The action this chip will add to the SIMI
	var/chip_action = /datum/action/human_action
	/// If this chip is 'secret' or not (cannot be removed/one time use)
	var/secret = FALSE

/obj/item/device/simi_chip/repair
	name = "PK-130 SIMI programmable circuit (Self-Repair)"
	chip_action = /datum/action/human_action/synth_bracer/repair_form

/obj/item/device/simi_chip/protect
	name = "PK-130 SIMI programmable circuit (Damage Bracing)"
	icon_state = "simi_chip_blue"
	chip_action = /datum/action/human_action/synth_bracer/protective_form

/*
/obj/item/device/simi_chip/fortify
	name = "PK-130 SIMI programmable circuit (Fortify)"
	chip_action = /datum/action/human_action/synth_bracer/fortify_form
*/

/obj/item/device/simi_chip/rescue_hook
	name = "PK-130 SIMI programmable circuit (Rescue Hook)"
	chip_action = /datum/action/human_action/activable/synth_bracer/rescue_hook
