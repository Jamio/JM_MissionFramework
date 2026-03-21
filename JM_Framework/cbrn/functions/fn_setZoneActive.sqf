/*
    File: JM_Framework\CBRN\functions\fn_setZoneActive.sqf
    Usage:
    ["zone_alpha", true] call JM_CBRN_fnc_setZoneActive;
*/

params [
    ["_zoneId", "", [""]],
    ["_state", true, [true]]
];

if (_zoneId isEqualTo "") exitWith { false };

if (!isServer) exitWith {
    _this remoteExecCall ["JM_CBRN_fnc_setZoneActive", 2];
    false
};

private _zoneMap = missionNamespace getVariable ["JM_CBRN_zoneMap", createHashMap];
private _zone = _zoneMap getOrDefault [_zoneId, objNull];

if (isNull _zone) exitWith {
    diag_log format ["[JM CBRN] fn_setZoneActive: Zone '%1' not found.", _zoneId];
    false
};

_zone setVariable ["cbrn_active", _state, true];

diag_log format [
    "[JM CBRN] Zone '%1' set to %2.",
    _zoneId,
    ["INACTIVE", "ACTIVE"] select _state
];

true