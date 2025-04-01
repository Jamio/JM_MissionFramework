[] spawn {
  waitUntil {!isNull player};
  waitUntil {  time > 3 };
};

// ["Custom Modules", "Cool Hint", {hint str _this}] call zen_custom_modules_fnc_register




// +++++++++++++++++++++++++++++++++++++++++++
// +++++++ HALLUCINATION - IMAGINARY SOMETHING NOT SURE YET BUT OH WELL
// +++++++++++++++++++++++++++++++++++++++++++

["Jamio", 
 "Hallucinate Player", 
 {
     private _position = _this select 0; // Module Position, not used here
     private _target = _this select 1;   // Attached object, the target player

     // Check if the target is a player and execute the function on their client
     if (!isNull _target && {_target isKindOf "CAManBase"}) then {
         [_target] remoteExec ["JM_ZeusModules_fnc_hallucinate", _target]; // Correct function name with prefix
         diag_log format ["Attempting to execute hallucinate on: %1", name _target]; // Debug log
     } else {
         hint "Module must be placed on a player!";
         diag_log "Error: Module was not placed on a player.";
     };
 }, 
 "\a3\modules_f\data\portraitmodule_ca.paa"] call zen_custom_modules_fnc_register;

// +++++++++++++++++++++++++++++++++++++++++++
// +++++++ POSSESSION - UNIT GORE, SCREAMS, OVERLAY THEN TELEPORT TO NEARBY LOCATION
// +++++++++++++++++++++++++++++++++++++++++++
["Jamio", 
 "Possess Player", 
 {
     private _position = _this select 0; // Module Position, not used here
     private _target = _this select 1;   // Attached object, should be the target unit

     // Check if the target is a valid unit and execute the possess function
     // ["Not a valid target!"] call zen_common_fnc_showMessage
     if (isNull _target || !(_target isKindOf "CAManBase")) exitWith {systemChat "Invalid Target"};


     if (isPlayer _target) then {
         [_target] remoteExec ["JM_ZeusModules_fnc_possessed", _target]; // Execute on all clients for visual consistency
          systemChat format ["Attempting to execute possession on: %1", name _target]; // Debug log
     } else {
        [_target] remoteExec ["JM_ZeusModules_fnc_possessedAI", _target]; // Execute on all clients for visual consistency
        systemChat format ["Attempting to execute AI possession on: %1", name _target];
     };
 }, 
 "\a3\modules_f\data\portraitmodule_ca.paa"] call zen_custom_modules_fnc_register;

// +++++++++++++++++++++++++++++++++++++++++++
// +++++++ TOMBSTONES - LOCAL TOMBSTONE FACING PLAYER, SOUNDS AND PP EFFECTS
// +++++++++++++++++++++++++++++++++++++++++++

["Jamio", 
 "Spawn Tombstones", 
 {
     private _position = _this select 0; // Module Position, not used here
     private _target = _this select 1;   // Attached object, should be the target unit

     // Check if the target is a valid unit and execute the possess function
     if (!isNull _target && {_target isKindOf "CAManBase"}) then {
         [_target] remoteExec ["JM_ZeusModules_fnc_crosses", owner _target]; // Execute on all clients for visual consistency
         diag_log format ["Attempting to execute possess on: %1", name _target]; // Debug log
     } else {
         hint "Module must be placed on a unit!";
         diag_log "Error: Module was not placed on a valid unit.";
     };
 }, 
 "\a3\modules_f\data\portraitmodule_ca.paa"] call zen_custom_modules_fnc_register;

// +++++++++++++++++++++++++++++++++++++++++++
// +++++++ COLDHAUNT - FROST OVERLAY, BREATHING AND BREATH EFFECT
// +++++++++++++++++++++++++++++++++++++++++++

["Jamio", 
 "Coldhaunt", 
 {
     private _position = _this select 0; // Module Position, not used here
     private _target = _this select 1;   // Attached object, should be the target unit

     // Check if the target is a valid unit and execute the coldhaunt function
     if (!isNull _target && {_target isKindOf "CAManBase"}) then {
         [_target] remoteExec ["JM_ZeusModules_fnc_coldhaunt", owner _target]; // Execute on all clients for visual consistency
         systemChat format ["Attempting to execute coldhaunt on: %1", name _target]; // Debug log
     } else {
         hint "Module must be placed on a unit!";
         diag_log "Error: Module was not placed on a valid unit.";
     };
 }, 
 "\a3\modules_f\data\portraitmodule_ca.paa"] call zen_custom_modules_fnc_register;

 // +++++++++++++++++++++++++++++++++++++++++++
