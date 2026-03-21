/*
    JM_JTAC_fnc_refreshLocalActions
    Ensures the local player has or does not have JTAC actions based on their variable.
*/
if (!hasInterface) exitWith {};
if (isNull player) exitWith {};

private _isJTAC = player getVariable ["JM_isJTAC", false] || { player getVariable ["isJTAC", false] };
private _hasAction = player getVariable ["JM_JTAC_actionAdded", false];

if (_isJTAC && !_hasAction) exitWith {
    [] call JM_JTAC_fnc_addLocalActions;
};

if (!_isJTAC && _hasAction) exitWith {
    [] call JM_JTAC_fnc_removeLocalActions;
};
