JM_unconSpectator = true; // ACE Unconscious Spectator
    JM_unconBlurScreen = true; // Alternative to Uncon Spectator
    JM_unconMarker = true; // Markers above unconscious players
JM_Permadeath = false; // Permadeath enabled/disabled
JM_GrassCutter = true; // Player Grasscutter
JM_Safezone = false; // Safezones
JM_punishWep = false; // Punish Enemy Weapons
JM_MrkScaling = true; // Limit Marker Scaling
JM_Earplugs = true; // Player Earplugs
JM_Fortify = false; // Custom ACE Fortify
JM_Rally = true; // Rally Points
JM_tpToSL = false; // Teleport to Squad
JM_loadoutPersist = false; // Save loadouts on death
JM_arsenalRoleRestrict = true; // Restrict arsenal items based on role
JM_arsenalIdentity = false; // Show voice or face tabs in ACE arsenal
JM_StaminaOff = true; // Disable stamina?
JM_optimiseAI = true; // AI Caching

/* ************************************** CUSTOMISABLE BITS BELOW ********************************************************** */

// SUPPLY SPAWNER

// FORTIFY
JM_engineerVehicleClass = constructionCrate1; // variable name of the object that is used for construction
JM_refillObject = refillCrate1; // variable name for the object used to refill the construction object
JM_maxBudget = 1000; // maximum fortify budget
JM_refillBudget = 100;

JM_fortName1 = "List 1"; // Name of blueprint list in ACE interactions
JM_fortList1 = [
        		["Land_BagBunker_Small_F", 10] // list of objects + cost
   			 ]; 

JM_fortName2 = "List 2";
JM_fortList2 = [
				["Land_CzechHedgehog_01_new_F", 25]
				];


// UNCONSCIOUS SPECTATOR

// ROLE RESTRICTED ARSENAL

