
#include "JM_Framework\Misc\Stats\initStats.sqf"


[] spawn {
    // Wait for settings to initialize
    waitUntil {!isNil "JM_punishWep"};
    
            if (JM_punishWep) then {
                [] call JM_Loadouts_fnc_whitelistArsenalWeapons;
            };
    };



[] spawn {

waitUntil {!isNil "JM_Rally"}; 

if (JM_Rally) then {
[] spawn JM_RallyPoint_fnc_updateRallyAssignments;
};

};

[] execVM "JM_Framework\Supply\supply_init.sqf";

JM_Supply_fnc_scanPlayerMagsFromUID = compile preprocessFileLineNumbers "JM_Framework\Supply\fn_scanPlayerMagsFromUID.sqf";



