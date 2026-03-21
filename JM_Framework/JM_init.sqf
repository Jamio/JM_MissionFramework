// ==================================================================================================================================
// JM FRAMEWORK INITIALISATION
// Mission maker configuration hub - use this to edit the bits of the framework you want for your missions
// ==================================================================================================================================



// ==================================================================================================================================
// JM VARIABLE TOGGLES
// Edit this section to toggle entire modules on or off
// ==================================================================================================================================

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
JM_TicketsMedevac = false; // Use ticket respawns with bodybag replenishment
JM_JTAC = false; //initialise the JTAC system
JM_CBRN_enabled = false; // Enable CBRN system






// ==================================================================================================================================
// MODULE CONFIGURATION
// Edit this section to customise the functionality of specific modules
// ==================================================================================================================================



// ----------------------------------------------------------------------------------------------------------------------------------
// AI CACHING SYSTEM
// ----------------------------------------------------------------------------------------------------------------------------------
JM_AICacheRadius = 200; // Wake when player is in this radius
JM_AICacheSides = [east, independent]; // sides to cache

// ----------------------------------------------------------------------------------------------------------------------------------
// FORTIFY SYSTEM
// ----------------------------------------------------------------------------------------------------------------------------------
JM_engineerVehicleClass = "";  // variable name of the object that is used for construction
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


// ----------------------------------------------------------------------------------------------------------------------------------
// TICKETS MEDEVAC SYSTEM
// ----------------------------------------------------------------------------------------------------------------------------------
JM_TicketsPoolStart = 10;                       // starting tickets
JM_TicketsPoolMax = 30;                         // -1 = unlimited
JM_TicketsCostPerRespawn = 1;                   // usually 1 ticket per respawn
JM_TicketsPerBag = 1;                           // tickets awarded per submitted player bodybag
JM_TicketsDeleteBag = true;                     // whether or not to delete the bodybag object on submission
JM_TicketsDropoffObjects = ["medpost_crate"];   // Eden variable names (strings)
JM_TicketsZoneMarker = "mrk_medpost";           // marker name; "" to use object position 
JM_TicketsZoneRadius = 10;
JM_TicketsSubmitCooldown = 8;
JM_TicketsNotify = true;



