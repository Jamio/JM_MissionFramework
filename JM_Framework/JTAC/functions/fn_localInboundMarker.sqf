/*
    JM_JTAC_fnc_localInboundMarker
    Creates a local marker for the JTAC caller only, auto-deletes later.
    Params: [targetATL, text, ttlSeconds]
*/
if (!hasInterface) exitWith {};
params ["_posATL", "_text", ["_ttl", 30]];

private _mName = format ["JM_JTAC_in_%1", diag_tickTime];
private _m = createMarkerLocal [_mName, _posATL];
_m setMarkerTypeLocal "mil_warning";
_m setMarkerColorLocal "ColorYellow";
_m setMarkerTextLocal _text;

[_mName, _ttl] spawn {
    params ["_mName", "_ttl"];
    uiSleep _ttl;
    deleteMarkerLocal _mName;
};
