if !(isServer) exitWith {};

params ["_box"];

private _spawnPos = getPos _box;

// Create the medical crate and assign it to a variable
private _crate = createVehicle ["ACE_medicalSupplyCrate", _spawnPos, [], 0, "NONE"];

// Clear existing cargo
clearWeaponCargoGlobal _crate;
clearMagazineCargoGlobal _crate;
clearItemCargoGlobal _crate;
clearBackpackCargoGlobal _crate;

// Set ACE variables to ignore weight
_crate setVariable ["ace_dragging_ignoreweightdrag", true];
_crate setVariable ["ace_dragging_ignoreweightcarry", true];

// Add medical supplies to the **spawned crate**
_crate addItemCargoGlobal ["ACE_fieldDressing", 50];
_crate addItemCargoGlobal ["ACE_bloodIV", 15];
_crate addItemCargoGlobal ["ACE_bloodIV_500", 20];
_crate addItemCargoGlobal ["ACE_bloodIV_250", 25];
_crate addItemCargoGlobal ["ACE_splint", 15];
_crate addItemCargoGlobal ["ACE_tourniquet", 15];
_crate addItemCargoGlobal ["ACE_painkillers", 5];
_crate addItemCargoGlobal ["ACE_epinephrine", 25];
_crate addItemCargoGlobal ["ACE_morphine", 25];

systemChat "Medical Supply Crate Spawned";