// +++++++ FLING - RAGDOLL AND SCREAM
// +++++++++++++++++++++++++++++++++++++++++++

["Jamio", 
 "Fling", 
 {
     private _position = _this select 0; // Module Position, not used here
     private _target = _this select 1;   // Attached object, should be the target unit

     // Check if the target is a valid unit and execute the coldhaunt function
     if (!isNull _target && {_target isKindOf "CAManBase"}) then {
         [_target] remoteExec ["JM_ZeusModules_fnc_fling", _target, false]; // Execute on all clients for visual consistency
         systemChat format ["Attempting to execute fling on: %1", name _target]; // Debug log
     } else {
         hint "Module must be placed on a unit!";
         diag_log "Error: Module was not placed on a valid unit.";
     };
 }, 
 "\a3\modules_f\data\portraitmodule_ca.paa"] call zen_custom_modules_fnc_register;

  // +++++++++++++++++++++++++++++++++++++++++++
// +++++++ CULT _ TELEPORT TO CULT POSITION
// +++++++++++++++++++++++++++++++++++++++++++

["Jamio", 
 "Cult", 
 {
     private _position = _this select 0; // Module Position (used to find nearby players)
     private _radius = 50; // Define the search radius

     // Predefine 5 specific positions and directions (position in ASL format, direction in degrees)
     private _positionsAndDirections = [
         [[6485.26, 3608.67, 0], 28],   // Position 1, Facing 28 degrees
         [[6485.26, 3608.67, 0], 28],   // Position 2, Facing 28 degrees
         [[6485.26, 3608.67, 0], 28],   // Position 3, Facing 28 degrees
         [[6485.26, 3608.67, 0], 28],   // Position 4, Facing 28 degrees
         [[6485.26, 3608.67, 0], 28]    // Position 5, Facing 28 degrees
     ];

     // Filter players within the specified radius of the module's position
     private _nearestPlayers = allPlayers select {_x distance _position < _radius};

     // Count the number of nearest players
     private _nearestPlayerCount = count _nearestPlayers;

     // Ensure the number of players selected is no more than 4
     private _selectCount = _nearestPlayerCount min 4;  // Keep it capped at 4

     // Select up to 4 nearest players
     private _nearestPlayersSubset = _nearestPlayers select [0, _selectCount];

     // Check if we found any players
     if (_selectCount == 0) exitWith {
         hint "No players found within range!";
         diag_log "Error: No players found.";
     };

     // Execute the cult function on the nearest players, passing the positions and directions
     [_nearestPlayersSubset, _positionsAndDirections] remoteExec ["JM_ZeusModules_fnc_cult", _nearestPlayersSubset, false];
     systemChat "Attempting to execute cult on the nearest players."; // Debug log
     
 }, 
 "\a3\modules_f\data\portraitmodule_ca.paa"] call zen_custom_modules_fnc_register;

// +++++++++++++++++++++++++++++++++++++++++++
// +++++++ HORROR ACTIONS
// +++++++++++++++++++++++++++++++++++++++++++

["Jamio", 
 "Add Horror Actions", 
 {
     private _position = _this select 0; // Module Position, not used here
     private _target = _this select 1;   // Attached object, should be the target unit

     // Check if the target is a valid unit and execute the coldhaunt function
     if (!isNull _target && {_target isKindOf "CAManBase"}) then {
         [_target] remoteExec ["JM_ZeusModules_fnc_horroractions", _target, false]; // Execute on all clients for visual consistency
         systemChat format ["Attempting to execute HA on: %1", name _target]; // Debug log
     } else {
         hint "Module must be placed on a unit!";
         diag_log "Error: Module was not placed on a valid unit.";
     };
 }, 
 "\a3\modules_f\data\portraitmodule_ca.paa"] call zen_custom_modules_fnc_register;

 // +++++++++++++++++++++++++++++++++++++++++++
// +++++++ BLIND UNIT
// +++++++++++++++++++++++++++++++++++++++++++