JM_allowedArsenalItems = [

    // GEAR FOR EVERYONE - UNIFORMS/VESTS/BACKPACKS/WEAPONS/AMMO
    ["BasicGear", [
        "Aegis_H_Helmet_FASTMT_blk_F", "Aegis_H_Helmet_FASTMT_Cover_blk_F", "Aegis_H_Helmet_FASTMT_Headset_blk_F", "JM_V_CarrierRigKBT_01_compact_*_black_F", "Rev_U_I_CDB_CombatUniform_F", "Rev_U_I_CDB_CombatUniform_shortsleeve_F",
        "U_B_CTRG_Soldier_Black_F", "U_B_CTRG_Soldier_3_Black_F", "U_B_CTRG_Soldier_2_Black_F", "B_AssaultPack_blk", "arifle_XMS_lxWS", "30Rnd_556x45_Stanag_red", "hgun_G17_black_F", "17Rnd_9x21_Mag", "ACE_NVG_Wide_Black_WP",
        "muzzle_snds_M", "Aegis_acc_pointer_DM", "optic_r1_high_lxWS", "Aegis_arifle_M4A1_short_F"
 
    ]],

    // ITEMS FOR EVERYONE - MAP/COMPASS/RADIO/GPS/BASIC MEDS/CIGARETTES
    ["BasicItems", [
         "ItemMap", "ItemCompass", "ACE_Altimeter", "TFAR_anprc152", "Rangefinder", "ItemGPS", "cigs_lucky_strike_cigpack", "cigs_lighter",
         "ACE_fieldDressing", "ACE_morphine", "ACE_epinephrine", "ACE_painkillers", "ACE_splint", "ACE_tourniquet", "G_Balaclava_light_blk_F", "G_Balaclava_light_G_blk_F", "PLA_Balaclava_Alt_Black", "PLA_Balaclava_Alt_1_Black", "CUP_G_ESS_BLK_Dark", "G_Balaclava_blk",
         "G_Balaclava_blk_lxWS", "ACE_Chemlight_HiGreen", "ACE_Chemlight_HiRed", "Aegis_SignalFlare_Green", "HandGrenade", "SmokeShell", "ACE_Flashlight_XL50", "ACE_CableTie", "B_IR_Grenade", "ACE_IR_Strobe_Item", "Chemlight_red", "Chemlight_green",
         "ACE_microDAGR"
 
    ]],
    
    ["Medic", [
        "B_Kitbag_blk", "Aegis_G_Armband_Medic_alt_F", "ACE_personalAidKit", "ACE_bloodIV", "ACE_bloodIV_250", "ACE_bloodIV_500", "ACE_morphine", "ACE_epinephrine",
        "ACE_painkillers", "ACE_splint", "ACE_tourniquet"
    ]],
    
    ["Machinegunner", [
        "MMG_01_black_F", "bipod_01_F_blk", "optic_LRCO_blk_F", "150Rnd_93x64_Mag_Red", "Aegis_acc_pointer_DM", "Aegis_MMG_FNMAG_240_F", "Aegis_200Rnd_762x51_MAG_Red_F", "JM_V_CarrierRigKBT_01_tactical_*_black_F", "B_AssaultPackSpec_blk"
    ]],

    ["Marksman", [
        "JM_V_CarrierRigKBT_01_Combat_*_black_F", "srifle_EBR_blk_lxWS", "20Rnd_762x51_Mag_blk_lxWS", "srifle_GM6_F", "optic_DMS", "Laserdesignator_04", "Aegis_acc_pointer_DM", "H_Cap_headphones_blk", "H_Booniehat_blk", "optic_Nightstalker", "5Rnd_127x108_Mag", "B_AssaultPackSpec_blk",
        "bipod_01_F_blk"
    ]],

    ["Grenadier", [
        "JM_V_CarrierRigKBT_01_tactical_*_black_F", "B_AssaultPackSpec_blk", "arifle_XMS_GL_lxWS", "1Rnd_HE_Grenade_shell", "1Rnd_Smoke_Grenade_shell", "1Rnd_RC40_shell_RF", "UGL_FlareWhite_F", "UGL_FlareRed_F", "UGL_FlareGreen_F", "UGL_FlareCIR_F", "ACE_40mm_Flare_red", "ACE_40mm_Flare_green", "1Rnd_RC40_shell_RF"
    ]],

    ["Squad Leader", [
        "arifle_XMS_M_lxWS", "FRXA_tf_rt1523g_Black", "B_RadioBag_01_black_F", "JM_V_CarrierRigKBT_01_command_*_black_F", "Laserdesignator_04", "Aegis_optic_ACOG"
    ]],

    ["UAV Operator", [
        "JM_V_CarrierRigKBT_01_Combat_*_black_F", "B_UavTerminal", "ACE_UAVBattery", "Aegis_B_patrolBackpack_blk_F", "Laserdesignator_04"
    ]],

    ["Light AT", [
        "JM_V_CarrierRigKBT_01_tactical_*_black_F", "launch_PSRL1_black_RF", "PSRL1_AT_RF", "PSRL1_FRAG_RF", "B_Carryall_blk"
    ]],

    ["Operator", [
        "muzzle_snds_M", "optic_r1_high_lxWS", "Aegis_muzzle_snds_9MM_enhanced_black" 
    ]],

    ["Breacher", [
        "arifle_XMS_Shot_lxWS", "muzzle_snds_M", "optic_r1_high_lxWS", "Aegis_muzzle_snds_9MM_enhanced_black", "6Rnd_12Gauge_Pellets", "sgun_Mp153_black_F", "4Rnd_12Gauge_Pellets", "JM_V_CarrierRigKBT_01_CQB_*_black_F", "ACE_M84", "ItemMotionSensor_lxWS"
    ]]
];

// MOTOR POOL SETUP
JM_Garage = [
    ["B_MRAP_01_F", "Hunter MRAP", 3],
    ["B_APC_Wheeled_01_cannon_F", "Marshall APC", 1],
    ["B_Truck_01_transport_F", "HEMTT Transport", -1],
    ["B_T_Truck_01_flatbed_F", "HEMTT Transport", 2],
    ["B_Heli_Attack_01_dynamicLoadout_F", "RH-66 Commanche", 1],
    ["B_Plane_Fighter_01_F", "FA-18 Black Wasp", -1]
];



// MARKER SIZE 

JM_scaleMrkrs = []; // Array of markers that will NOT be scaled on the map


// SAFEZONES

