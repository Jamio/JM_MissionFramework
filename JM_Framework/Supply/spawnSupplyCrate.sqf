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
private _pos = getPosASL _spawner;

// === Create crate ===
private _crateClass = switch (_crateType) do {
    case "ammo":    { "Box_NATO_Ammo_F" };
    case "medical": { "ACE_medicalSupplyCrate" };
    case "repair":  { "Box_NATO_Support_F" };
    case "csw":     { "Box_NATO_WpsSpecial_F" };
    case "custom":  { "Box_NATO_WpsSpecial_F" };
    case "empty":   { "Box_NATO_Equip_F" };
    default         { "Box_NATO_Equip_F" };
};

private _box = createVehicle [_crateClass, _pos, [], 0, "NONE"];

_box setPosASL [
    _pos # 0,
    _pos # 1,
    (_pos # 2) + 2
];


// === Clear and configure ===
clearWeaponCargoGlobal _box;
clearMagazineCargoGlobal _box;
clearItemCargoGlobal _box;
clearBackpackCargoGlobal _box;

// Ignore ACE weight
[_box, true, [0, 3, 1], 0, true, true] call ace_dragging_fnc_setCarryable;
[_box, true, [3, -2, 2], 0, true, true] call ace_dragging_fnc_setDraggable;

_box setVariable ["ace_dragging_ignoreweightdrag", true];
_box setVariable ["ace_dragging_ignoreweightcarry", true];
[_box, 1] call ace_cargo_fnc_setSize;

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
        _box addItemCargoGlobal ["ACE_bloodIV_500", 15];
        _box addItemCargoGlobal ["ACE_bloodIV", 15];
        _box addItemCargoGlobal ["ACE_bloodIV_250", 15];
        _box addItemCargoGlobal ["ACE_epinephrine", 20];
        _box addItemCargoGlobal ["ACE_morphine", 20];
        _box addItemCargoGlobal ["ACE_tourniquet", 20];
        _box addItemCargoGlobal ["ACE_splint", 15];
        _box addItemCargoGlobal ["ACE_personalAidKit", 1];
        _box addItemCargoGlobal ["ACE_bodyBag", 5];
        _box addItemCargoGlobal ["ACE_painkillers", 10];
    };

    case "repair": {
        _box addItemCargoGlobal ["ACE_Track", 5];
        _box addItemCargoGlobal ["ACE_Wheel", 6];
        ["ACE_Track", _box] call ace_cargo_fnc_loadItem;
    };

    case "csw": {
        _box addMagazineCargoGlobal ["ace_csw_50Rnd_127x108_mag", 10];
        _box addMagazineCargoGlobal ["ace_csw_100Rnd_127x99_mag", 10];
        _box addMagazineCargoGlobal ["ace_csw_20Rnd_20mm_G_belt", 10];
        _box addMagazineCargoGlobal ["ACE_1Rnd_82mm_Mo_HE", 20];
        _box addMagazineCargoGlobal ["ACE_1Rnd_82mm_Mo_Smoke", 20];
    };

    case "custom": {

    };

    case "empty": {
        // do nothing, its empty!
    };
};

systemChat format ["%1 supply crate spawned.", toUpper _crateType];