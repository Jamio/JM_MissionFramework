/*
    Filters arsenal based on player role and config.
    Called when arsenal is opened.
*/

params ["_box", "_unit"];

if (isNull _box || isNull _unit) exitWith {};

// Get role
private _role = _unit getVariable ["JM_role", ""];

// Fetch allowed items
private _allowedItems = [];

{
    private _cat = _x select 0;
    private _items = _x select 1;

    if (_cat == "General" || _cat == _role) then {
        _allowedItems append _items;
    };
} forEach JM_allowedArsenalItems;

_allowedItems = _allowedItems arrayIntersect _allowedItems;

// Clear and re-add
[_box, false] call ace_arsenal_fnc_removeVirtualItems;
[_box, _allowedItems] call ace_arsenal_fnc_addVirtualItems;
