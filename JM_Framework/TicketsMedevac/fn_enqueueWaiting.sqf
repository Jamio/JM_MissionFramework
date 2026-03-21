params ["_unit"];
if (!isServer) exitWith {};
if !(missionNamespace getVariable ["JM_TicketsMedevac", false]) exitWith {};
if (isNull _unit) exitWith {};
if (!isPlayer _unit) exitWith {};
if (alive _unit) exitWith {};

private _uid = getPlayerUID _unit;
if (_uid isEqualTo "") exitWith {};

private _queue = missionNamespace getVariable ["JM_tickets_queue", []];

// no duplicates
if ((_queue findIf { (_x # 0) isEqualTo _uid }) > -1) exitWith {};

_queue pushBack [_uid, diag_tickTime, owner _unit, name _unit]; // FIFO by pushBack
missionNamespace setVariable ["JM_tickets_queue", _queue, true];
