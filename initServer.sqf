
#include "JM_Framework\Misc\Stats\initStats.sqf"


// Whitelisting Arsenal weapons for the unknownWep module

[] spawn {
    // Wait for settings to initialize
    waitUntil {!isNil "JM_punishWep"};
    
            if (JM_punishWep) then {
                [] call JM_Loadouts_fnc_whitelistArsenalWeapons;
            };
    };


// Supply Stuff

[] execVM "JM_Framework\Supply\supply_init.sqf";

JM_Supply_fnc_scanPlayerMagsFromUID = compile preprocessFileLineNumbers "JM_Framework\Supply\fn_scanPlayerMagsFromUID.sqf";

// AI CACHING - ANYTHING BELOW HERE WILL BE CUTOFF (WILL SORT LATER LOL)
#include "JM_Framework\Misc\Perf\simpleAICaching.sqf"




