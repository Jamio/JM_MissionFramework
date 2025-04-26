
// ******************** FRAMEWORK - DO NOT TOUCH ******************************************

#include "JM_Framework\UnconSpectator\initKilled.sqf"

// Retrieve the stored default respawn time, or fallback to 15 if undefined
private _defaultRespawnTime = missionNamespace getVariable ["JM_DefaultRespawnTime", 15];

// Prevent immediate respawn issues
setPlayerRespawnTime 99999; // This ensures that the respawn timer doesn't continue before permadeath logic is applied

// Permadeath check with Zeus exclusion
if (JM_Permadeath) then {
    if (!isNull getAssignedCuratorLogic player || {player isEqualTo zeus1}) then {
        // If player is a Zeus, use normal respawn behavior
        setPlayerRespawnTime _defaultRespawnTime;
    } else {
        // If player is NOT a Zeus, apply permadeath behavior
        [] spawn {
            sleep 5;

            // Adjust vision modes, limit to first person or follow, limit to player

            [[1,2], [0]] call ace_spectator_fnc_updateCameraModes;
            [[-2], [-1,0,1]] call ace_spectator_fnc_updateVisionModes;

            private _specTeam = allPlayers select {side _x == side player};
            private _specZeus = allPlayers select { !isNull getAssignedCuratorLogic _x };

            // Identify all remote-controlled units
            private _remoteControlledUnits = allUnits select { !isNull remoteControlled _x };

            // Add remote-controlled units to the Zeus blacklist
            _specZeus = _specZeus + _remoteControlledUnits;

            [_specTeam, _specZeus] call ace_spectator_fnc_updateUnits;

            [true, true, true] call ace_spectator_fnc_setSpectator;  // Puts player into spectator mode
        };
    };
} else {
    // Normal respawn behavior when permadeath is disabled
    setPlayerRespawnTime _defaultRespawnTime;
};


