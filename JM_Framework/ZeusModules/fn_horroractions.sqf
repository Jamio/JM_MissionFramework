

params ["_unit"];

_unit addAction
[
	"Toggle Invisibility",	// title
	{
		params ["_target", "_caller", "_actionId", "_arguments"];
		
		// Check if the unit is currently hidden (use a variable to track this)
		private _isHidden = _target getVariable ["isHidden", false];

		if (_isHidden) then {
			// If the unit is hidden, unhide it
			[_target, false] remoteExec ["hideObjectGlobal", 2]; // Broadcast to all clients and server
			_target setVariable ["isHidden", false, true]; // Update variable to reflect current state
			hint "Unit is now visible.";
		} else {
			// If the unit is visible, hide it
			[_target, true] remoteExec ["hideObjectGlobal", 2]; // Broadcast to all clients and server
			_target setVariable ["isHidden", true, true]; // Update variable to reflect current state
			hint "Unit is now hidden.";
		};
	
	},
	nil,		// arguments
	1.5,		// priority
	true,		// showWindow
	false,		// hideOnUse
	"",			// shortcut
	"true",		// condition
	0.5,			// radius
	false,		// unconscious
	"",			// selection
	""			// memoryPoint
];

// Add a toggle action to the unit to attach or remove red lights (eyes)
_unit addAction ["Toggle Red Eyes", {
    params ["_target", "_caller", "_actionId"];
    
    // Check if lights are already attached (use a variable to track this)
    private _lightsAttached = _target getVariable ["lightsAttached", false];

    if (_lightsAttached) then {
        // Lights are attached, so we retrieve and delete them
        private _leftLight = _target getVariable ["leftLight"];
        private _rightLight = _target getVariable ["rightLight"];

        if (!isNull _leftLight) then {
            deleteVehicle _leftLight;
            _target setVariable ["leftLight", objNull];  // Set to objNull to ensure cleanup
        };
        if (!isNull _rightLight) then {
            deleteVehicle _rightLight;
            _target setVariable ["rightLight", objNull];  // Set to objNull to ensure cleanup
        };

        _target setVariable ["lightsAttached", false, true]; // Update the variable
        hint "Red eyes turned off.";
    } else {
        // Lights are not attached, so we create and attach them
        private _leftLight = "Reflector_Cone_01_red_F" createVehicle [0,0,0];
        private _rightLight = "Reflector_Cone_01_red_F" createVehicle [0,0,0];

        // Attach the lights to the unit's head
        _leftLight attachTo [_target, [0.2, 0.03, 0.15], "Head"];  // Left eye (adjust position as needed)
        _rightLight attachTo [_target, [-0.2, 0.03, 0.15], "Head"]; // Right eye (adjust position as needed)

        // Store the light objects for future reference (so we can delete them later)
        _target setVariable ["leftLight", _leftLight, true];
        _target setVariable ["rightLight", _rightLight, true];
        _target setVariable ["lightsAttached", true, true]; // Update the variable
        hint "Red eyes turned on.";
    };
}];
