if !(isServer) exitWith {};

params ["_box"];

private _spawnPos = getPos _box;

// Create the medical crate and assign it to a variable
private _crate = createVehicle ["Box_NATO_Wps_F", _spawnPos, [], 0, "NONE"];

// Clear existing cargo
clearWeaponCargoGlobal _crate;
clearMagazineCargoGlobal _crate;
clearItemCargoGlobal _crate;
clearBackpackCargoGlobal _crate;

// Set ACE variables to ignore weight
_crate setVariable ["ace_dragging_ignoreweightdrag", true];
_crate setVariable ["ace_dragging_ignoreweightcarry", true];

// Add medical supplies to the **spawned crate**
_crate addMagazineCargoGlobal ["ace_csw_50Rnd_127x108_mag", 10];
_crate addMagazineCargoGlobal ["ace_csw_100Rnd_127x99_mag", 10];
_crate addMagazineCargoGlobal ["ace_csw_20Rnd_20mm_G_belt", 10];
_crate addMagazineCargoGlobal ["ACE_1Rnd_82mm_Mo_HE", 10];
_crate addMagazineCargoGlobal ["ACE_1Rnd_82mm_Mo_Illum", 10];
_crate addMagazineCargoGlobal ["ACE_1Rnd_82mm_Mo_Smoke", 10];


systemChat "CSW Supply Crate Spawned";