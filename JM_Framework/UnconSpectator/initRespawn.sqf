// onPlayerRespawn.sqf

    // Disable spectator mode briefly
    [false] call ace_spectator_fnc_setSpectator;

    [[1,2], [0]] call ace_spectator_fnc_updateCameraModes;
    [[-2], [-1,0,1]] call ace_spectator_fnc_updateVisionModes;

    private _specTeam = allPlayers select {side _x == side player};
    private _specZeus = allPlayers select { !isNull getAssignedCuratorLogic _x };

    // Identify all remote-controlled units
    private _remoteControlledUnits = allUnits select { !isNull remoteControlled _x };

    // Add remote-controlled units to the Zeus blacklist
    _specZeus = _specZeus + _remoteControlledUnits;

    [_specTeam, _specZeus] call ace_spectator_fnc_updateUnits;