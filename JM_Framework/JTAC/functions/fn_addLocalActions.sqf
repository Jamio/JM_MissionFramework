/*
    JM_JTAC_fnc_addLocalActions
    Adds the ACE interaction to the local player if they are JTAC.
*/
if (!hasInterface) exitWith {};
if (isNull player) exitWith {};

private _isJTAC = player getVariable ["JM_isJTAC", false] || { player getVariable ["isJTAC", false] };
if (!_isJTAC) exitWith {};

if (player getVariable ["JM_JTAC_actionAdded", false]) exitWith {};

private _action = [
    "JM_JTAC_Open",
    "Fire Support",
    "\a3\ui_f\data\IGUI\Cfg\HoldActions\holdAction_connect_ca.paa",
    { [] call JM_JTAC_fnc_openDialog; },
    { true }
] call ace_interact_menu_fnc_createAction;

// Add to self actions
[player, 1, ["ACE_SelfActions"], _action] call ace_interact_menu_fnc_addActionToObject;

// Mark as added
player setVariable ["JM_JTAC_actionAdded", true];

// Store the action path/name for removal bookkeeping
player setVariable ["JM_JTAC_actionPath", ["ACE_SelfActions", "JM_JTAC_Open"]];

