/*
    JM_Permadeath_fnc_forceRespawn
    Params:
        0: OBJECT - Target position or vehicle
        1: BOOL   - Whether to teleport the player after respawn
*/

params ["_destinationData", "_teleportHere"];

// systemChat format ["[DEBUG] forceRespawn params: destinationData=%1, teleportHere=%2", _destinationData, _teleportHere];




private _debug = true;  // Set this same as your module for testing

[_destinationData, _teleportHere, _debug] spawn {
    params ["_destinationData", "_teleportHere", "_debug"];

    titleText ["<t font='PuristaBold' color='#ffdb33' size='2'>Redeploying...</t>", "BLACK OUT", 1, true, true];

    sleep 3;
    [false, false, false] call ace_spectator_fnc_setSpectator;
    setPlayerRespawnTime 1;

    
    waitUntil {alive player};
    

    sleep 1;

    private _destination = objNull;
    private _isVehicle = false;

    if (_destinationData isEqualType []) then {
        private _type = _destinationData select 0;
        private _value = _destinationData select 1;

        // systemChat format ["[DEBUG] _type=%1 _value=%2", _type, _value];

        if (_type isEqualTo "VEHICLE") then {
            _destination = objectFromNetId _value;
            _isVehicle = true;
        } else {
            _destination = _value;
        };
    };

    systemChat format ["[DEBUG] Decoded destination: %1 (isVehicle=%2)", _destination, _isVehicle];

    // FALLBACK: If _target is invalid, use module position
    if (_destinationData isEqualType [] && { _destinationData select 1 isEqualTo [0,0,0] }) then {
        _destinationData set [1, position _target];
    };

    // systemChat format ["[DEBUG] Decoded destination: %1 (isVehicle=%2)", _destination, _isVehicle];


    if (_teleportHere) then {
        if (_isVehicle && {!isNull _destination}) then {
            private _emptySeats = _destination emptyPositions "cargo";
            if (_emptySeats > 0) then {
                player moveInCargo _destination;
                systemChat "Moved into vehicle cargo (DEBUG)";
            } else {
                systemChat "No cargo space available — teleport cancelled.";
            };
        } else {
            player setPosATL _destination;
            systemChat format ["Teleported to position (DEBUG): %1", _destination];
        };
    };

    sleep 2;

    titleText ["", "BLACK IN", 2, true, true];
};


