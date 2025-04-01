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
private _items = [];
{
    private _cat = _x select 0;
    private _list = _x select 1;

    if (_cat == "General" || _cat == _role) then {
        _items append _list;
    };
} forEach JM_allowedArsenalItems;

_items = _items arrayIntersect _items; // Remove duplicates

{
    private _box = _x;

    // Add the scroll-wheel action
    _box addAction [
        "<t color='#e0a133'>Access Role Arsenal</t>",
        {
            params ["_target", "_caller"];
            
            // Clear and re-add allowed items
            [_target, false] call ace_arsenal_fnc_removeVirtualItems;
            [_target, _this select 3] call ace_arsenal_fnc_addVirtualItems;
            [_target, _caller] call ace_arsenal_fnc_openBox;
        },
        _items
    ];
} forEach JM_arsenalObjects;

systemChat format ["[JM_Arsenal] Added filtered arsenal to %1 objects.", count JM_arsenalObjects];
