params ["_unit"];

    // ["Your eyes feel heavy...", "PLAIN", 3, true, false] remoteExec ["titleText", _player];
    // ["Your eyes feel heavy...", 1, 5, [1,0,0,0.6], false] remoteExec ["BIS_fnc_WLSmoothText", _player];
	["Your eyes feel heavy...", 1, 5, [1,0,0,0.6], false] call BIS_fnc_WLSmoothText;
	

	sleep 5;

// Apply the blur effect
JM_blind = ppEffectCreate ["DynamicBlur", 100];  // Create the blur effect

// Enable and apply the blur effect with a 5-second transition
JM_blind ppEffectEnable true;
JM_blind ppEffectAdjust [5];  // Adjust the blur intensity to 3
JM_blind ppEffectCommit 10;    // Commit the effect over 5 seconds




