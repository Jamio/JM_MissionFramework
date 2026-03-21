/*
    File: fn_createCBRNZones.sqf
*/

if (!isServer) exitWith {};
if !(missionNamespace getVariable ["JM_CBRN_enabled", false]) exitWith {};

private _zoneDefs = missionNamespace getVariable ["JM_CBRN_zones", []];
private _zoneMap = createHashMap;

{
    _x params [
        ["_id", "", [""]],
        ["_center", [0,0,0], [[]]],
        ["_threat", 1, [0]],
        ["_fullRadius", 25, [0]],
        ["_partialRadius", 25, [0]],
        ["_startActive", true, [true]]
    ];

    if (_id isEqualTo "") then { continue };

    private _trg = [_center, _threat, _fullRadius, _partialRadius] call cbrn_fnc_createZone;
    _trg setVariable ["cbrn_active", _startActive, true];
    _trg setVariable ["JM_cbrn_zoneId", _id, true];

    _zoneMap set [_id, _trg];
} forEach _zoneDefs;

missionNamespace setVariable ["JM_CBRN_zoneMap", _zoneMap, true];