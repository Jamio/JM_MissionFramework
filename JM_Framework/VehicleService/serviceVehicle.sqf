// scripts\ServiceVehicle.sqf

params ["_veh"];

private _vehType = getText (configFile >> "CfgVehicles" >> typeOf _veh >> "displayName");

// Only service valid vehicles
if (!(_veh isKindOf "LandVehicle") && !(_veh isKindOf "Air") && !(_veh isKindOf "Ship")) exitWith {};

// Start servicing
_veh sideChat format ["Servicing %1.", _vehType];
sleep 2;

// Rearm (this can take a tiny moment to actually fill magazines)
_veh setVehicleAmmo 1;
_veh sideChat format ["%1 Rearmed.", _vehType];
sleep 2;

// Full ACE repair
if (isClass (configFile >> "CfgPatches" >> "ace_repair")) then {
    [player, _veh] call ace_repair_fnc_doFullRepair;
    _veh sideChat format ["%1 Fully Repaired.", _vehType];
} else {
    _veh setDamage 0;
    _veh sideChat format ["%1 (Vanilla) Repaired.", _vehType];
};
sleep 2;

// Refuel
_veh setFuel 1;
_veh sideChat format ["%1 Refueled.", _vehType];
sleep 2;

// Done
_veh sideChat "Service Complete.";
