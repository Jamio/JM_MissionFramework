

if (JM_isPermadeathEnabled) then {
    // Set respawn time to a very high value to prevent automatic respawn
    setPlayerRespawnTime 99999;
    
    // Delay before moving the player into spectator mode
    [] spawn {
        sleep 5;
        [true, true, true] call ace_spectator_fnc_setSpectator;  // Puts player into spectator mode
    };
} else {
    // Normal respawn behavior
    setPlayerRespawnTime 15; // Or whatever your default respawn time is
};