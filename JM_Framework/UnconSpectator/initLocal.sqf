
// *********************************************************************************
// ************** HANDLE UNCONSCIOUS to SPECTATOR OR LOCAL COMMS
// **********************************************************************************

/* This eventhandler is applied on ace uncon. When player goes uncon, the eventhandler checks if the GVAR unconSpectator is set to true.
If JM_unconSpectator returns true, then it will put the local player into EG spectator.
There is also a small function here that I added that plays a bunch of random "medic!" sounds. The actual sounds can be tweaked in here, and the random frequency.
There is a check for if players of the same side are nearby too, to avoid your patients shouting in your ears while you heal them.

*/

["ace_unconscious", {
    params ["_unit", "_enable"];
    if (_unit isNotEqualTo player) exitWith {};

    // Check if spectator mode is enabled
    if (JM_unconSpectator) then {
        // Spectator logic when unconscious
        if (_enable) then {
            _unit setVariable ["ace_medical_feedback_effectUnconsciousTimeout", 10e10];
            [{ 

                if (!(player getVariable ["ace_isunconscious", false]) || {!alive player}) exitWith {};

                [true, true, false] call ace_spectator_fnc_setSpectator;
                hint "You are unconscious! Entering spectator mode.";

                // Spawn block that uses player directly
                [] spawn {
                    private _unit = player;  // Assign _unit to player

                    private _alone = true;


                    // Array of medic sounds
                    private _medicSounds = ["medic1", "medic2", "medic3", "medic4", "medic5", "medic6", "medic7", "medic8", "medic9", "medic10", 
                                            "medic11", "medic12", "medic13", "medic14", "medic15", "medic16", "medic17", "medic18", "medic19", 
                                            "medic20", "medic21", "medic22", "medic23", "medic24", "medic25", "medic26", "medic27", "medic28", 
                                            "medic29", "medic30", "medic31", "medic32", "medic33", "medic34", "medic35", "medic36", "medic37"];

                    // Loop while player is unconscious
                    while {player getVariable ["ace_isunconscious", false]
                    } do {
                            private _nearPlyrs = allPlayers select {
                                        side _x == side player && (_x distance player) < 5 && _x != player
                                    };

                                    // Check if there are any nearby players on the same side
                                    if (count _nearPlyrs > 0) then {
                                        _alone = false;
                                    } else {
                                        _alone = true;
                                    };

                                    // If alone, play the medic sound
                                    if (_alone) then {
                                        // Select random medic call sound
                                        private _randomSound = selectRandom _medicSounds;

                                        [_unit, _randomSound] remoteExec ["say3D", 0, true];
                                    };

                        // Random sleep time between 15 and 35 seconds
                        sleep (25 + random 15); 
                    };

                };
            }, nil, 5] call CBA_fnc_waitAndExecute;
        } else {
            [false] call ace_spectator_fnc_setSpectator;
        };
    } else {
        // If spectator mode is NOT enabled, allow local speaking when unconscious
        [_unit, "blockSpeaking", "ace_unconscious", false] call ace_common_fnc_statusEffect_set;

        // ENABLEUSERINPUT
        [false] call ace_common_fnc_disableUserInput;

        // Ensure ACE black screen is disabled by overriding unconscious feedback
        [false, 0] call ace_medical_feedback_fnc_effectUnconscious;

        // Apply a custom blur effect when the player is unconscious
        private _blurEffect = ppEffectCreate ["DynamicBlur", 815];
        _blurEffect ppEffectForceInNVG true;
        _blurEffect ppEffectAdjust [0];
        _blurEffect ppEffectCommit 0;
        _blurEffect ppEffectEnable false;

        if (_enable) then {
            _unit setVariable ["ace_medical_feedback_effectUnconsciousTimeout", 10e10];
            _blurEffect ppEffectEnable true;
            _blurEffect ppEffectAdjust [4];
            _blurEffect ppEffectCommit 3;

            // Optional: Display text or message while unconscious
            titleText ["You are unconscious", "PLAIN DOWN", 2];

        } else {
            _unit setVariable ["ace_medical_feedback_effectUnconsciousTimeout", nil];
            _blurEffect ppEffectEnable true;
            _blurEffect ppEffectAdjust [0];
            _blurEffect ppEffectCommit 5;
        };
    };
}] call CBA_fnc_addEventHandler;


        


// Handle death and blur effect on Killed event
["CAManBase", "Killed", {
    params ["_unit"];
    if (!blurUnconScreen || {_unit isNotEqualTo player}) exitWith {};
    unconBlur ppEffectEnable true;
    unconBlur ppEffectAdjust [0];
    unconBlur ppEffectCommit 1;
}] call CBA_fnc_addClassEventHandler;


// *********************************************************************************
// ************** HANDLE SPECTATOR MODE SETUP // include team, hide zeuses
// **********************************************************************************

