params ["_defaultRespawnTime", "_allowed"];
if (!hasInterface) exitWith {};
if !(missionNamespace getVariable ["JM_TicketsMedevac", false]) exitWith {};

if (_allowed) then {
    // Tickets existed, server consumed one: allow normal respawn delay
    setPlayerRespawnTime _defaultRespawnTime;

    // Optional: ensure we’re not stuck in spectator from any earlier state
    // (Only do this if your framework sometimes leaves spectator on)
    // [false, false, false] call ace_spectator_fnc_setSpectator;

} else {
    // No tickets: hard block respawn and put into spectator
    setPlayerRespawnTime 99999;

    [] spawn {
        sleep 5;

        [[1,2], [0]] call ace_spectator_fnc_updateCameraModes;
        [[-2], [-1,0,1]] call ace_spectator_fnc_updateVisionModes;

        private _specTeam = allPlayers select { side _x == side player };
        private _specZeus = allPlayers select { !isNull getAssignedCuratorLogic _x };

        private _remoteControlledUnits = allUnits select { !isNull remoteControlled _x };
        _specZeus = _specZeus + _remoteControlledUnits;

        [_specTeam, _specZeus] call ace_spectator_fnc_updateUnits;
        [true, true, true] call ace_spectator_fnc_setSpectator;
    };
};
