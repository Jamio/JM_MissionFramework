// Function to populate an ammo resupply crate
// Parameters:
// _crate - The ammo crate object to populate
// _primaryCount - Number of magazines for primary weapons
// _secondaryCount - Number of magazines for secondary weapons
// _launcherCount - Number of rockets for launchers
// _grenadeCount - Number of grenades
//
// Example:
// [this, 50, 20, 5, 10] execVM "JM_Framework\Supply\RRRveh.sqf";

if !(isServer) exitWith {};

waitUntil {time > 5};

params ["_veh"];

// REARM

[_veh, 10000, true] call ace_rearm_fnc_makeSource;

// REFUEL

[_veh, 10000, [0,0,0]] call ace_refuel_fnc_makeSource;

// REPAIR

_veh setVariable ["ace_repair_canRepair", 1, true];
