params ["_delta"];
if (!isServer) exitWith {-1};

private _pool = missionNamespace getVariable ["JM_tickets_pool", 0];
private _max  = missionNamespace getVariable ["JM_TicketsPoolMax", 30];

private _toAdd = _delta max 0;

if (_max >= 0) then {
    private _room = _max - _pool;
    _toAdd = (_toAdd min _room) max 0;
};

private _newPool = _pool + _toAdd;
missionNamespace setVariable ["JM_tickets_pool", _newPool, true];

_newPool