// ----------------------------------------------------------------------------------------------------------------------------------
// JTAC SYSTEM
// ----------------------------------------------------------------------------------------------------------------------------------
JM_JTAC_UseEPDDefaults = false; // Use EPD default attacks in addition to JM ones
JM_JTAC_theme = "Modern"; // "Modern", "ww2" or "scifi"
JM_JTAC_FireMissions = [

/*
================================================================================
JM JTAC FIRE MISSION EXAMPLES
================================================================================

FORMAT

[
    "uniqueID",
    "Display Name",
    "Category",
    "EPD_Function_Name",
    [EPD parameters],
    requiresIngress,
    etaSeconds,
    cooldownSeconds,
    capacityUses,
    delaySeconds,
    "optionalFlyoverVehicle"
]

uniqueID              : unique identifier
Display Name          : shown in JTAC dialog
Category              : used by EPD reload timers (CAS, MORTAR, BOMB etc) - irrelevant, ignore for now just put something here to satisfy the arma gods
EPD_Function_Name     : the EPD firing function to execute - see the examples
[EPD parameters]      : parameters required by that function
requiresIngress       : whether attack direction must be selected
etaSeconds            : eta base
cooldownSeconds       : time before mission can be used again
capacityUses          : number of uses allowed for this mission (e.g. number of missiles, or -1 for unlimited)
delaySeconds          : delay before strike begins
optionalFlyoverVehicle: aircraft spawned for visual flyover ("" = none)

--------------------------------------------------------------------------------
CAS ROCKET STRIKE
--------------------------------------------------------------------------------
STRAFING_RUN_ROCKET params:
[_projectileClassName, _numberToSend, _horizontalDistance, _pitch, _pitchVariance, _yawVariance, _minTimeBetween, _maxRandomTime]

["cas_rockets","CAS Rocket Strike","CAS","STRAFING_RUN_ROCKET", ["Rocket_04_HE_F", 6, 50, 3000, -20.467, 6, .1, .2], false, 12, 120, 3, 10, "ddx_nato_a164"],

--------------------------------------------------------------------------------
CAS GUN STRAFE
--------------------------------------------------------------------------------
STRAFING_RUN_PROJECTILE params:
[ammoClass, numberOfRounds, verticalOffset, runLength, spread, minTimeBetween, maxRandomTime]

["cas_strafe","CAS Gun Run","CAS","STRAFING_RUN_PROJECTILE",["B_30mm_HE",80,105.6,200,25,0.005,0.005], false, 10, 120, 3, 8, "ddx_nato_a164"],

--------------------------------------------------------------------------------
BOMB STRIKE
--------------------------------------------------------------------------------
DROP_BOMBS params:
[ammoClass, numberOfBombs, aircraftDistance, pitch, spread, minTimeBetween, maxRandomTime]

["bomb_strike","500lb Bomb Strike","BOMB","DROP_BOMBS",["Bomb_03_F",1,250,1,15,0,0], true, 20, 300, 2, 10, "ddx_nato_a164"],


--------------------------------------------------------------------------------
ARTILLERY / MORTAR BARRAGE
--------------------------------------------------------------------------------
SHOOT_PROJECTILES params:
[projectileClass, verticalOffset, rounds, spreadRadial, spreadNormal, minTimeBetween, maxRandomTime]

["arty_155","155mm Artillery Barrage","MORTAR","SHOOT_PROJECTILES", ["Sh_155mm_AMOS",5,8,120,10,0.5,1], false, 20, 180, 4, 5,""],

["smoke_82","82mm Smoke Barrage","MORTAR","SHOOT_PROJECTILES", ["Smoke_82mm_AMOS_White",5,8,120,10,0.5,1], false, 20, 180, 4, 5, ""],


--------------------------------------------------------------------------------
MINE DEPLOYMENT STRIKE
--------------------------------------------------------------------------------
LAY_MINE_FIELD params:
[[array of mineClasses], numberToDrop, spreadRadius, minTimeBetween, maxRandomTime]

["minefield","Minefield Deployment","CAS","LAY_MINE_FIELD", [["ATMine"], 12, 60, 0.1, 0.1], false, 10, 300, 2, 5, ""],



 */

// BOMB STRIKE
["bomb","TEST CAS Bomb Drop","BOMB","DROP_BOMBS", ["Bomb_03_F", 1, 223.5, 1, 10, 0, 0], false, 1, 600, 5, 15, "ddx_nato_a164"],
// [uniqueID, displayName, category, EPDFunction, [EPD params], requiresIngress, etaSeconds, cooldownSeconds, capacityUses, delaySeconds, optionalFlyoverVehicle]

// GUN RUN
["cas_strafe","TEST CAS Gun Run","CAS","STRAFING_RUN_PROJECTILE", ["B_30mm_HE",80,105.6,200,25,0.005,0.005], false, 10, 120, 3, 8, "ddx_nato_a164"],
// [uniqueID, displayName, category, EPDFunction, [EPD params], requiresIngress, etaSeconds, cooldownSeconds, capacityUses, delaySeconds, optionalFlyoverVehicle]

// ARTY BARRAGE
["arty_155","TEST 155mm Artillery Barrage","MORTAR","SHOOT_PROJECTILES",["Sh_155mm_AMOS",5,8,120,10,0.5,1],false,20,180,4,5,""],
// [uniqueID, displayName, category, EPDFunction, [EPD params], requiresIngress, etaSeconds, cooldownSeconds, capacityUses, delaySeconds, optionalFlyoverVehicle]

// MINEFIELD
["minefield","TEST Minefield Deployment","CAS","LAY_MINE_FIELD",[["ATMine"],50,60,0.1,0.1],false,10,300,2,5,""],
// [uniqueID, displayName, category, EPDFunction, [EPD params], requiresIngress, etaSeconds, cooldownSeconds, capacityUses, delaySeconds, optionalFlyoverVehicle]

// SMOKE BARRAGE
["smoke_82","TEST 82mm Smoke Barrage","MORTAR","SHOOT_PROJECTILES",["G_40mm_Smoke",5,8,35,10,0.5,1],false,20,180,4,5,""]
// [uniqueID, displayName, category, EPDFunction, [EPD params], requiresIngress, etaSeconds, cooldownSeconds, capacityUses, delaySeconds, optionalFlyoverVehicle



];


