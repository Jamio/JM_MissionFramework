if (!isServer) exitWith {};
if !(missionNamespace getVariable ["JM_TicketsMedevac", false]) exitWith {};

// Init pool + queue (server authority)
private _start = missionNamespace getVariable ["JM_TicketsPoolStart", 0];
missionNamespace setVariable ["JM_tickets_pool", _start, true];
missionNamespace setVariable ["JM_tickets_queue", [], true];

// Mark player corpses at time of death (so enemy bags never count)
addMissionEventHandler ["EntityKilled", {
    params ["_killed"];
    if (isNull _killed) exitWith {};

    if (isPlayer _killed) then {
        _killed setVariable ["JM_Tickets_isPlayerCorpse", true, true];
        _killed setVariable ["JM_Tickets_playerName", name _killed, true];
    };
}];

// When ACE bags a body, transfer player-corpse tag to the bag
["ace_placedInBodyBag", {
    params ["_unit", "_bag"];
    if (isNull _bag) exitWith {};

    private _isPlayerCorpse = _unit getVariable ["JM_Tickets_isPlayerCorpse", false];
    _bag setVariable ["JM_Tickets_isPlayerBag", _isPlayerCorpse, true];

    if (_isPlayerCorpse) then {
        _bag setVariable ["JM_Tickets_playerName", _unit getVariable ["JM_Tickets_playerName", "Unknown"], true];
    };
}] call CBA_fnc_addEventHandler;

