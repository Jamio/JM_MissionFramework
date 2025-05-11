// JM_Framework\Supply\spawnSupplyCrate.sqf
if !(isServer) exitWith {};

params ["_crateType", "_player"];  // Passed from GUI — e.g., "ammo", "medical", etc.

// === Find nearest valid supply spawner to player ===
private _spawner = nearestObjects [_player, [], 10] select {
    (_x getVariable ["JM_SupplySpawner", false])
};

if (_spawner isEqualTo []) exitWith {
    systemChat "No nearby supply spawner found.";
};

_spawner = _spawner select 0;
private _pos = getPos _spawner;

// === Create crate ===
private _crateClass = switch (_crateType) do {
    case "ammo":    { "Box_NATO_Ammo_F" };
    case "medical": { "Box_B_UAV_06_medical_F" };
    case "repair":  { "Box_NATO_Support_F" };
    case "csw":     { "Box_NATO_WpsSpecial_F" };
    case "custom":  { "Box_NATO_WpsSpecial_F" };
    case "empty":   { "Box_NATO_Equip_F" };
    default         { "Box_NATO_Equip_F" };
};

private _box = createVehicle [_crateClass, _pos, [], 0, "NONE"];

// === Clear and configure ===
clearWeaponCargoGlobal _box;
clearMagazineCargoGlobal _box;
clearItemCargoGlobal _box;
clearBackpackCargoGlobal _box;

// Ignore ACE weight
[_box, true, [0, 3, 1], 0, true, true] call ace_dragging_fnc_setCarryable;
[_box, true, [3, -2, 2], 0, true, true] call ace_dragging_fnc_setDraggable;

// === Crate Content Logic ===
switch (_crateType) do {
    case "ammo": {
        if (isNil "JM_PrimMags") then { JM_PrimMags = []; };
        if (isNil "JM_SecMags") then { JM_SecMags = []; };
        if (isNil "JM_HGmags") then { JM_HGmags = []; };
        if (isNil "JM_Grenades") then { JM_Grenades = []; };

        { _box addMagazineCargoGlobal [_x, 20]; } forEach JM_PrimMags;
        { _box addMagazineCargoGlobal [_x, 5]; } forEach JM_SecMags;
        { _box addMagazineCargoGlobal [_x, 25]; } forEach JM_HGmags;
        { _box addMagazineCargoGlobal [_x, 10]; } forEach JM_Grenades;
    };

    case "medical": {
        _box addItemCargoGlobal ["ACE_fieldDressing", 50];
        _box addItemCargoGlobal ["ACE_elasticBandage", 40];
        _box addItemCargoGlobal ["ACE_packingBandage", 40];
        _box addItemCargoGlobal ["ACE_salineIV_500", 10];
        _box addItemCargoGlobal ["ACE_epinephrine", 20];
        _box addItemCargoGlobal ["ACE_morphine", 20];
        _box addItemCargoGlobal ["ACE_tourniquet", 20];
        _box addItemCargoGlobal ["ACE_splint", 15];
    };

    case "repair": {
        _box addItemCargoGlobal ["ACE_Track", 5];
        _box addItemCargoGlobal ["ACE_Wheel", 6];
    };

    case "csw": {
        _box addMagazineCargoGlobal ["ace_csw_50Rnd_127x108_mag", 10];
        _box addMagazineCargoGlobal ["ace_csw_100Rnd_127x99_mag", 10];
        _box addMagazineCargoGlobal ["ace_csw_20Rnd_20mm_G_belt", 10];
        _box addMagazineCargoGlobal ["ACE_1Rnd_82mm_Mo_HE", 20];
        _box addMagazineCargoGlobal ["ACE_1Rnd_82mm_Mo_Smoke", 20];
    };

    case "custom": {
        _box addItemCargoGlobal ["ACE_Clacker", 1];
        _box addItemCargoGlobal ["DemoCharge_Remote_Mag", 3];
        _box addItemCargoGlobal ["ACE_DefusalKit", 2];
    };

    case "empty": {
        // do nothing, it's empty!
    };
};

systemChat format ["%1 supply crate spawned.", toUpper _crateType];