// ----------------------------------------------------------------------------------------------------------------------------------
// ROLE RESTRICTED ARSENAL SYSTEM
// ----------------------------------------------------------------------------------------------------------------------------------

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

// ----------------------------------------------------------------------------------------------------------------------------------
// GARAGE SYSTEM
// ----------------------------------------------------------------------------------------------------------------------------------
JM_Garage = [
    ["B_MRAP_01_F", "Hunter MRAP", 3],
    ["B_APC_Wheeled_01_cannon_F", "Marshall APC", 1],
    ["B_Truck_01_transport_F", "HEMTT Transport", -1],
    ["B_T_Truck_01_flatbed_F", "HEMTT Transport", 2],
    ["B_Heli_Attack_01_dynamicLoadout_F", "RH-66 Commanche", 1],
    ["B_Plane_Fighter_01_F", "FA-18 Black Wasp", -1]
];


// ----------------------------------------------------------------------------------------------------------------------------------
// CBRN SYSTEM
// ----------------------------------------------------------------------------------------------------------------------------------

// CBRN - CORE BEHAVIOUR
JM_CBRN_maxDamage = 100;                    // How much damage a player can take from CBRN exposure before dying
JM_CBRN_allowPassiveDamage = true;      // Should players take damage auto damage occur over 50% threshold?
JM_CBRN_healingRate = 0;            // Healing rate each second. Does nothing if 0 or below, or player while player is experiencing passive contamination
JM_CBRN_deconWaterTime = 120;       // Time in seconds how much water a decon shower has
JM_CBRN_deconHealDamage = true;    // Does the decon shower heal all CBRN related damage? If false, it just stops further damage until the player leaves the shower
JM_CBRN_maxOxygenTime = 1800;   // After how much time does the air run out in an oxygen tank (in seconds!)

// CBRN - FOGGING
JM_CBRN_foggingEnabled = true;      // Enables or disables fogging entirely
JM_CBRN_fogStartTime = 300;     // Time in seconds until fog starts to appear after entering a CBRN zone
JM_CBRN_fogMaxTime = 600;       // Time in seconds until fog reaches maximum opacity after entering a CBRN zone
JM_CBRN_fogAccumulationCoef = 0.5;    // Fog accumulation coefficient; used when unit wears a backpack considered an air conditioner; lower means fogging accumulates slower, 0 stops it entirely; default 0.5
JM_CBRN_fogFadeCoef = 5;            // How quickly the fog fades after leaving a CBRN zone; higher means faster fade
JM_CBRN_fogFatigueEnabled = true;               // Whether or not fogging takes Fatigue into account
JM_CBRN_fogFatigueCoef = 1;          // Fatigue coefficient; is used in multiplication with the ACE fatigue value; higher means quicker fogging if unit has any fatigue
JM_CBRN_fogMaxAlpha = 1;      // Max fog visibillity; value from 0 to 1, decimals allowed. Sets the maximum visibility of the fog layer; default 1

// CBRN - GOGGLES CONSIDERED GASMASKS
JM_CBRN_masks = [
    "G_AirPurifyingRespirator_01_F",
    "G_AirPurifyingRespirator_02_black_F"
];

