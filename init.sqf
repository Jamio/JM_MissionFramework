
// *********************************************************************************************************
// ************************************* MISSION FRAMEWORK - DO NOT TOUCH **********************************
// *********************************************************************************************************

#include "JM_Framework\JM_init.sqf"

// Earplugs
execVM "JM_Framework\Earplugs\fnc_initEarplugs.sqf";

// Fortify
[compileScript ["JM_Framework\Fortify\init_fortify.sqf"]] call CBA_fnc_directCall;

// Safezone
execVM "JM_Framework\Safezone\grenadeStop.sqf";

// Unconscious Spectator

// Vehicle Appearance Manager
[] execVM "JM_Framework\VAM_GUI\VAM_GUI_init.sqf";

// Permadeath BIS_fnc_moduleSaveGame
[] execVM "JM_Framework\Permadeath\permadeath_init.sqf";

// check for DLC gear
[] execVM "JM_Framework\Misc\DLCParser\dlcGearChecker.sqf";
