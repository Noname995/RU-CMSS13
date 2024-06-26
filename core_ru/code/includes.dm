//RUCM CORE INCLUDES
#include "supplyshuttle.dm"
#include "__HELPERS\text.dm"
#include "_globalvars\global_lists.dm"
#include "_globalvars\misc.dm"
#include "controllers\subsystem\who.dm"
#include "datums\skills.dm"
#include "datums\ammo\tank.dm"
#include "datums\ammo\xeno.dm"
#include "datums\ammo\bullet\pistol.dm"
#include "datums\ammo\bullet\revolver.dm"
#include "datums\ammo\bullet\rifle.dm"
#include "datums\ammo\bullet\smg.dm"
#include "datums\supply_packs\ammo.dm"
#include "datums\supply_packs\gear.dm"
#include "datums\supply_packs\weapons.dm"
#include "game\area\DockRed.dm"
#include "game\area\KhamiBarrens.dm"
#include "game\area\rumayer.dm"
#include "game\gamemodes\game_mode.dm"
#include "game\gamemodes\colonialmarines\colonialmarines.dm"
#include "game\gamemodes\colonialmarines\crash.dm"
#include "game\gamemodes\colonialmarines\crash\equipping.dm"
#include "game\gamemodes\colonialmarines\crash\gear.dm"
#include "game\jobs\role_authority.dm"
#include "game\jobs\job\command\auxiliary\mech_crew.dm"
#include "game\jobs\job\command\auxiliary\tankcrew.dm"
#include "game\jobs\job\marine\squads.dm"
#include "game\jobs\job\marine\squad\engineer.dm"
#include "game\jobs\job\marine\squad\leader.dm"
#include "game\jobs\job\marine\squad\medic.dm"
#include "game\jobs\job\marine\squad\smartgunner.dm"
#include "game\jobs\job\marine\squad\specialist.dm"
#include "game\jobs\job\marine\squad\tl.dm"
#include "game\machinery\nuclearbomb.dm"
#include "game\machinery\nuke_disk_generator.dm"
#include "game\machinery\rechargestation.dm"
#include "game\machinery\doors\poddoor.dm"
#include "game\objects\items\devices\pinpointer.dm"
#include "game\objects\items\storage\belt.dm"
#include "game\objects\items\storage\briefcase.dm"
#include "game\objects\items\storage\pouch.dm"
#include "game\objects\items\weapons\st_equip.dm"
#include "game\objects\items\weapons\st_hammer_stacks.dm"
#include "game\turfs\closed.dm"
#include "modules\\clothing\suits\marine_armor\_marine_armor.dm"
#include "modules\cm_aliens\structures\sunken_colony.dm"
#include "modules\cm_aliens\structures\special\pylon_core.dm"
#include "modules\cm_tech\comms_income.dm"
#include "modules\cm_tech\tech_tiers.dm"
#include "modules\cm_tech\techtree.dm"
#include "modules\cm_tech\techs\abstract\item_droppod.dm"
#include "modules\cm_tech\techs\abstract\powerups_xeno.dm"
#include "modules\cm_tech\techs\abstract\tech_droppod.dm"
#include "modules\cm_tech\techs\abstract\tech_xeno.dm"
#include "modules\cm_tech\techs\abstract\transitory.dm"
#include "modules\cm_tech\techs\marine\tier1\barrel_charger_upgrade.dm"
#include "modules\cm_tech\techs\marine\tier1\engi_upgrade_mod.dm"
#include "modules\cm_tech\techs\marine\tier1\medic_upgrade_qol.dm"
#include "modules\cm_tech\techs\marine\tier1\mod_armor.dm"
#include "modules\cm_tech\techs\marine\tier2\enhanced_antibiologicals.dm"
#include "modules\cm_tech\techs\marine\tier2\tank.dm"
#include "modules\cm_tech\techs\marine\tier2\walker.dm"
#include "modules\cm_tech\techs\marine\tier3\combat_implants.dm"
#include "modules\cm_tech\techs\marine\tier3\experimentals.dm"
#include "modules\cm_tech\techs\xeno\tier1\blockade.dm"
#include "modules\cm_tech\techs\xeno\tier1\build_for_all.dm"
#include "modules\cm_tech\techs\xeno\tier1\comms_disruption.dm"
#include "modules\cm_tech\techs\xeno\tier2\evo_boost.dm"
#include "modules\cm_tech\techs\xeno\tier2\fireres.dm"
#include "modules\cm_tech\techs\xeno\tier2\overshield.dm"
#include "modules\cm_tech\techs\xeno\tier2\shielding_slash.dm"
#include "modules\cm_tech\techs\xeno\tier2\teleport_beacon.dm"
#include "modules\cm_tech\techs\xeno\tier3\acid_blood.dm"
#include "modules\cm_tech\techs\xeno\tier3\artillery_blob.dm"
#include "modules\cm_tech\techs\xeno\tier3\endurance.dm"
#include "modules\cm_tech\techs\xeno\tier3\rev_jelly.dm"
#include "modules\cm_tech\techs\xeno\tier4\health_up.dm"
#include "modules\cm_tech\trees\xeno.dm"
#include "modules\gear_presets\usmc.dm"
#include "modules\mob\mod_defines.dm"
#include "modules\mob\say.dm"
#include "modules\mob\living\carbon\human\emote.dm"
#include "modules\mob\living\carbon\human\species\working_joe\russian.dm"
#include "modules\mob\living\carbon\xenomorph\hive_status.dm"
#include "modules\mob\living\carbon\xenomorph\xeno_helpers.dm"
#include "modules\mob\living\carbon\xenomorph\xeno_verbs.dm"
#include "modules\mob\living\carbon\xenomorph\abilities\queen\queen_abilities.dm"
#include "modules\mob\living\carbon\xenomorph\abilities\spitter\spitter_abilities.dm"
#include "modules\mob\living\carbon\xenomorph\abilities\spitter\spitter_powers.dm"
#include "modules\mob\living\carbon\xenomorph\strains\behavior_delegate.dm"
#include "modules\mob\living\carbon\xenomorph\strains\castes\lurker\stalker.dm"
#include "modules\mob\living\carbon\xenomorph\strains\castes\spitter\suppressor.dm"
#include "modules\objectives\communications.dm"
#include "modules\projectiles\gun_attachables.dm"
#include "modules\projectiles\magazines\magazines_assorted.dm"
#include "modules\shuttle\gamemodes\crash.dm"
#include "modules\vehicles\hardpoints_walker.dm"
#include "modules\vehicles\walker.dm"
#include "modules\vehicles\walker_vendor.dm"
#include "modules\vehicles\walker_verbs.dm"
#include "modules\vehicles\multitile\multitile_verbs.dm"
#include "modules\vehicles\multitile\multitile.dm"
#include "modules\vehicles\multitile\apc\apc.dm"
#include "modules\vehicles\multitile\hardpoints\holder\tank_turret.dm"
#include "modules\vehicles\multitile\hardpoints\support\smoke.dm"
#include "modules\vehicles\multitile\tank\tank.dm"