["Jamio", 
 "[Sight] Remove Sight", 
 {
     private _position = _this select 0; // Module Position, not used here
     private _target = _this select 1;   // Attached object, should be the target unit



     // Check if the target is a valid unit and execute the coldhaunt function
     if (!isNull _target && {_target isKindOf "CAManBase"}) then {
         [_target] remoteExec ["JM_ZeusModules_fnc_blindApply", _target, false]; // Execute on all clients for visual consistency
         systemChat format ["Attempting to execute blind on: %1", name _target]; // Debug log
     } else {
         hint "Module must be placed on a unit!";
         diag_log "Error: Module was not placed on a valid unit.";
     };
 }, 
 "\a3\modules_f\data\portraitmodule_ca.paa"] call zen_custom_modules_fnc_register;

 ["Jamio", 
 "[Sight] Give Sight", 
 {
     private _position = _this select 0; // Module Position, not used here
     private _target = _this select 1;   // Attached object, should be the target unit



     // Check if the target is a valid unit and execute the coldhaunt function
     if (!isNull _target && {_target isKindOf "CAManBase"}) then {
         [_target] remoteExec ["JM_ZeusModules_fnc_blindRemove", _target, false]; // Execute on all clients for visual consistency
         systemChat format ["Attempting to execute blind on: %1", name _target]; // Debug log
     } else {
         hint "Module must be placed on a unit!";
         diag_log "Error: Module was not placed on a valid unit.";
     };
 }, 
 "\a3\modules_f\data\portraitmodule_ca.paa"] call zen_custom_modules_fnc_register;


 // ************************************************** WACKYS MODULES ***************************************************

 ["Wacky Modules", "[Blind] Remove Sight", {
	params ["", "_player"];
	_player setVariable ["wack_blind", true, true];
	["wack_blind", [], _player] call CBA_fnc_targetEvent;
}] call zen_custom_modules_fnc_register;

["Wacky Modules", "[Blind] Grant Sight", {
	params ["", "_player"];
	_player setVariable ["wack_blind", false, true];
    ["Your eyes feel heavy...", "PLAIN", 3, true, false] remoteExec ["titleText", _player];
    // ["Your eyes feel heavy...", 1, 5, [1,0,0,0.6], false] remoteExec ["BIS_fnc_WLSmoothText", _player];
	["wack_not_blind", [], _player] call CBA_fnc_targetEvent;
}] call zen_custom_modules_fnc_register;

["wack_blind", {
	private _priority = 150;
	while {
		wack_blind = ppEffectCreate ["DynamicBlur", _priority];
		wack_blind < 0
	} do {
		_priority = _priority + 1;
	};
	wack_blind ppEffectEnable true;
	wack_blind ppEffectAdjust [10];
	wack_blind ppEffectCommit 5;
}] call CBA_fnc_addEventHandler;

["wack_not_blind", {
	0 spawn {
		wack_blind ppEffectEnable true;
		wack_blind ppEffectAdjust [0];
		wack_blind ppEffectCommit 5;
		waitUntil {ppEffectCommitted wack_blind};
		wack_blind ppEffectEnable false;
		ppEffectDestroy wack_blind;
	};
}] call CBA_fnc_addEventHandler;

["Wacky Modules", "[ACRE] No Talking", {
	params ["", "_object"];
	_object setVariable ["acre_sys_core_isDisabled", true, true];
}] call zen_custom_modules_fnc_register;
["Wacky Modules", "[ACRE] Can Talk", {
	params ["", "_object"];
	_object setVariable ["acre_sys_core_isDisabled", false, true];
}] call zen_custom_modules_fnc_register;





// *********************************************************************************************************
// *********************************************************************************************************
// ************************* NON-HORROR MODULES ************************************************************
// *********************************************************************************************************
// *********************************************************************************************************
// *********************************************************************************************************




