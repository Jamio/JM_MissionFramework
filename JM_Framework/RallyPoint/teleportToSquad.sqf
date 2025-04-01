
// Check if teleporting to squad is enabled
if !(JM_tpToSL) exitWith {
    hint "Squad teleport is currently disabled.";
};

// Get the player who used the action
private _player = player;
private _group = group _player;
private _squadLeader = leader _group;

// Find all squad members excluding the player
private _squadMembers = units _group - [_player];

// Filter to find valid teleport targets (alive and 50m away)
private _validTargets = _squadMembers select {alive _x && {_x distance _player > 50}};

// Function to attempt teleporting to a given target
private _teleportTo = {
    params ["_target"];
    
    // Apply fade-to-black effect
    "test" cutText ["", "BLACK", 0.5, true];
    sleep 1;

    private _veh = vehicle _target;
    if (_veh != _target) then {
        // Target is inside a vehicle
        private _passengerSeats = fullCrew [_veh, "cargo"]; // Get all passenger slots
        if (count _passengerSeats > 0) then {
            _player moveInCargo _veh; // Try moving into the vehicle
            sleep 0.1; // Small delay to ensure the action registers
            
            // Check if the teleport actually worked
            if (vehicle _player == _veh) then {
                hint format ["Teleported into %1's vehicle!", name _target];
                "test" cutFadeout 2; // Smooth fade back in
                true // Mark teleport as successful
            } else {
                false // Vehicle was full, teleport failed
            };
        } else {
            false // No available seats
        };
    } else {
        // Target is on foot, teleport directly
        _player setPosASL getPosASL _target;
        hint format ["Teleported to %1!", name _target];
        "test" cutFadeout 2; // Smooth fade back in
        true
    };
};

// Try teleporting to the squad leader first
private _success = false;
if (alive _squadLeader && {_squadLeader distance _player > 50}) then {
    _success = [_squadLeader] call _teleportTo;
};

// If teleport to squad leader failed, try other squadmates
if (!_success) then {
    {
        _success = [_x] call _teleportTo;
        if (_success) exitWith {}; // Stop searching if successful
    } forEach _validTargets;
};

// If no valid squadmates were found
if (!_success) then {
    hint "No valid squad members are far enough away to teleport to, or all vehicles are full.";
    "test" cutFadeout 2; // Ensure fade-out happens even if no teleport
};



