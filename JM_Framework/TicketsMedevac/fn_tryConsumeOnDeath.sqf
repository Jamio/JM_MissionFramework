params ["_unit", "_defaultRespawnTime"];
if (!isServer) exitWith {};
if !(missionNamespace getVariable ["JM_TicketsMedevac", false]) exitWith {};
if (isNull _unit) exitWith {};
if (!isPlayer _unit) exitWith {};
if (alive _unit) exitWith {}; // only relevant if dead

private _cost = (missionNamespace getVariable ["JM_TicketsCostPerRespawn", 1]) max 1;
private _pool = missionNamespace getVariable ["JM_tickets_pool", 0];

private _hasTickets = (_pool >= _cost);

if (_hasTickets) then {
    private _remaining = _pool - _cost;

    // Consume immediately
    missionNamespace setVariable ["JM_tickets_pool", _remaining, true];

    // Tell client: allow normal respawn delay
    [_defaultRespawnTime, true] remoteExecCall ["JM_TicketsMedevac_fnc_onDeathResultClient", owner _unit];

    // Show ticket hint to that client (only)
    [_cost, _remaining] remoteExecCall ["JM_TicketsMedevac_fnc_showTicketHintClient", owner _unit];
	
} else {
    // No tickets: queue them
    [_unit] call JM_TicketsMedevac_fnc_enqueueWaiting;

    // Tell this client: stay blocked + go spectator
    [_defaultRespawnTime, false] remoteExecCall ["JM_TicketsMedevac_fnc_onDeathResultClient", owner _unit];
};
