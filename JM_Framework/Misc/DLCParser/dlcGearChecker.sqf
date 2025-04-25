
waitUntil {time >= 5};

// Convert DLC gear array to a hashmap for fast lookup
private _dlcGearMap = createHashMap;
{
    _x params ["_classname", "_dlc"];
    _dlcGearMap set [_classname, _dlc];
} forEach JM_dlcGear;

// Step 2: Loop through all playable and switchable units
private _units = playableUnits + switchableUnits;

// Start text with font size
private _reportText = "<font size='16'>DLC Gear Report</font><br/><br/>";

{
    private _unit = _x;
    private _loadout = getUnitLoadout _unit;
    private _gearItems = [];

    // Uniform, Vest, Backpack are nested arrays → need select 0
    if (count (_loadout select 3) > 0) then { _gearItems pushBack ((_loadout select 3) select 0); }; // uniform
    if (count (_loadout select 4) > 0) then { _gearItems pushBack ((_loadout select 4) select 0); }; // vest
    if (count (_loadout select 5) > 0) then { _gearItems pushBack ((_loadout select 5) select 0); }; // backpack

    // These are just classnames (strings)
    _gearItems pushBack (_loadout select 6); // helmet
    _gearItems pushBack (_loadout select 7); // goggles
    _gearItems pushBack (_loadout select 8); // hmd
    _gearItems pushBack (_loadout select 9); // binoculars

    // Weapons (primary, secondary, handgun): arrays, first element is classname
    {
        if (count _x > 0) then {
            _gearItems pushBack (_x select 0);
        };
    } forEach [_loadout select 0, _loadout select 1, _loadout select 2];

    // Collect DLC gear
    private _dlcItems = [];
    {
        private _item = _x;
        if (!isNil "_item" && {_item isEqualType "" && {_item != ""}}) then {
            private _dlc = _dlcGearMap getOrDefault [_item, ""];
            if (_dlc != "") then {
                _dlcItems pushBackUnique [_item, _dlc];
            };
        };
    } forEach _gearItems;

    // Add to report
    _reportText = _reportText + format ["<font color='#ffff66'>%1:</font><br/>", name _unit];
    if ((count _dlcItems) > 0) then {
        {
            _reportText = _reportText + format ["- %1 <font color='#ffaa00'>(%2)</font><br/>", _x select 0, _x select 1];
        } forEach _dlcItems;
    } else {
        _reportText = _reportText + "<font color='#66ff66'>No DLC gear detected.</font><br/>";
    };
    _reportText = _reportText + "<br/>";

} forEach _units;

// Create Mision framework diary entry
player createDiarySubject ["Mission Framework", "Mission Framework"];

// Create one diary entry with the full report
player createDiaryRecord ["Mission Framework", ["DLC Gear Checker", _reportText]];