// Respawn event handler to remove ACE spectator mode on respawn
player addEventHandler ["Respawn", {
    if !(JM_unconSpectator) exitWith {};
    [false] call ace_spectator_fnc_setSpectator;
}];

// Adjust vision modes, limit to first person or follow, limit to player

[[1,2], [0]] call ace_spectator_fnc_updateCameraModes;
[[-2], [-1,0,1]] call ace_spectator_fnc_updateVisionModes;

private _specTeam = allPlayers select {side _x == side player};
private _specZeus = allPlayers select { !isNull getAssignedCuratorLogic _x };

// Identify all remote-controlled units
private _remoteControlledUnits = allUnits select { !isNull remoteControlled _x };

// Add remote-controlled units to the Zeus blacklist
_specZeus = _specZeus + _remoteControlledUnits;

[_specTeam, _specZeus] call ace_spectator_fnc_updateUnits;


// *********************************************************************************
// ************** APPLY NEW ANIMS FOR ACE UNCON IF PLAYER IS ON FOOT
// **********************************************************************************

/* This eventhandler is applied on ace uncon. When player goes uncon, the eventhandler compiles anims list.
Then, if player is still alive but uncon AND not in a vehicle (weird seeing anims apply to drivers etc.) AND not attached to anything (i.e being dragged/carried)
then one of the random anims is remoteExec'd. Also creates an eventHandle to deal with when the player gets carried or dragged to break out of the current anim.
*/

["ace_unconscious", {
    params ["_unit", "_enable"];
    if (_unit isNotEqualTo player) exitWith {};
    
    // Stop the current unconscious animation immediately
    [_unit, ""] remoteExec ["switchMove", 0, true];

    // Add the "Attached" event handler to the unconscious player
    _JM_AnimBreak = _unit addEventHandler ["Attached", {
        params ["_unit", "_attacher"];
        
        // Stop the current unconscious animation immediately
        [_unit, ""] remoteExec ["switchMove", 0, true];
    }];

    // Store the event handler ID for later removal
    _unit setVariable ["JM_AnimBreakID", _JM_AnimBreak, true];



    _JM_AnimBreak = ["Attached", {[_unit, ""] remoteExec ["switchMove", 0, true]}] call CBA_fnc_addPlayerEventHandler;

    // Function to handle applying animations
    if (_enable && (isNull objectParent _unit)) then {
        [] spawn {
            private _unit = player;

            // List of custom animations to use while unconscious
            private _unconAnims = [
                "Acts_CivilInjuredArms_1",
                "Acts_CivilInjuredChest_1",
                "Acts_CivilInjuredGeneral_1",
                "Acts_CivilInjuredHead_1",
                "Acts_CivilInjuredLegs_1",
                "Acts_InjuredLyingRifle01",
                "Acts_InjuredLyingRifle02",
                "UnconsciousReviveBody_A",
                "UnconsciousReviveBody_B",
                "UnconsciousReviveArms_A",
                "UnconsciousReviveArms_B",
                "UnconsciousReviveHead_A",
                "UnconsciousReviveHead_B",
                "UnconsciousReviveHead_C",
                "UnconsciousReviveLegs_A",
                "UnconsciousReviveLegs_B"
            ];

            // Select a random animation when the player first goes unconscious
            private _selectedAnim = selectRandom _unconAnims;

            sleep 5;

            // Apply the selected animation immediately
            [_unit,_selectedAnim] remoteExec ["switchMove", 0, true];

            // Continuously loop while the player is unconscious, not in any vehicle seat AND still alive
            while {player getVariable ["ace_isunconscious", false] && (isNull objectParent player) && (isNull attachedTo player)} do {
                // Check if the current animation is not the selected one
                if (animationState _unit != _selectedAnim) then {
                    // Reapply the selected animation to maintain consistency
                    [_unit, _selectedAnim] remoteExec ["switchMove", 0, true];
                };

                // Use a short delay to frequently check the animation state without overwhelming performance
                sleep 0.1;
            };
        };
    };
}] call CBA_fnc_addEventHandler;

// *******************************************************************
// ********* REMOVE ATTACHED EVENTHANDLER WHEN NOT UNCON
// *******************************************************************

["ace_unconscious", {
    params ["_unit", "_enable"];
    if (_unit isNotEqualTo player) exitWith {};

    if (!_enable) then {

    // Stop anim and prone rollout
    [_unit, "UnconsciousOutProne"] remoteExec ["playMove", 0, true];

        // Retrieve the event handler ID from the variable
        _animBreakID = _unit getVariable ["JM_AnimBreakID", -1];  // Default to -1 if not found

        if (_animBreakID != -1) then {
            // Remove the event handler using the stored ID
            _unit removeEventHandler ["Attached", _animBreakID];
        };
    };
}] call CBA_fnc_addEventHandler;







