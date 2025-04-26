
#include "JM_Framework\Misc\Stats\initStats.sqf"


[] spawn {
    // Wait for settings to initialize
    waitUntil {!isNil "JM_punishWep"};
    
            if (JM_punishWep) then {
                [] call JM_Loadouts_fnc_whitelistArsenalWeapons;
            };
    };


