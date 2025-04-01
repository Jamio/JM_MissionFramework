/*
    JM_Permadeath_fnc_forceRespawn
    Params:
        0: OBJECT - The target location or vehicle (module or vehicle placed by Zeus)
        1: BOOL   - Whether to teleport the player to the target position
        2: BOOL   - Whether to try and place the player into cargo (if applicable)
*/

params ["_target", "_teleportToPos", "_placeInCargo"];

[] spawn {
    // 1. Exit ACE Spectator
    [false, false, false] call ace_spectator_fnc_setSpectator;

    // 2. Reset the player's respawn delay to the default (for future deaths)
    private _defaultRespawnTime = missionNamespace getVariable ["JM_DefaultRespawnTime", 15];
    setPlayerRespawnTime _defaultRespawnTime;

    // 3. Wait until the player has respawned
    waitUntil {alive player};

    // 4. Handle teleportation or cargo placement
    if (_teleportToPos && {!isNull _target}) then {
        if (_placeInCargo && {
            _target isKindOf "LandVehicle" ||
            _target isKindOf "Air" ||
            _target isKindOf "Ship"
        }) then {
            private _cargoSeats = _target emptyPositions "cargo";
            if (_cargoSeats > 0) then {
                player moveInCargo _target;
            } else {
                player setPos (getPos _target); // fallback if no space
            };
        } else {
            player setPos (getPos _target);
        };
    };


};
