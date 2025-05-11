
// *********************************************************************************
// ************** HANDLE UNCONSCIOUS to SPECTATOR OR LOCAL COMMS
// **********************************************************************************

// Setup blur effect
private _effect = ppEffectCreate ["DynamicBlur", 815];
_effect ppEffectForceInNVG true;
_effect ppEffectAdjust [0];
_effect ppEffectCommit 0;
_effect ppEffectEnable false;
JM_unconBlur = _effect;

// Handle ACE unconscious state
["ace_unconscious", {
    params ["_unit", "_enable"];
    if (_unit isNotEqualTo player) exitWith {};

    // Use ACE spectator if enabled
    if (JM_unconSpectator) exitWith {
    if (_enable) then {
        _unit setVariable ["ace_medical_feedback_effectUnconsciousTimeout", 10e10];

        [{
            if (!(player getVariable ["ace_isunconscious", false]) || {!alive player}) exitWith {};
            [true, true, false] call ace_spectator_fnc_setSpectator;

            // Apply custom spectator camera/vision/unit filters
            [[1,2], [0]] call ace_spectator_fnc_updateCameraModes;
            [[-2], [-1,0,1]] call ace_spectator_fnc_updateVisionModes;

            private _specTeam = allPlayers select {side _x == side player};
            private _specZeus = allPlayers select { !isNull getAssignedCuratorLogic _x };
            private _remoteControlledUnits = allUnits select { !isNull remoteControlled _x };
            _specZeus = _specZeus + _remoteControlledUnits;

            [_specTeam, _specZeus] call ace_spectator_fnc_updateUnits;

            [{
                hint "You are unconscious!";
            }, nil, 0.5] call CBA_fnc_waitAndExecute;

        }, nil, 5] call CBA_fnc_waitAndExecute;

        } else {
            [false] call ace_spectator_fnc_setSpectator;
        };
    };

    // If blur is enabled and player is not Zeus
    if (!JM_blurUnconScreen || {!(isNull (getAssignedCuratorLogic _unit))}) exitWith {};

    if (_enable) then {
        _unit setVariable ["ace_medical_feedback_effectUnconsciousTimeout", 10e10];
        
        [{
            if !(player getVariable ["ace_isunconscious", false]) exitWith {};
            [false, 0] call ace_medical_feedback_fnc_effectUnconscious;
        }] call CBA_fnc_execNextFrame;

        JM_unconBlur ppEffectEnable true;
        JM_unconBlur ppEffectAdjust [4];
        JM_unconBlur ppEffectCommit 3;

    } else {
        _unit setVariable ["ace_medical_feedback_effectUnconsciousTimeout", nil];
        JM_unconBlur ppEffectEnable true;
        JM_unconBlur ppEffectAdjust [0];
        JM_unconBlur ppEffectCommit 5;
    };
}] call CBA_fnc_addEventHandler;

// Reset blur immediately on death
["CAManBase", "Killed", {
    params ["_unit"];
    if (!JM_blurUnconScreen || {_unit isNotEqualTo player}) exitWith {};
    JM_unconBlur ppEffectEnable true;
    JM_unconBlur ppEffectAdjust [0];
    JM_unconBlur ppEffectCommit 1;
}] call CBA_fnc_addClassEventHandler;

// Clear spectator mode on respawn
player addEventHandler ["Respawn", {
    if !(JM_unconSpectator) exitWith {};
    [false] call ace_spectator_fnc_setSpectator;
}];

if(!JM_unconMarker) exitWith {};

addMissionEventHandler ["Draw3D", {
    {
        if (
            alive _x &&
            _x getVariable ["ace_isunconscious", false] &&
            (player distance _x) < 15
        ) then {
            // Position above head
            private _pos = _x modelToWorldVisual [0,0,1];

            drawIcon3D [
                "a3\ui_f\data\igui\cfg\revive\overlayiconsgroup\u75_ca.paa",  // Icon image
                [1, 0, 0, 0.8], // Color RGBA (red)
                _pos,
                1, 1, 0,    // SizeX, SizeY, Angle
                format ["%1 - UNCONSCIOUS", name _x],
                0,
                0.025,
                "PuristaMedium"
            ];
        };
    } forEach allPlayers;
}];







