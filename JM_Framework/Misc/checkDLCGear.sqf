if (!hasInterface) exitWith {};

// Get all units in playable slots
private _units = playableUnits;
private _report = [];

// Helper: Get DLC info from item class name
private _getItemDLC = {
    params ["_itemClass"];
    private _info = getAssetDLCInfo _itemClass;
    if (!isNil "_info" && { _info select 0 }) then {
        // Returns: [DLC name, class name]
        [_info select 2, _itemClass]
    } else {
        objNull
    };
};

{
    private _unit = _x;
    private _unitName = name _unit;
    if (_unitName isEqualTo "") then { _unitName = str _unit };

    private _gearItems = [];

    // Gear slots
    _gearItems append [
        uniform _unit,
        vest _unit,
        backpack _unit,
        headgear _unit,
        goggles _unit,
        hmd _unit,
        primaryWeapon _unit,
        secondaryWeapon _unit,
        handgunWeapon _unit
    ];

    // Inventory contents
    _gearItems append (uniformItems _unit);
    _gearItems append (vestItems _unit);
    _gearItems append (backpackItems _unit);
    _gearItems append (assignedItems _unit);
    _gearItems append (magazines _unit);

    // Clean up
    _gearItems = _gearItems select { _x != "" };
    _gearItems = _gearItems arrayIntersect _gearItems;  // make unique

    private _dlcItems = [];

    {
        private _result = [_x] call _getItemDLC;
        if (!isNull _result) then {
            _dlcItems pushBack _result;
        };
    } forEach _gearItems;

    if (_dlcItems isNotEqualTo []) then {
        private _entry = format ["%1:\n", _unitName];

        {
            private _dlcName = _x select 0;
            private _itemClass = _x select 1;

            // Try to get a nice display name
            private _displayName = getText (configFile >> "CfgWeapons" >> _itemClass >> "displayName");
            if (_displayName == "") then {
                _displayName = getText (configFile >> "CfgMagazines" >> _itemClass >> "displayName");
            };
            if (_displayName == "") then {
                _displayName = getText (configFile >> "CfgVehicles" >> _itemClass >> "displayName");
            };
            if (_displayName == "") then {
                _displayName = _itemClass;
            };

            _entry = _entry + format ["  - %1 (requires %2)\n", _displayName, _dlcName];
        } forEach _dlcItems;

        _report pushBack _entry;
    };
} forEach _units;

// Write to diary
if (_report isNotEqualTo []) then {
    private _fullText = "The following slots use items that require DLCs:\n\n" + (_report joinString "\n");
    player createDiaryRecord ["Diary", ["DLC Requirements", _fullText]];
} else {
    player createDiaryRecord ["Diary", ["DLC Requirements", "No DLC-dependent gear detected in playable slots."]];
};




