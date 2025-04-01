
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
            [true, true, true] call ace_spectator_fnc_setSpectator;  // Puts player into spectator mode
        };
    };
} else {
    // Normal respawn behavior when permadeath is disabled
    setPlayerRespawnTime _defaultRespawnTime;
};