// CBRN - BACKPACKS CONSIDERED OXYGEN TANKS
JM_CBRN_backpacks = [
    "B_SCBA_01_F",
    "B_CombinationUnitRespirator_01_F"
];

// CBRN - ITEMS CONSIDERED AIR CONDITIONERS (SLOW FOGGING)
JM_CBRN_conditioning = [
    "B_CombinationUnitRespirator_01_F"
];

// CBRN - ITEMS CONSIDERED CBRN SUITS
JM_CBRN_suits = [
    "U_B_CBRN_Suit_01_MTP_F"
];

// CBRN - ITEMS CONSIDERED THREATMETERS OR GEIGERS
JM_CBRN_threatMeterItem = "ACE_microDAGR";
JM_CBRN_threatGeiger = "ACE_microDAGR";

// CBRN - VEHICLES PROTECTED FROM CBRN EXPOSURE [className, protectionValue]
JM_CBRN_vehicles = [
    ["B_Truck_01_medical_F", 2],
    ["B_APC_Tracked_01_CRV_F", 3]
];

// CBRN - ITEMS THAT WILL REMOVE CBRN DAMAGE [itemClass, healAmount]
JM_CBRN_healingItems = [
    ["ACE_adenosine", 50]
];

// CBRN - ZONES [id, center, threatLevel, fullRadius, partialRadius, startActive]
JM_CBRN_zones = [
    ["zone_alpha", getMarkerPos "mrk_cbrn_1", 1.5, 10, 5, true]
];



// ----------------------------------------------------------------------------------------------------------------------------------
// NON-SCALING MARKER SYSTEM
// ----------------------------------------------------------------------------------------------------------------------------------

JM_scaleMrkrs = []; // Array of markers that will NOT be scaled on the map


// ----------------------------------------------------------------------------------------------------------------------------------
// SAFEZONES
// ----------------------------------------------------------------------------------------------------------------------------------

JM_safeZones = [["safezone1", 50]]; // Syntax: [["marker1", radius1], ["marker2", radius2], ...]
JM_safeMsg = "FIRING IS PROHIBITED IN THIS AREA"; // The message that shows when a player shoots or throws a grenade

// ----------------------------------------------------------------------------------------------------------------------------------
// BRIEFING DIARY ENTRIES
// ----------------------------------------------------------------------------------------------------------------------------------

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



// ----------------------------------------------------------------------------------------------------------------------------------
// CUSTOME END TITLES CUTSCENE
// ----------------------------------------------------------------------------------------------------------------------------------
JM_EndTitles = [
    "The City of Sa'hatra was once destined to be Iraq's finest modern city, but the war of 2038 took a heavy toll.",
    "UN Peackeepers operating in Sa'hatra tried their best to provide aid and security to the people of the Green Zone.",
    "But a huge insurgent assault using manpower, drones and chemical weapons destroyed all hope of a successful humanitarian effort.",
    "Hundreds of UNA peacekeepers died in the chemical attacks that swept through the streets and into the surrounding fields.",
    "The chemical compound used in this attack, or its perpetrators, would remain hidden for the time being..."
];



// ----------------------------------------------------------------------------------------------------------------------------------
// CUSTOM DEBRIEF TEXT
// ----------------------------------------------------------------------------------------------------------------------------------

JM_CustomDebriefText = "The UNA attempted to stabilise the situation in wartorn Sa'hatra.<br/><br/>
However, despite their best efforts, a terrorist attack of daunting scale brought UN forces to their knees.<br/><br/>
The insurgents who conducted the attack used a combination of drones, chemical weapons and ground forces to strike at the heart of Operation Azure Shield.<br/><br/>
The UN operation lies in tatters, and the city of Sa'hatra is once again a lawless land...";







// *****************************************************************************************************************************

#include "Misc\DLCParser\dlcGearRegistry.sqf"


["JM Framework Initialised"] remoteExec ["systemChat", 0, false];