JM_safeZones = [["safezone1", 50]]; // Syntax: [["marker1", radius1], ["marker2", radius2], ...]
JM_safeMsg = "FIRING IS PROHIBITED IN THIS AREA"; // The message that shows when a player shoots or throws a grenade

// BRIEFING DIARY ENTRIES

JM_BriefingContent = [
    ["I. Organisation", [
        ["ORBAT", "Task Force Misfit - Black Ops Platoon<br/><br/>Command/Support Squad - Spectre<br/>Assault Squad - Talon-1<br/>Assault Squad - Talon-2"]
    ]],

    ["II. Situation", [
        ["SUMMARY", ""],
        ["AREA OF OPERATIONS", "Terrain: Temperate foothills. Semi-tropical coastline.<br/><br/>Current Weather: Overcast.<br/><br/>Forecast: No change for at least the next few days."],
		["WEATHER", "Overcast. Small chance of light rain. No change expected."],
		["ENEMY FORCES", "Division strength, well-armed trained militia. Light armour, recon vehicles. Limited air assets. Low probability of minefields and fortifications except temporary positions."],
        ["FRIENDLY FORCES", "No friendly units are in the vicinity."],
        ["CIVILIANS", "High probability of civilians in urban areas."],
        ["RULES OF ENGAGEMENT", "Fire at will. Clear to engage uniformed and armed personnel. Avoid destruction of civilian property if possible."]
    ]],

	["III. Mission", [
        ["MISSION INTENT", "The Misfits are tasked with locating and rescuing three researchers being held hostage by Golden Sands Militia forces."],
		["OBJECTIVES", "OBJECTIVE 1: Perform a HALO drop into the DZ <br/><br/>OBJECTIVE 2: Locate and secure the three hostages<br/><br/>OBJECTIVE 3: Move to the designated exfil site and extract hostages"]
    ]],

	["IV. Execution", [
        ["STRATEGY OUTLINE", "You will be deployed onto the south-western hills of the city of Paraiso. From there you are expected to progress towards the town, and begin your search for the hostages.<br/><br/>Once located, you are expected to secure the hostages, neutralising any threats in your way.<br/><br/>On completion of your primary objective, you will proceed to the designated exfil site at Ambergris and await extraction."],
		["SUPPORT", "An MQ-9A Reaper drone will become available for tasking part-way through the operation. Air Support is not available."]
    ]],

    ["V. Support and Logistics", [
        ["TRANSPORTATION", "Insertion and Extraction will be performed by a V-44 Blackfish, callsign CONDOR."],
        ["RESUPPLIES", "Resupplies unavailable due to the presence of enemy AA emplacements and lack of airspace control."],
		["REINSERTION", "Dead players will respawn at the staging area and can travel to a rally."]
    ]],

	["VI. Communication", [
        ["RADIO DISTRIBUTION", "All infantry units are equipped with a 152 for short-range communication. PL and SLs are equipped with a 117F for long-range communication."],
		["FREQUENCIES", "Command Channel = LR CH 1<br/><br/>Squad Channels = SR CH 1/2/3/4/5"]
    ]]
];



// CUSTOM END TITLES FOR CUTSCENE
JM_EndTitles = [
    "The Misfits successfully located and secured two out of the three hostages.",
    "Unfortunately, the third researcher was not able to be rescued.",
    "Prior to the assault, it appears the final researcher had been moved to an undisclosed location.",
    "For now, the Misfits can relax after their first combat action since reactivation..."
];



// CUSTOM DEBRIEF text

JM_CustomDebriefText = "The Misfits assaulted the city of Paraiso after learning the location of the JOINTCOM researchers.<br/><br/>
The researchers were being held hostage by a rogue PMC/Militia known as Golden Sands. What exactly Golden Sands were doing with the researchers is unclear, except that this stop in Sahrani was temporary.<br/><br/>
Unfortunately, the Lead Researcher - Ivan Thirsk - was moved by Golden Sands to an undisclosed location shortly before the Misfits began their operation. Because of this, the Misfits were unable to locate his whereabouts and secure him.<br/><br/>
However, Task Force Misfit has proven itself effective on their first outing since reactivation...";







// *****************************************************************************************************************************

#include "Misc\DLCParser\dlcGearRegistry.sqf"


["JM Framework Initialised"] remoteExec ["systemChat", 0, false];