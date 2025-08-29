JM_unconSpectator = true; // ACE Unconscious Spectator
    JM_unconBlurScreen = true; // Alternative to Uncon Spectator
    JM_unconMarker = true; // Markers above unconscious players
JM_Permadeath = false; // Permadeath enabled/disabled
JM_GrassCutter = true; // Player Grasscutter
JM_Safezone = false; // Safezones
JM_punishWep = true; // Punish Enemy Weapons
JM_MrkScaling = true; // Limit Marker Scaling
JM_Earplugs = true; // Player Earplugs
JM_Fortify = false; // Custom ACE Fortify
JM_Rally = true; // Rally Points
JM_tpToSL = true; // Teleport to Squad
JM_loadoutPersist = true; // Save loadouts on death
JM_arsenalRoleRestrict = true; // Restrict arsenal items based on role
JM_arsenalIdentity = true; // Show voice or face tabs in ACE arsenal
JM_StaminaOff = true; // Disable stamina?
JM_optimiseAI = true; // AI Caching

/* ************************************** CUSTOMISABLE BITS BELOW ********************************************************** */

// AI OPTIMISATION/CACHING
JM_AICacheRadius = 200; // Wake when player is in this radius
JM_AICacheSides = [east, independent]; // sides to cache

// FORTIFY
JM_engineerVehicleClass = ""; // variable name of the object that is used for construction
JM_refillObject = ""; // variable name for the object used to refill the construction object
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
        "Hair_Beard1_Brown_NG"
 
    ]],

    // ITEMS FOR EVERYONE - MAP/COMPASS/RADIO/GPS/BASIC MEDS/CIGARETTES
    ["BasicItems", [
         "ItemMap", "ItemCompass", "ItemWatch", "TFAR_anprc152", "ItemGPS", "cigs_lucky_strike_cigpack", "cigs_lighter",
         "ACE_fieldDressing", "ACE_morphine", "ACE_epinephrine", "ACE_painkillers", "ACE_splint", "ACE_tourniquet", "ACE_bloodIV", "ACE_bloodIV_250", "ACE_bloodIV_500",
         "HandGrenade_Guer", "SmokeShell",
         "ACE_CableTie"
 
    ]],

    ["Officer", [
        "hgun_esd_01_F", "muzzle_antenna_03_f", "G_Balaclava_TI_blk_F"
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
        ["ORBAT", "OPERATION AZURE SHIELD - UNA PEACKEEPING/AID REGIMENT"]
    ]],

    ["II. Situation", [
        ["SUMMARY", ""],
        ["AREA OF OPERATIONS", "Terrain: Arid flatlands and river valleys.<br/><br/>Current Weather: Clear.<br/><br/>Forecast: No change for at least the next few days."],
		["WEATHER", "Clear. Light morning fog."],
		["ENEMY FORCES", "Sporadic insurgent militias and armed tribal groups. Low strength, relying on surprise and chaos."],
        ["CIVILIANS", "Green Zone 1 and 2 are inhabited, under the control of the UN. Red Zone is inhabited, but low population. Surrounding villages are also populated with civilians."],
        ["RULES OF ENGAGEMENT", "Cleared to engage threats that present an active threat to UN personnel or civilians. Lethal force should be used with extreme caution. Avoid destruction of civilian property and infrastructure."]
    ]],

	["III. Mission", [
        ["MISSION INTENT", "To provide stability and assistance to the civilians of Sa'hatra, assisting the humanitarian mission and dealing with active threats to peace."],
		["OBJECTIVES", "OBJECTIVE 1: Conduct foot patrols of Green Zone 2 on a regular basis.<br/><br/>OBJECTIVE 2: Man the Red Zone checkpoint at all times unless instructed otherwise.<br/><br/>OBJECTIVE 3: Respond to, and deal with, active callouts across Sa'hatra.<br/><br/>OBJECTIVE 4: Maintain the peace, and assist the civilians of Green Zone 2 in any way possible."]
    ]],

	["IV. Execution", [
        ["STRATEGY OUTLINE", "You will be deploy from a staging area East of Green Zone 2.<br/><br/>You are to establish your base of operations at the existing UNA Headquarters in the centre of Green Zone 2.<br/><br/>Once you are fully operational, you are to designate your forces to the many tasks that are required of you across the Green Zone and beyond.<br/><br/>The District Commander will be responsible for the logistics and organisation of UN forces deployed across Green Zone 2 for the duration of the operation."],
		["SUPPORT", "Resupplies will be made available upon request, but are not expected to be needed."]
    ]],

    ["V. Support and Logistics", [
        ["TRANSPORTATION", "Several vehicles are available at the staging area for use at your discretion."],
        ["RESUPPLIES", "Resupplies are available at the staging area. Further resupplies can also be delivered upon request to command."],
		["REINSERTION", "Dead players will respawn at the staging area and can redploy onto an existing squad member. Rally teleporting is not avaiable for this mission."]
    ]],

	["VI. Communication", [
        ["RADIO DISTRIBUTION", "All infantry units are equipped with a 152 for short-range communication. The District Commander, and all officers have a LR for command, and all vehicle seats have a LR."],
		["FREQUENCIES", "Command Channel = LR CH 1<br/><br/>Squad Channels = SR CH 1/2/3/4/5"]
    ]]
];



// CUSTOM END TITLES FOR CUTSCENE
JM_EndTitles = [
    "The City of Sa'hatra was once destined to be Iraq's finest modern city, but the war of 2038 took a heavy toll.",
    "UN Peackeepers operating in Sa'hatra tried their best to provide aid and security to the people of the Green Zone.",
    "But a huge insurgent assault using manpower, drones and chemical weapons destroyed all hope of a successful humanitarian effort.",
    "Hundreds of UNA peacekeepers died in the chemical attacks that swept through the streets and into the surrounding fields.",
    "The chemical compound used in this attack, or its perpetrators, would remain hidden for the time being..."
];



// CUSTOM DEBRIEF text

JM_CustomDebriefText = "The UNA attempted to stabilise the situation in wartorn Sa'hatra.<br/><br/>
However, despite their best efforts, a terrorist attack of daunting scale brought UN forces to their knees.<br/><br/>
The insurgents who conducted the attack used a combination of drones, chemical weapons and ground forces to strike at the heart of Operation Azure Shield.<br/><br/>
The UN operation lies in tatters, and the city of Sa'hatra is once again a lawless land...";







// *****************************************************************************************************************************

#include "Misc\DLCParser\dlcGearRegistry.sqf"


["JM Framework Initialised"] remoteExec ["systemChat", 0, false];