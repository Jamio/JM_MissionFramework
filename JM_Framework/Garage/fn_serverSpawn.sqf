// JM_Garage_fnc_serverSpawn.sqf
params ["_className", "_spawnPos", "_spawnDir"];


private _vehicle = createVehicle [_className, _spawnPos, [], 0, "NONE"];

_vehicle setDir _spawnDir;

clearWeaponCargoGlobal _vehicle;
clearMagazineCargoGlobal _vehicle;
clearItemCargoGlobal _vehicle;
clearBackpackCargoGlobal _vehicle;

_vehicle setFuel 1;
_vehicle setDamage 0;