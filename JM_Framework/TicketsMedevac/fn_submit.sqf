params ["_dropoffObj", "_caller"];
if (!isServer) exitWith {};
if !(missionNamespace getVariable ["JM_TicketsMedevac", false]) exitWith {};
if (isNull _dropoffObj) exitWith {};

// cooldown per dropoff object
private _now = time;
private _nextOk = _dropoffObj getVariable ["JM_Tickets_nextOk", 0];
if (_now < _nextOk) exitWith {};

_dropoffObj setVariable ["JM_Tickets_nextOk", _now + ((missionNamespace getVariable ["JM_TicketsSubmitCooldown", 8]) max 1), true];

// scan position
private _marker = missionNamespace getVariable ["JM_TicketsZoneMarker", ""];
private _pos = if (_marker isEqualTo "") then { getPosATL _dropoffObj } else { getMarkerPos _marker };
private _rad = (missionNamespace getVariable ["JM_TicketsZoneRadius", 10]) max 1;

// bags in zone
private _bags = nearestObjects [_pos, ["ACE_bodyBagObject"], _rad];

private _valid = [];
private _ignored = 0;

{
    if (_x getVariable ["JM_Tickets_counted", false]) then { continue; };

    if (_x getVariable ["JM_Tickets_isPlayerBag", false]) then {
        _valid pushBack _x;
    } else {
        _ignored = _ignored + 1;
    };
} forEach _bags;

private _count = count _valid;

if (_count <= 0) exitWith {
    if (missionNamespace getVariable ["JM_TicketsNotify", true]) then {
        ["JM_TicketsMedevac_notify", [
            "No player bodybags detected in the drop-off zone.",
            "MEDEVAC FAILED",
            "x\zen\addons\context_actions\ui\medical_cross_ca.paa"
        ]] call CBA_fnc_globalEvent;
    };
};

// mark counted + delete
{
    _x setVariable ["JM_Tickets_counted", true, true];
    if (missionNamespace getVariable ["JM_TicketsDeleteBag", true]) then {
        deleteVehicle _x;
    };
} forEach _valid;

// award tickets
private _perBag = (missionNamespace getVariable ["JM_TicketsPerBag", 1]) max 0;
private _delta = _count * _perBag;

private _newPool = [_delta] call JM_TicketsMedevac_fnc_addTickets;

// nice msg
private _msg = format [
    "<t align='center' size='1.1'>Recovered %1 bodybag(s)</t><br/>" +
    "<t align='center'>+%2 ticket(s)</t><br/>" +
    "<t align='center'>Tickets available: %3</t>%4",
    _count,
    _delta,
    _newPool,
    if (_ignored > 0) then {
        format ["<br/><t size='0.9' color='#BBBBBB' align='center'>Ignored %1 non-player bag(s)</t>", _ignored]
    } else { "" }
];

if (missionNamespace getVariable ["JM_TicketsNotify", true]) then {
    ["JM_TicketsMedevac_notify", [
        _msg,
        "MEDEVAC RECOVERY",
        "x\zen\addons\context_actions\ui\medical_cross_ca.paa"
    ]] call CBA_fnc_globalEvent;
};

// process queue (auto-reinsert)
[] call JM_TicketsMedevac_fnc_processQueue;