["[JM] Tools", 
 "Destroy On Look [WIP]", 
 {
     private _position = _this select 0; // Module Position, not used here
     private _target = _this select 1;   // Attached object, should be the target unit

     // Check if the target is a valid unit and execute the coldhaunt function
     if (!isNull _target && {_target isKindOf "CAManBase"}) then {
         [_target] remoteExec ["JM_ZeusModules_fnc_destroyEyes", _target, false]; // Execute on all clients for visual consistency
         systemChat format ["Attempting to execute eyes on: %1", name _target]; // Debug log
     } else {
         hint "Module must be placed on a unit!";
         diag_log "Error: Module was not placed on a valid unit.";
     };
 }, 
 "\a3\modules_f\data\portraitmodule_ca.paa"] call zen_custom_modules_fnc_register;


 // ************************** SILENT NIGHT ***********************************************************

  ["[JM] Tools", 
 "[Sound] Silent Night", 
 {
     private _position = _this select 0; // Module Position, not used here
     private _target = _this select 1;   // Attached object, should be the target unit

     playSound3D [getMissionPath "sounds\silentnight.ogg", "", false, _position, 5, 1, 300, 0, false];
 }, 
 "\a3\modules_f\data\portraitmodule_ca.paa"] call zen_custom_modules_fnc_register;


  // ************************** RANDOM VOICE GERMAN ***********************************************************

  ["[JM] Tools", 
 "[Sound] Random Sound", 
 {
     private _position = _this select 0; // Module Position, not used here
     private _target = _this select 1;   // Attached object, should be the target unit

     // Define the array of sound files
     private _soundFiles = [

     ];

          // Select a random sound file
     private _selectedSound = selectRandom _soundFiles;


     playSound3D [getMissionPath _selectedSound, "", false, _position, 1, 1, 300, 0, false];
 }, 
 "\a3\modules_f\data\portraitmodule_ca.paa"] call zen_custom_modules_fnc_register;

   // ************************** GATHER REINFORCEMENTS ***********************************************************

  ["[JM] Tools", 
 "Gather Reinforcements", 
 {
    [] spawn {

    if !(isServer) exitWith {};

    // Toggle the public variable
    missionNamespace setVariable ["gathReinf", true, true];

    // Wait briefly to allow all players to process the change
    sleep 5;

    // Reset the variable to prevent unintended behavior
    missionNamespace setVariable ["gathReinf", false, true];

    ["Reinforcements have been gathered and are returning to the fight."] remoteExec ["systemChat", 0, true];

                }
 }, 
 "\a3\modules_f\data\portraitmodule_ca.paa"] call zen_custom_modules_fnc_register;


   // ************************** TIMER ***********************************************************

["[JM] Tools", 
 "Countdown Timer", 
 {
    params ["_position", "_target"]; // Module Position & Target Object (Not used here)

    // Define the input dialog for countdown settings
    [
        "Set Countdown Timer",
        [
            ["SLIDER", "Countdown Time (seconds)", [1, 300, 30, 0]],  // Min 1 sec, max 300 sec, default 30
            ["EDIT", "Custom Countdown Message", ["Time Remaining"]], // Default countdown label
            ["EDIT", "Final Message", ["Countdown Complete!"]] // Default final message
        ],
        {
            // Confirmation callback
            params ["_results"];
            private _time = _results select 0;
            private _message = _results select 1;
            private _finalMessage = _results select 2;

            // Start the countdown loop with global execution
            for "_i" from 0 to _time do {
                [{
                    params ["_remainingTime", "_message"];

                    // Convert seconds to MM:SS format
                    private _formattedTime = [_remainingTime, "MM:SS"] call BIS_fnc_secondsToString;

                    // Broadcast the countdown message to all clients
                    [parseText format [
                        "<t color='#FFA500' size='1.3'>%2:</t> <t color='#FFFFFF' size='1.3'>%1</t>", 
                        _formattedTime, 
                        _message
                    ]] remoteExec ["hintSilent", 0, false];

                }, [_time - _i, _message], _i] call CBA_fnc_waitAndExecute;
            };

            // Ensure the final message is displayed globally
            [{
                params ["_finalMessage"];

                // Broadcast final message
                [parseText format [
                    "<t color='#FFA500' size='1.3'>%1</t>", 
                    _finalMessage
                ]] remoteExec ["hintSilent", 0, false];

            }, [_finalMessage], _time + 1] call CBA_fnc_waitAndExecute;
        },
        {}, // Empty cancel callback
        true // Show in Zeus interface
    ] call zen_dialog_fnc_create;
 }, 
 "a3\modules_f_curator\data\iconskiptime_ca.paa"] call zen_custom_modules_fnc_register;




 // +++++++++++++++++++++++++++++++++++++++++++
// +++++++ END MISSION
// +++++++++++++++++++++++++++++++++++++++++++

["[JM] Tools", 
 "Custom End Mission", 
 {
    ["JM_Framework\Misc\endMission.sqf"] remoteExec ["execVM", 0, true];
 }, 
 "a3\modules_f_curator\data\iconpostprocess_ca.paa"] call zen_custom_modules_fnc_register;


 // +++++++++++++++++++++++++++++++++++++++++++
// +++++++ TOGGLEABLE RALLY AND TELEPORT
// +++++++++++++++++++++++++++++++++++++++++++

