// DLC Ownership Check

private _debugFakeDLCs = false;  // Toggle to false in real use

private _ownedDLCs = [];

if (_debugFakeDLCs) then {
    _ownedDLCs = ["zeus", "karts"];  // Simulated owned DLCs
} else {
    private _dlcIDs = getDLCs 1;
    _ownedDLCs = _dlcIDs apply {
        switch _x do {
            case 275700: { "zeus" };
            case 288520: { "karts" };
            case 304380: { "helicopters" };
            case 332350: { "marksmen" };
            case 395180: { "apex" };
            case 571710: { "laws of war" };
            case 601670: { "jets" };
            case 612480: { "malden" };
            case 744950: { "tacops" };
            case 798390: { "tanks" };
            case 1021790: { "contact" };
            case 1325500: { "art of war" };
            case 1042220: { "global mobilization" };
            case 1227700: { "s.o.g. prairie fire" };
            case 1294440: { "csla iron curtain" };
            case 1681170: { "western sahara" };
            case 1175380: { "spearhead 1944" };
            case 2647760: { "reaction forces" };
            case 2647830: { "expeditionary forces" };
            default { "" };
        }
    };
};

// Build a hashmap from JM_dlcGear
private _dlcGearMap = createHashMap;
{
    _x params ["_classname", "_dlc"];
    _dlcGearMap set [_classname, _dlc];
} forEach JM_dlcGear;

// Get player loadout and collect DLC-restricted gear
private _loadout = getUnitLoadout player;
private _gearItems = [];

// Uniform, Vest, Backpack
if (count (_loadout select 3) > 0) then { _gearItems pushBack ((_loadout select 3) select 0); };
if (count (_loadout select 4) > 0) then { _gearItems pushBack ((_loadout select 4) select 0); };
if (count (_loadout select 5) > 0) then { _gearItems pushBack ((_loadout select 5) select 0); };

// Simple classnames
_gearItems pushBack (_loadout select 6); // helmet
_gearItems pushBack (_loadout select 7); // goggles
_gearItems pushBack (_loadout select 8); // hmd
_gearItems pushBack (_loadout select 9); // binoculars

// Weapons
{
    if (count _x > 0) then {
        _gearItems pushBack (_x select 0);
    };
} forEach [_loadout select 0, _loadout select 1, _loadout select 2];

// Check for DLC gear not owned
private _missingItems = [];

{
    private _item = _x;
    if (!isNil "_item" && {_item isEqualType "" && {_item != ""}}) then {
        private _dlc = _dlcGearMap getOrDefault [_item, ""];
        if (_dlc != "" && {!(_dlc in _ownedDLCs)}) then {
            _missingItems pushBackUnique [_item, _dlc];
        };
    };
} forEach _gearItems;

// Convert classnames to display names (fallback to classname if not found)
private _namedMissingItems = _missingItems apply {
    _x params ["_classname", "_dlc"];
    private _displayName = getText (configFile >> "CfgWeapons" >> _classname >> "displayName");
    if (_displayName == "") then {
        _displayName = getText (configFile >> "CfgGlasses" >> _classname >> "displayName");
    };
    if (_displayName == "") then {
        _displayName = getText (configFile >> "CfgVehicles" >> _classname >> "displayName");
    };
    if (_displayName == "") then {
        _displayName = _classname; // fallback to classname
    };
    [_displayName, _dlc]
};

// Show a warning if any DLC gear is unowned
if ((count _namedMissingItems) > 0) then {
    private _msg = "<font color='#ff0000'>WARNING:</font> You are using gear that requires DLC you do not own. Please notify a zeus or mission maker.<br/><br/>";

    {
        private _itemDisplayName = _x select 0;
        private _dlc = _x select 1;

		_msg = _msg + format ["%1 <t color='#ffaa00'>%2</t><br/>", _itemDisplayName, _dlc];
    } forEach _namedMissingItems;

    [_msg, "DLC Ownership Warning"] call BIS_fnc_guiMessage;
};




















































