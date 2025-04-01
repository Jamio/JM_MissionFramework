params ["_unit"];

    // ["Your eyes feel heavy...", "PLAIN", 3, true, false] remoteExec ["titleText", _player];
    // ["Your eyes feel heavy...", 1, 5, [1,0,0,0.6], false] remoteExec ["BIS_fnc_WLSmoothText", _player];
	["You feel a weight lifting from your eyes...", 1, 5, [1,0,0,0.6], false] call BIS_fnc_WLSmoothText;
	

	sleep 2;

JM_blind ppEffectAdjust [0];  // Adjust the blur intensity to 3
JM_blind ppEffectCommit 10;    // Commit the effect over 5 seconds

sleep 10;

ppEffectDestroy JM_blind;






