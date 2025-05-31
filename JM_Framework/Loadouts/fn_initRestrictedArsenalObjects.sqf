/*
    Called during PostInit on clients to build the scroll-wheel action
    and apply filtered ACE arsenal based on role.
*/

if (!hasInterface) exitWith {};
if (isNil "JM_arsenalObjects") exitWith {};
if (count JM_arsenalObjects == 0) exitWith {};

// Get role
private _role = player getVariable ["JM_role", ""];

if (_role == "") exitWith {
    systemChat "[JM_Arsenal] ERROR: No JM_role set for player.";
    // You could default to a role like "Rifleman" here if needed
};

// Assemble allowed items
// Function to convert wildcard string into regex pattern
private _wildcardToRegex = {
    params ["_wildcard"];
    // Escape special characters, then replace "*" with ".*"
    private _regex = _wildcard regexReplace ["([.^$+?(){}\[\]\\|])", "\\$1"];
    _regex = _regex regexReplace ["\*", ".*"];
    "^" + _regex + "$"
};

// Expand wildcard patterns into matching classnames from CfgWeapons
private _expandWildcardItems = {
    params ["_pattern"];

    private _regex = [_pattern] call _wildcardToRegex;
    private _matches = [];

    for "_i" from 0 to (count (configFile >> "CfgWeapons") - 1) do {
        private _cfg = (configFile >> "CfgWeapons") select _i;
        private _className = configName _cfg;

        if (_className regexMatch _regex) then {
            _matches pushBack _className;
        };
    };

    _matches
};

// Assemble allowed items with wildcard expansion
private _items = [];

{
    _x params ["_cat", "_list"];
    if (_cat == "BasicGear" || _cat == "BasicItems" || _cat == _role) then {
        {
            if (_x find "*" != -1) then {
                _items append ([_x] call _expandWildcardItems);
            } else {
                _items pushBack _x;
            };
        } forEach _list;
    };
} forEach JM_allowedArsenalItems;

_items = _items arrayIntersect _items;

{
    private _box = _x;

    _box addAction [
        "<img image='\a3\ui_f\data\gui\rsc\rscdisplayarsenal\vest_ca.paa' size='1.2' shadow='0'/> <t color='#ffdb33'>Access Role Arsenal</t>",
        {
            params ["_target", "_caller"];
            
            [_target, false] call ace_arsenal_fnc_removeVirtualItems;
            [_target, _this select 3] call ace_arsenal_fnc_addVirtualItems;
            [_target, _caller] call ace_arsenal_fnc_openBox;
        },
        _items,
        1.5,                    // Priority
        true,                   // ShowWindow
        true,                   // HideOnUse
        "",                     // Shortcut
        "_this distance _target < 5", // Condition (player must be within 5m)
        10                      // Radius (optional, visual detection range of action)
    ];
} forEach JM_arsenalObjects;

systemChat format ["[JM_Arsenal] Added filtered arsenal to %1 objects.", count JM_arsenalObjects];