// *******************************************************************************************************************************************
/*

// DLC Ownership Check - InitPlayerLocal

private _debugFakeDLCs = true;  // Toggle to false in real use

private _ownedDLCs = [];

if (_debugFakeDLCs) then {
    _ownedDLCs = ["zeus", "karts"];  // Simulated owned DLCs
} else {
    private _dlcIDs = getDLCs 1;
    _ownedDLCs = _dlcIDs apply {
        switch _x do {
            case 275700: { "zeus" };
            case 288520: { "karts" };
            case 304380: { "helicopters" };
            case 332350: { "marksmen" };
            case 395180: { "apex" };
            case 571710: { "laws of war" };
            case 601670: { "jets" };
            case 612480: { "malden" };
            case 744950: { "tacops" };
            case 798390: { "tanks" };
            case 1021790: { "contact" };
            case 1325500: { "art of war" };
            case 1042220: { "global mobilization" };
            case 1227700: { "s.o.g. prairie fire" };
            case 1294440: { "csla iron curtain" };
            case 1681170: { "western sahara" };
            case 1175380: { "spearhead 1944" };
            case 2647760: { "reaction forces" };
            case 2647830: { "expeditionary forces" };
            default { "" };
        }
    };
};

// Build a hashmap from JM_dlcGear
private _dlcGearMap = createHashMap;
{
    _x params ["_classname", "_dlc"];
    _dlcGearMap set [_classname, _dlc];
} forEach JM_dlcGear;

// Get player's loadout and collect DLC-restricted gear
private _loadout = getUnitLoadout player;
private _gearItems = [];

// Uniform, Vest, Backpack
if (count (_loadout select 3) > 0) then { _gearItems pushBack ((_loadout select 3) select 0); };
if (count (_loadout select 4) > 0) then { _gearItems pushBack ((_loadout select 4) select 0); };
if (count (_loadout select 5) > 0) then { _gearItems pushBack ((_loadout select 5) select 0); };

// Simple classnames
_gearItems pushBack (_loadout select 6); // helmet
_gearItems pushBack (_loadout select 7); // goggles
_gearItems pushBack (_loadout select 8); // hmd
_gearItems pushBack (_loadout select 9); // binoculars

// Weapons
{
    if (count _x > 0) then {
        _gearItems pushBack (_x select 0);
    };
} forEach [_loadout select 0, _loadout select 1, _loadout select 2];

// Check for DLC gear not owned
private _missingItems = [];

{
    private _item = _x;
    if (!isNil "_item" && {_item isEqualType "" && {_item != ""}}) then {
        private _dlc = _dlcGearMap getOrDefault [_item, ""];
        if (_dlc != "" && {!(_dlc in _ownedDLCs)}) then {
            _missingItems pushBackUnique [_item, _dlc];
        };
    };
} forEach _gearItems;

// Convert classnames to display names (fallback to classname if not found)
private _namedMissingItems = _missingItems apply {
    _x params ["_classname", "_dlc"];
    private _displayName = getText (configFile >> "CfgWeapons" >> _classname >> "displayName");
    if (_displayName == "") then {
        _displayName = getText (configFile >> "CfgGlasses" >> _classname >> "displayName");
    };
    if (_displayName == "") then {
        _displayName = getText (configFile >> "CfgVehicles" >> _classname >> "displayName");
    };
    if (_displayName == "") then {
        _displayName = _classname; // fallback to classname
    };
    [_displayName, _dlc]
};

// Show a warning if any DLC gear is unowned
if ((count _namedMissingItems) > 0) then {
    private _msg = "WARNING: You are using gear that requires DLC you do not own.<br/><br/>";
    {
        _msg = _msg + format ["%1 (from %2)<br/>", _x select 0, _x select 1];
    } forEach _namedMissingItems;
    _msg = _msg + "<br/>Please notify a Zeus or mission maker.";

    [_msg, "DLC Ownership Warning"] call BIS_fnc_guiMessage;

    // Optional debug
    diag_log format ["[DLC DEBUG] Unowned DLC Items: %1", _namedMissingItems];
};


*/