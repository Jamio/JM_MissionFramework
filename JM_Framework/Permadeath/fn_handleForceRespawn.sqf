/*
    JM_Permadeath_fnc_handleForceRespawn
    Called on the server to get valid machine IDs (owner IDs) for a given set of dead/spectating players,
    and trigger JM_Permadeath_fnc_forceRespawn only on those machines.

    Params:
    0: ARRAY of OBJECTS - Players to respawn
    1: ARRAY - Destination data ["VEHICLE", netId] or ["POS", positionArray]
    2: BOOL - Teleport to destination immediately?
*/

params ["_players", "_destinationData", "_teleportHere"];

if (!isServer) exitWith {
    diag_log "[PERMADEATH] handleForceRespawn was not run on the server!";
};

private _targetClients = [];

{
    if (!isNull _x && {isPlayer _x}) then {
        private _owner = owner _x;
        if (_owner > 0) then {
            _targetClients pushBackUnique _owner;
            diag_log format ["[PERMADEATH] Added %1 (owner %2) to targetClients", name _x, _owner];
        } else {
            diag_log format ["[PERMADEATH] Skipped %1 (no valid owner)", name _x];
        };
    };
} forEach _players;

if (_targetClients isEqualTo []) exitWith {
    diag_log "[PERMADEATH] No valid owner IDs found for selected players.";
};

[_destinationData, _teleportHere] remoteExec ["JM_Permadeath_fnc_forceRespawn", _targetClients];
diag_log format ["[PERMADEATH] Respawn sent to clients: %1", _targetClients];
