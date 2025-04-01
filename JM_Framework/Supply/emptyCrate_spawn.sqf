if !(isServer) exitWith {};

params ["_box"];

private _spawnPos = getPos _box;

// Create the medical crate and assign it to a variable
private _crate = createVehicle ["Land_PlasticCase_01_large_F", _spawnPos, [], 0, "NONE"];

// Clear existing cargo
clearWeaponCargoGlobal _crate;
clearMagazineCargoGlobal _crate;
clearItemCargoGlobal _crate;
clearBackpackCargoGlobal _crate;

// Set ACE variables to ignore weight
_crate setVariable ["ace_dragging_ignoreweightdrag", true];
_crate setVariable ["ace_dragging_ignoreweightcarry", true];


systemChat "Empty Crate Spawned";