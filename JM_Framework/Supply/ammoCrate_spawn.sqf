if !(isServer) exitWith {};

params ["_boxspawner"]; // The object that triggered the spawn

private _spawnPos = getPos _boxspawner;

// Create the ammo supply crate
private _box = createVehicle ["Box_NATO_Ammo_F", _spawnPos, [], 0, "NONE"];

// Ensure global loadout variables exist
if (isNil "JM_PrimMags") then { JM_PrimMags = []; };
if (isNil "JM_SecMags") then { JM_SecMags = []; };
if (isNil "JM_HGmags") then { JM_HGmags = []; };
if (isNil "JM_Grenades") then { JM_Grenades = []; };

// Clear existing cargo
clearWeaponCargoGlobal _box;
clearMagazineCargoGlobal _box;
clearItemCargoGlobal _box;
clearBackpackCargoGlobal _box;

// Set ACE variables to ignore weight
_box setVariable ["ace_dragging_ignoreweightdrag", true];
_box setVariable ["ace_dragging_ignoreweightcarry", true];

// Add primary weapon magazines
{
    _box addMagazineCargoGlobal [_x, 20]; // Adjust count as needed
} forEach JM_PrimMags;

// Add launcher magazines
{
    _box addMagazineCargoGlobal [_x, 10];
} forEach JM_SecMags;

// Add handgun magazines
{
    _box addMagazineCargoGlobal [_x, 25];
} forEach JM_HGmags;

// Add grenades
{
    _box addMagazineCargoGlobal [_x, 20];
} forEach JM_Grenades;

systemChat "Ammo Supply Crate Spawned";

   