["[JM] Tools", 
 "Rally Point Settings", 
 {
    params ["_position", "_target"]; // Module Position & Target Object (Not used here)

    // Get the current values of the variables
    private _currentRally = missionNamespace getVariable ["JM_Rally", false];
    private _currentTpToSL = missionNamespace getVariable ["JM_tpToSL", false];

    // Define the input dialog for toggling settings using TOOLBOX:ENABLED
    [
        "Toggle Settings",
        [
            ["TOOLBOX:ENABLED", "Enable Rally Point", _currentRally],  // BOOL default value
            ["TOOLBOX:ENABLED", "Enable TP to Squad Leader", _currentTpToSL]
        ],
        {
            // Confirmation callback
            params ["_results"];
            private _newRally = _results select 0; // Already BOOL (true/false)
            private _newTpToSL = _results select 1; // Already BOOL (true/false)

            // Update variables
            missionNamespace setVariable ["JM_Rally", _newRally, true];
            missionNamespace setVariable ["JM_tpToSL", _newTpToSL, true];

            // Notify Zeus of the changes
            hintSilent parseText format [
                "<t size='1.3' color='#FFA500'>Settings Updated</t><br/><br/>Rally Point: <t color='%1'>%2</t><br/>TP to SL: <t color='%3'>%4</t>",
                if (_newRally) then {"#00FF00"} else {"#FF0000"},
                if (_newRally) then {"ENABLED"} else {"DISABLED"},
                if (_newTpToSL) then {"#00FF00"} else {"#FF0000"},
                if (_newTpToSL) then {"ENABLED"} else {"DISABLED"}
            ];
        },
        {}, // Empty cancel callback
        true // Show in Zeus interface
    ] call zen_dialog_fnc_create;
 }, 
 "a3\ui_f_curator\data\rsccommon\rscattributerespawnvehicle\guer_ca.paa"] call zen_custom_modules_fnc_register;


// +++++++++++++++++++++++++++++++++++++++++++
// +++++++ BLACK SCREEN + MESSAGE FOR ALL PLAYERS
// +++++++++++++++++++++++++++++++++++++++++++


["[JM] Tools", 
 "Cutaway Message", 
 {
    params ["_position", "_target"]; // Module Position & Target Object (Not used here)

    // Define the input dialog for the text message, duration, and Zeus toggle
    [
        "Black Screen Effect",
        [
            ["EDIT", "Message to Display", ["Mission Update"]], // Default message
            ["SLIDER", "Duration (seconds)", [1, 60, 10, 0]], // Min 1 sec, max 60 sec, default 10
            ["TOOLBOX:ENABLED", "Affect Zeus Players?", false] // Default: No
        ],
        {
            // Confirmation callback
            params ["_results"];
            private _message = _results select 0;
            private _duration = _results select 1;
            private _affectZeus = _results select 2; // Returns true/false

            // Apply effect to all players (including/excluding Zeus based on toggle)
            {
                if (_affectZeus || { isNull getAssignedCuratorLogic _x }) then {
                    [_message, _duration] remoteExec ["JM_ZeusModules_fnc_cutawayMessage", _x];
                };
            } forEach allPlayers;
        },
        {}, // Empty cancel callback
        true // Show in Zeus interface
    ] call zen_dialog_fnc_create;
 }, 
 "\a3\modules_f\data\portraitmodule_ca.paa"] call zen_custom_modules_fnc_register;

// +++++++++++++++++++++++++++++++++++++++++++
// +++++++ RANDOM ANTI AIR FIRE
// +++++++++++++++++++++++++++++++++++++++++++


