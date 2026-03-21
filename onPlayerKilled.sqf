// ******************** FRAMEWORK - DO NOT TOUCH ******************************************

#include "JM_Framework\UnconSpectator\initKilled.sqf"

// Retrieve the stored default respawn time, or fallback to 15 if undefined
private _defaultRespawnTime = missionNamespace getVariable ["JM_DefaultRespawnTime", 15];

// Prevent immediate respawn issues
setPlayerRespawnTime 99999; // Ensures that the respawn timer doesn't continue before logic is applied

// ----------------------------------------------------------------------------------------
// PERMADEATH MODE (priority)
// ----------------------------------------------------------------------------------------
if (JM_Permadeath) then {

    // Permadeath check with Zeus exclusion
    if (!isNull getAssignedCuratorLogic player || {player isEqualTo zeus1}) then {

        // If player is a Zeus, use normal respawn behavior
        private _zeusRespawnTime = getMissionConfigValue ["respawnDelay", 5];
        setPlayerRespawnTime _zeusRespawnTime;

    } else {

        // If player is NOT a Zeus, apply permadeath behavior
        [] spawn {
            sleep 5;

            // Adjust vision modes, limit to first person or follow, limit to player
            [[1,2], [0]] call ace_spectator_fnc_updateCameraModes;
            [[-2], [-1,0,1]] call ace_spectator_fnc_updateVisionModes;

            private _specTeam = allPlayers select { side _x == side player };
            private _specZeus = allPlayers select { !isNull getAssignedCuratorLogic _x };

            // Identify all remote-controlled units and add to Zeus blacklist
            private _remoteControlledUnits = allUnits select { !isNull remoteControlled _x };
            _specZeus = _specZeus + _remoteControlledUnits;

            [_specTeam, _specZeus] call ace_spectator_fnc_updateUnits;

            [true, true, true] call ace_spectator_fnc_setSpectator;  // Puts player into spectator mode
        };
    };

} else {

    // ------------------------------------------------------------------------------------
    // TICKETS MEDEVAC MODE (custom tickets)
    // Server decides immediately:
    //  - If tickets exist: consumes one and allows normal respawn time
    //  - If no tickets: queues player and keeps them blocked/spectating
    // ------------------------------------------------------------------------------------
    if (missionNamespace getVariable ["JM_TicketsMedevac", false]) then {

        // Block by default until server responds
        setPlayerRespawnTime 99999;

        // Ask server to either allow normal respawn (consume ticket) or queue us
        [player, _defaultRespawnTime] remoteExecCall ["JM_TicketsMedevac_fnc_tryConsumeOnDeath", 2];

    } else {

        // --------------------------------------------------------------------------------
        // NORMAL RESPAWN MODE
        // --------------------------------------------------------------------------------
        setPlayerRespawnTime _defaultRespawnTime;
    };
};
