// JM_Garage_fnc_serverSpawn.sqf
params ["_className", "_spawnPos"];

private _vehicle = createVehicle [_className, _spawnPos, [], 0, "NONE"];

clearWeaponCargoGlobal _vehicle;
clearMagazineCargoGlobal _vehicle;
clearItemCargoGlobal _vehicle;
clearBackpackCargoGlobal _vehicle;

_vehicle setFuel 1;
_vehicle setDamage 0;