["[JM] Tools",
 "Random AA Fire",
 {
    params ["_position", "_target"];

    if (!isServer) exitWith {};

    if (isNull _target || {vehicle _target != _target}) exitWith {
        systemChat "ERROR: This module must be placed on an AA unit!";
    };

    [
        "AA Fire Settings",
        [  
            ["SLIDER", "Time Between Bursts (sec)", [2, 15, 4, 0]], 
            ["SLIDER", "Burst Length (shots)", [1, 10, 6, 0]],
            ["SLIDER", "Minimum Altitude (m)", [50, 500, 150, 0]],
            ["SLIDER", "Maximum Altitude (m)", [100, 1000, 300, 0]],
            ["SLIDER", "Total Bursts Before Stopping", [1, 50, 10, 0]] // Instead of a time limit
        ],
        {
            params ["_results", "_args"];

            _args params [["_position", [0,0,0]], ["_target", objNull, [objNull]]];

            if (isNull _target) exitWith { systemChat "ERROR: AA unit no longer exists!"; };

            private _gunner = gunner _target;
            if (isNull _gunner) exitWith { systemChat "ERROR: No gunner found!"; };

            private _weapons = weapons _target;
            private _aaWeapon = if (count _weapons > 0) then { _weapons select 0 } else { "" };
            if (_aaWeapon == "") exitWith { systemChat "ERROR: No weapon found!"; };

            private _wait = _results select 0;
            private _burst = _results select 1;
            private _altMin = _results select 2;
            private _altMax = _results select 3;
            private _maxBursts = _results select 4;

            systemChat format ["AA Fire Settings Updated: %1 total bursts, Bursts every %2s, %3 shots per burst, Min Alt: %4m, Max Alt: %5m", _maxBursts, _wait, _burst, _altMin, _altMax];

            // Start firing logic
            [_target, _gunner, _aaWeapon, _wait, _burst, _altMin, _altMax, _maxBursts] spawn {
                params ["_aa", "_gunner", "_aaWeapon", "_wait", "_burst", "_altMin", "_altMax", "_maxBursts"];

                for "_i" from 1 to _maxBursts do {
                    if (!alive _aa || !alive _gunner) exitWith {};

                    private _tgtPos = [getPos _aa, 200 + random 300, random 360] call BIS_fnc_relPos;
                    _tgtPos set [2, _altMin + random (_altMax - _altMin)];

                    _gunner doWatch _tgtPos;
                    _gunner commandSuppressiveFire _tgtPos;
                    _aa setVehicleAmmo 1;

                    for "_j" from 1 to _burst do {
                        _gunner forceWeaponFire [_aaWeapon, "Burst"];
                        sleep 0.3;
                    };

                    if (_i < _maxBursts) then {
                        sleep (random [_wait * 0.5, _wait, _wait * 1.5]);
                    };
                };

                systemChat "AA Fire Mode Ended: Maximum Bursts Reached";
            };
        },
        {},
        _this
    ] call zen_dialog_fnc_create;
 },
 "\a3\modules_f\data\portraitmodule_ca.paa"] call zen_custom_modules_fnc_register;

 // +++++++++++++++++++++++++++++++++++++++++++
// +++++++ EXPLOSION SPAWNER
// +++++++++++++++++++++++++++++++++++++++++++

["[JM] Tools",
 "Explosion Spawner",
 {
    params ["_position", "_target"];

    if (!isServer) exitWith {};

    // Retrieve all ammo class names from CfgAmmo
    private _ammoList = "true" configClasses (configFile >> "CfgAmmo");
    private _ammoNames = [];
    private _ammoDisplayNames = [];

    {
        private _ammoClass = configName _x;
        private _displayName = getText (_x >> "displayName");

        if (_displayName isEqualTo "") then { _displayName = _ammoClass };

        _ammoNames pushBack _ammoClass;
        _ammoDisplayNames pushBack _displayName;
    } forEach _ammoList;

    // Default selection
    private _defaultIndex = _ammoNames find "Bo_GBU12_LGB"; // Default to a common explosion type

    [
        "Explosion Spawner",
        [  
            ["COMBO", "Select Explosion Type", [_ammoNames, _ammoDisplayNames, _defaultIndex]],
            ["SLIDER", "Delay Before Explosion (sec)", [0, 10, 0, 1]],
            ["SLIDER", "Explosion Height Offset (m)", [-5, 50, 0, 1]], 
            ["SLIDER", "Cleanup Timeout (sec)", [10, 30, 20, 1]], // Cleanup delay option
            ["CHECKBOX", "Force Detonation If Stuck?", true] // Forces explosion instead of deletion
        ],
        {
            params ["_results", "_args"];
            _args params [["_position", [0,0,0]]];

            private _selectedAmmo = _results select 0;
            private _delay = _results select 1;
            private _heightOffset = _results select 2;
            private _cleanupTimeout = _results select 3;
            private _forceDetonation = _results select 4;

            systemChat format ["Explosion Settings: Type: %1 | Delay: %2s | Height Offset: %3m | Cleanup: %4s | Force Detonation: %5", 
                _selectedAmmo, _delay, _heightOffset, _cleanupTimeout, _forceDetonation];

            [_position, _selectedAmmo, _delay, _heightOffset, _cleanupTimeout, _forceDetonation] spawn {
                params ["_pos", "_ammo", "_delay", "_heightOffset", "_cleanupTimeout", "_forceDetonation"];

                sleep _delay;

                private _explosionPos = _pos;
                _explosionPos set [2, (_explosionPos select 2) + _heightOffset];

                systemChat format ["Spawning explosion: %1 at %2", _ammo, _explosionPos];

                private _explosion = _ammo createVehicle _explosionPos;

                // Cleanup or force detonation after timeout
                [_explosion, _cleanupTimeout, _forceDetonation] spawn {
                    params ["_expObj", "_timeout", "_forceDetonate"];
                    sleep _timeout;
                    if (!isNull _expObj) then {
                        if (_forceDetonate) then {
                            _expObj setDamage 1; // Force explosion
                            systemChat "Forced detonation executed.";
                        } else {
                            deleteVehicle _expObj; // Cleanup stuck object
                            systemChat "Stuck explosion object deleted.";
                        };
                    };
                };
            };
        },
        {},
        _this
    ] call zen_dialog_fnc_create;
 },
 "\a3\modules_f\data\portraitmodule_ca.paa"] call zen_custom_modules_fnc_register;


