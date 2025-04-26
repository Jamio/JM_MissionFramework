/*
    JM_Permadeath_fnc_forceRespawn
    Params:
        0: OBJECT - Target position or vehicle
        1: BOOL   - Whether to teleport the player after respawn
*/

params ["_destination", "_teleportHere"];

[] spawn {
    // 1. Exit ACE Spectator
    [false, false, false] call ace_spectator_fnc_setSpectator;

    // 2. Reset the player's respawn delay to default
    private _defaultRespawnTime = missionNamespace getVariable ["JM_DefaultRespawnTime", 15];
    setPlayerRespawnTime _defaultRespawnTime;

    // 3. Wait until the player has respawned
    waitUntil {alive player};

    sleep 1;

    // 4. Handle teleportation if selected
    if (_teleportHere && {!isNull _destination}) then {

        if (_destination isKindOf "LandVehicle" || _destination isKindOf "Air" || _destination isKindOf "Ship") then {
            private _emptySeats = _destination emptyPositions "cargo";

            if (_emptySeats > 0) then {
                player moveInCargo _destination;
            } else {
                systemChat "No cargo space available — teleport cancelled.";
            };
        } else {
            // Not a vehicle, it's just a 3D position
            player setPosATL _destination;
        };
    };
};


