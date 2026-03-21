if (!isServer) exitWith {};
if !(missionNamespace getVariable ["JM_TicketsMedevac", false]) exitWith {};

private _cost = (missionNamespace getVariable ["JM_TicketsCostPerRespawn", 1]) max 1;

private _pool  = missionNamespace getVariable ["JM_tickets_pool", 0];
private _queue = missionNamespace getVariable ["JM_tickets_queue", []];

while { (_queue isNotEqualTo []) && { ( (missionNamespace getVariable ["JM_TicketsPoolMax", 30]) < 0 ) || { _pool >= _cost } } } do {

    // If unlimited tickets, don't consume; otherwise consume
    private _unlimited = (missionNamespace getVariable ["JM_TicketsPoolMax", 30]) < 0;

    private _entry = _queue deleteAt 0;
    _entry params ["_uid", "_t", "_ownerId", "_name"];

    // find current unit for UID
    private _unit = objNull;
    {
        if ((getPlayerUID _x) isEqualTo _uid) exitWith { _unit = _x; };
    } forEach allPlayers;

    // disconnected or already alive skip without consuming
    if (isNull _unit) then { continue; };
    if (alive _unit) then { continue; };

    if (!_unlimited) then {
        _pool = _pool - _cost;
        missionNamespace setVariable ["JM_tickets_pool", _pool, true];
    };

    // Tell that client to respawn
    [] remoteExecCall ["JM_TicketsMedevac_fnc_respawnClient", _ownerId];

    if (missionNamespace getVariable ["JM_TicketsNotify", true]) then {
        ["JM_TicketsMedevac_notify", [
            format [
                "<t align='center'>Reinserted %1</t><br/><t align='center'>Tickets available: %2</t>",
                _name,
                (missionNamespace getVariable ["JM_tickets_pool", 0])
            ],
            "REINSERTION AUTHORIZED",
            "a3\ui_f\data\IGUI\Cfg\Actions\heal_ca.paa"
        ]] call CBA_fnc_globalEvent;
    };
};

missionNamespace setVariable ["JM_tickets_queue", _queue, true];

