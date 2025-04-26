



JM_unconSpectator = true; // ACE Unconscious Spectator
JM_Permadeath = false; // Permadeath enabled/disabled
JM_GrassCutter = true; // Player Grasscutter
JM_Safezone = true; // Safezones
JM_punishWep = true; // Punish Enemy Weapons
JM_MrkScaling = true; // Limit Marker Scaling
JM_Earplugs = true; // Player Earplugs
JM_Fortify = true; // Custom ACE Fortify
JM_Rally = true; // Rally Points
JM_tpToSL = true; // Teleport to Squad
JM_loadoutPersist = false; // Save loadouts on death
JM_arsenalRoleRestrict = true; // Restrict arsenal items based on roles
JM_StaminaOff = true;

/* ************************************** CUSTOMISABLE BITS BELOW ********************************************************** */

// SUPPLY SPAWNER

// FORTIFY
JM_engineerVehicleClass = constructionCrate1; // variable name of the object that is used for construction
JM_refillObject = refillCrate1; // variable name for the object used to reifll the construction object
JM_maxBudget = 1000; // maximum fortify budget
JM_refillBudget = 100;

JM_fortName1 = "List 1"; // Name of blueprint list
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
    ["General", [
        "ItemMap", "ItemCompass", "ItemWatch", "ACE_fieldDressing"
 
    ]],
    
    ["Medic", [
        "ACE_surgicalKit", "ACE_bloodIV", "ACE_morphine", "SMG_02_F", "30Rnd_9x21_Mag_SMG_02", "U_B_PilotCoveralls"
    ]],
    
    ["Engineer", [
        "ACE_Clacker", "ACE_DefusalKit", "ACE_wirecutter"
    ]],
    
    ["Machinegunner", [
        "rhsusf_100Rnd_762x51", "rhsusf_100Rnd_762x51_m62"
    ]],
    
    ["Pilot", [
        "H_PilotHelmetHeli_B", "NVGoggles_INDEP"
    ]]
];

// MARKER SIZE 

JM_scaleMrkrs = []; // Array of markers that will NOT be scaled on the map


// SAFEZONES

JM_safeZones = [["safezone1", 50]]; // Syntax: [["marker1", radius1], ["marker2", radius2], ...]
JM_safeMsg = "FIRING IS PROHIBITED IN THIS AREA"; // The message that shows when a player shoots or throws a grenade

// BRIEFING DIARY ENTRIES

JM_BriefingContent = [
    ["I. Organisation", [
        ["ORBAT", "Misfits PMC<br/><br/>Platoon HQ<br/>Infantry Squad - Alpha<br/>Weapons Squad - Bravo"]
    ]],

    ["II. Situation", [
        ["SUMMARY", ""],
        ["AREA OF OPERATIONS", "Terrain: Arid steppes, limited woodland.<br/><br/>Current Weather: Overcast, light rain.<br/><br/>Forecast: No change for at least the next few days."],
		["WEATHER", "Overcast. Chance of light rain. No change expected."],
		["ENEMY FORCES", "Division strength, well-armed militia. Medium armour, recon vehicles. Limited air assets. High probability of minefields and fortifications."],
        ["FRIENDLY FORCES", "No friendly units are in the vicinity."],
        ["CIVILIANS", "Low probability of civilians due to remote location."],
        ["RULES OF ENGAGEMENT", "Fire at will. Clear to engage uniformed and armed personnel."]
    ]],

	["III. Mission", [
        ["MISSION INTENT", "The Misfits are tasked with hunting down and destroying three SAM sites in the mountains to the North of Zembajan."],
		["OBJECTIVES", "OBJECTIVE 1: Deploy onto the mountains at LZ Romeo<br/><br/>OBJECTIVE 2: Seek and destroy 3x S-300 SAM sites<br/><br/>OBJECTIVE 3: Contact Command and arrange extraction via CH-47 callsign BIG BIRD"]
    ]],

	["IV. Execution", [
        ["STRATEGY OUTLINE", "You will be deployed onto the base of the mountain range at LZ Romeo, North of Zembajan. You will move on-foot along the ridgelines Northward.<br/><br/>Once in position, you will search for and destroy the 3x concealed SAM sites.<br/><br/>On completion of your primary objective, you will proceed to the extraction zone (TBC)"],
		["SUPPORT", "Air support and artillery are unavailable for this operation."]
    ]],

    ["V. Support and Logistics", [
        ["TRANSPORTATION", "Insertion and Extraction will be performed by a CH-47, callsign BIG BIRD."],
        ["RESUPPLIES", "Resupplies unavailable due to the presence of enemy AA emplacements."],
		["REINSERTION", "Dead players will respawn at HQ and can travel to a rally or squad member"]
    ]],

	["VI. Communication", [
        ["RADIO DISTRIBUTION", "All infantry units are equipped with a PRC152 for short-range communication. PL and SLs are equipped with a 117F for long-range communication."],
		["FREQUENCIES", "Command Channel = LR CH 1<br/><br/>Squad Channels = SR 1/2/3/4/5"]
    ]]
];



// CUSTOM END TITLES FOR CUTSCENE
JM_EndTitles = [
    "The fighting in this mission was intense.",
    "The Misfits held the line, but at great cost.",
    "Buccaneer tried to use a squadmates head to defuse a mine, and Max flew a C-130 into a cliff.",
    "Maybe next time, they’ll do better. Maybe."
];



// CUSTOM DEBRIEF text

JM_CustomDebriefText = "The Misfits enjoyed playing around at the training ground with their friends.<br/><br/>
Everyone had a good time, and went to be with a newfound warmth in their hearts.<br/><br/>
Well done, everyone.";







// *****************************************************************************************************************************

#include "Misc\DLCParser\dlcGearRegistry.sqf"


["Initialising JM Framework"] remoteExec ["systemChat", 0, false];