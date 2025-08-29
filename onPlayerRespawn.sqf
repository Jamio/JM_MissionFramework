// Only add to civilians
if (side player == civilian) then {
    [] execVM "civ\fn_addCivRPUtils.sqf";
};

// **************** FRAMEWORK - DO NOT TOUCH ***********************************

#include "JM_Framework\Stamina\staminaRespawn.sqf"