// +++++++++++++++++++++++++++++++++++++++++++
// +++++++ CUSTOM SOUND PLAYER
// +++++++++++++++++++++++++++++++++++++++++++

if !(isClass (configFile >> "CfgPatches" >> "crowsEW_main")) then {
    systemChat "[Custom Sound Module] CROWS EW not detected - Registering standalone module.";

    ["Jamio",
     "[Sound] Play Custom Sound",
     {
        params ["_position", "_target"];
        
        if (!isServer) exitWith {};

        // Retrieve all available sounds from mission-defined CfgSounds
        private _sounds = [];
        private _cfg = missionConfigFile >> "CfgSounds";  

        for "_i" from 0 to (count _cfg - 1) do {
            private _soundClass = _cfg select _i;
            private _soundName = configName _soundClass;

            if (isClass _soundClass) then {  
                private _soundArray = getArray (_soundClass >> "sound");

                if (count _soundArray > 0) then {
                    private _soundPath = _soundArray select 0;
                    if !(_soundPath isEqualTo "" || {[_soundPath, "\"] call BIS_fnc_inString}) then {
                        _sounds pushBack _soundName;
                    };
                };
            };
        };

        if (_sounds isEqualTo []) exitWith {
            systemChat "ERROR: No valid mission sounds found in CfgSounds!";
        };

        [
            "Select a Sound to Play",
            [
                ["COMBO", "Choose Sound", [_sounds, _sounds, 0]],  
                ["SLIDER", "Volume", [0.1, 3, 1, 1]],  
                ["SLIDER", "Distance", [10, 500, 100, 1]]  
            ],
            {
                params ["_results", "_args"];

                private _selectedSound = _results select 0;
                private _volume = _results select 1;
                private _distance = _results select 2;
                private _position = _args select 0;

                if (_selectedSound == "") exitWith {
                    systemChat "ERROR: No sound selected!";
                };

                // Retrieve actual sound class from mission CfgSounds
                private _soundConfig = missionConfigFile >> "CfgSounds" >> _selectedSound;
                if !(isClass _soundConfig) exitWith {
                    systemChat format ["ERROR: Sound '%1' is not a valid class in CfgSounds!", _selectedSound];
                };

                private _soundArray = getArray (_soundConfig >> "sound");
                if (count _soundArray == 0) exitWith {
                    systemChat format ["ERROR: Sound '%1' has no valid file path!", _selectedSound];
                };

                private _soundPath = _soundArray select 0;
                if (_soundPath isEqualTo "" || {[_soundPath, "\"] call BIS_fnc_inString}) exitWith {
                    systemChat format ["ERROR: Sound '%1' is invalid or from an addon!", _selectedSound];
                };

                _volume = parseNumber str _volume;
                _distance = parseNumber str _distance;

                systemChat format ["Playing sound: %1 | Volume: %2 | Distance: %3", _selectedSound, _volume, _distance];

                // Use getMissionPath to ensure the correct file path
                playSound3D [getMissionPath _soundPath, objNull, false, _position, _volume, 1, _distance, 0, false];

            },
            {},
            [_position] 
        ] call zen_dialog_fnc_create;
     },
     "\a3\modules_f\data\portraitmodule_ca.paa"] call zen_custom_modules_fnc_register;
} else {
    systemChat "[CROWS EW] Detected – Adding mission sounds to CROWS EW...";

    // Get or create the sound attributes hashmap
    private _soundAttributes = missionNamespace getVariable ["crowsEW_sounds_soundAttributes", createHashMap];
    private _cfg = missionConfigFile >> "CfgSounds";
    private _newSounds = [];

    for "_i" from 0 to (count _cfg - 1) do {
        private _soundClass = _cfg select _i;
        private _soundName = configName _soundClass;

        if (isClass _soundClass) then {
            private _soundArray = getArray (_soundClass >> "sound");

            if (count _soundArray > 0) then {
                private _soundPath = _soundArray select 0;

                // Only include mission-based sounds (no backslashes)
                if !(_soundPath isEqualTo "" || {[_soundPath, "\"] call BIS_fnc_inString}) then {
                    private _formattedPath = getMissionPath _soundPath;
                    private _displayName = format ["JM: %1", _soundName];

                    _soundAttributes set [_soundName, [0, _formattedPath, _displayName]];
                    _newSounds pushBack [_soundName, _displayName];
                };
            };
        };
    };

    // Update variables if new sounds were added
    if (!(_newSounds isEqualTo [])) then {
        systemChat format ["[CROWS EW] Added %1 mission sounds – rebuilding Zeus display arrays...", count _newSounds];

        // Update the master sound attribute hashmap
        missionNamespace setVariable ["crowsEW_sounds_soundAttributes", _soundAttributes];

        // Rebuild the sorted display arrays for Zeus
        private _sortArr = [];
        {
            _sortArr pushBack [_x, (_y select 2)];
        } forEach _soundAttributes;

        _sortArr = [_sortArr, [], {_x select 1}, "ASCEND"] call BIS_fnc_sortBy;

        private _keys = [];
        private _display = [];
        {
            _keys pushBack (_x select 0);
            _display pushBack (_x select 1);
        } forEach _sortArr;

        // Update CROWS EW’s Zeus display lists
        missionNamespace setVariable ["crowsEW_sounds_soundZeusDisplayKeys", _keys];
        missionNamespace setVariable ["crowsEW_sounds_soundZeusDisplay", _display];

        systemChat "[CROWS EW] Mission sounds successfully added to Zeus sound list.";
    } else {
        systemChat "[CROWS EW] No valid mission sounds found in CfgSounds.";
    };
};





// +++++++++++++++++++++++++++++++++++++++++++
// +++++++ CINEMATIC BORDERS CUTAWAY
// +++++++++++++++++++++++++++++++++++++++++++


["[JM] Tools",
 "Cutaway Cinematic",
 {
    params ["_pos", "_target"];

    if (!hasInterface || !isServer) exitWith {};

        [
            "Cinematic Border Settings",
            [
                ["SLIDER", "Display Duration (sec)", [1, 20, 10, 0]],
                ["EDIT", "Text to Display", ["Sample Text"]]
            ],
            {
                params ["_results", "_args"];
                private _duration = _results select 0;
                private _text = _results select 1;
                [_duration, _text] remoteExec ["JM_ZeusModules_fnc_cinemaBorder", 0, false];
            },
            {},
            []
        ] call zen_dialog_fnc_create;
 },
 "\a3\modules_f\data\portraitmodule_ca.paa"] call zen_custom_modules_fnc_register;


// +++++++++++++++++++++++++++++++++++++++++++
// +++++++ AWACS CALL
// +++++++++++++++++++++++++++++++++++++++++++



 ["[JM] Tools",
 "[AWACS] Broadcast Threat Report",
{
    params ["_position", "_target"];

    if (!isServer) exitWith {};

    // Reference point (e.g. airbase) — could be replaced with a module argument later
    private _reference = if (getMarkerPos "Bullseye_1" select 0 != 0 || getMarkerPos "Bullseye_1" select 1 != 0) then {
            getMarkerPos "Bullseye_1"
        } else {
            getMarkerPos "respawn_west"
        };

    [
        "AWACS Report Config",
        [
            ["COMBO", "Threat Type", [["BANDIT", "GROUP OF BANDITS", "SAM SITE", "UNIDENTIFIED CONTACT"], ["BANDIT", "GROUP", "SAM", "UNKNOWN"], 0]],
            ["EDIT", "Additional Info (optional)", [""]],
            ["SLIDER", "Altitude (in ft)", [0, 40000, 15000, 0]]
        ],
        {
            params ["_results", "_args"];
            _args params ["_pos", "_ref"];

            private _threatType = _results select 0;
            private _extraInfo = _results select 1;
            private _altFt = _results select 2;

            // Calculate bearing and distance
            private _dir = [_ref, _pos] call BIS_fnc_dirTo;
            private _bearing = floor (_dir + 0.5); // round bearing
            private _dist = round ((_ref distance2D _pos) / 1000); // in km

            // Format the message
            private _message = format [
                "<t color='#00c3ff'><t size='1.2'><t align='left'>AWACS:</t><br/><t color='#ffffff'>%1 CONTACT %2 KM, BEARING %3, ANGELS %4%5</t>",
                _threatType,
                _dist,
                _bearing,
                round (_altFt / 1000),
                if (_extraInfo != "") then { format [", %1", _extraInfo] } else { "" }
            ];

            // Show the hint
            hint parseText _message;
        },
        {},
        [_position, _reference]
    ] call zen_dialog_fnc_create;
},
"\a3\modules_f\data\portraitmodule_ca.paa"] call zen_custom_modules_fnc_register;


























































 



