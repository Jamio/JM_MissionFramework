[] spawn {
  waitUntil {!isNull player};
  waitUntil {  time > 3 };
};

// ["Custom Modules", "Cool Hint", {hint str _this}] call zen_custom_modules_fnc_register

// ----------------------------------------------------------------------------------------------------------------------------------
// FLING
// This module allows you to fling units around, fun for fucking with players
// ----------------------------------------------------------------------------------------------------------------------------------

["[JM] Fun", 
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

// ----------------------------------------------------------------------------------------------------------------------------------
// BLIND UNIT + UNBLIND UNIT
// Two modules that work together to blind and unblind units, fun for creating interesting situations for players
// ----------------------------------------------------------------------------------------------------------------------------------

["[JM] Fun", 
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

 ["[JM] Fun", 
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


// ----------------------------------------------------------------------------------------------------------------------------------
// DESTROY ON LOOK
// This module gives the player the ability to destroy units just by looking at them. THIS CANNOT BE REMOVED SO PLEASE USE WITH CAUTION.
// -----------------------------------------------------------------------------------------------------------------------------------


 ["[JM] Fun", 
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


// ==================================================================================================================================
// TOOLS MODULES
// These modules are designed to be tools for use by the zeus to make interesting scenarios with ease
// ==================================================================================================================================

// ----------------------------------------------------------------------------------------------------------------------------------
// COUNTDOWN TIMER
// This module gives an on-screen timer to players. Useful for breaks and/or objective countdowns. Customisable via dialog.
// -----------------------------------------------------------------------------------------------------------------------------------

["[JM] Tools", 
 "Countdown Timer", 
 {
    params ["_position", "_target"]; // module pos and target obj

    // Define the input dialog for countdown settings
    [
        "Set Countdown Timer",
        [
            ["SLIDER", "Countdown Time (seconds)", [1, 900, 30, 0]],
            ["EDIT", "Custom Countdown Message", ["Time Remaining"]],
            ["EDIT", "Final Message", ["Countdown Complete!"]]
        ],
        {
            // Confirmation callback
            params ["_results"];
            private _time = _results select 0;
            private _message = _results select 1;
            private _finalMessage = _results select 2;

            // countdown loop global exec
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

            // display final time globally
            [{
                params ["_finalMessage"];

                // Broadcast final message
                [parseText format [
                    "<t color='#FFA500' size='1.3'>%1</t>", 
                    _finalMessage
                ]] remoteExec ["hintSilent", 0, false];

            }, [_finalMessage], _time + 1] call CBA_fnc_waitAndExecute;
        },
        {},
        true
    ] call zen_dialog_fnc_create;
 }, 
 "a3\modules_f_curator\data\iconskiptime_ca.paa"] call zen_custom_modules_fnc_register;




// ----------------------------------------------------------------------------------------------------------------------------------
// CUSTOM END MISSION
// This module initiates the custom end mission script built into the framework
// -----------------------------------------------------------------------------------------------------------------------------------

["[JM] Ending", 
 "Custom End Mission", 
 {
    ["JM_Framework\Misc\endMissionSequence.sqf"] remoteExec ["execVM", 0, true];
 }, 
 "a3\modules_f_curator\data\iconpostprocess_ca.paa"] call zen_custom_modules_fnc_register;


// ----------------------------------------------------------------------------------------------------------------------------------
// RALLY POINT SETTINGS
// This module allows editing of the frameworks rally point settings to make rally-teleporting or squad-teleporting possible or not.
// -----------------------------------------------------------------------------------------------------------------------------------

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


// ----------------------------------------------------------------------------------------------------------------------------------
// CUTAWAY MESSAGE
// This module fades the screen to black and displays a message to players. Useful to adjusting things in the background or teleporting players without disorientation. Customisable via dialog.
// -----------------------------------------------------------------------------------------------------------------------------------


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
 "a3\modules_f_bootcamp\data\portraithint.paa"] call zen_custom_modules_fnc_register;

// ----------------------------------------------------------------------------------------------------------------------------------
// RANDOM AA FIRE
// This module will make turret AA units fire randomly into the sky, fun for creating ambiance or making things more interesting for players in the area.
// -----------------------------------------------------------------------------------------------------------------------------------


["[JM] Tools",
 "Random AA Fire",
 {
    params ["_position", "_target"];

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
 "x\zen\addons\modules\ui\target_ca.paa"] call zen_custom_modules_fnc_register;

// ----------------------------------------------------------------------------------------------------------------------------------
// EXPLOSION SPAWNER
// This module will spawn a cfgAmmo projectile, allowing you to drop custom bombs for cool explosions.
// -----------------------------------------------------------------------------------------------------------------------------------

["[JM] Tools",
 "Explosion Spawner",
 {
    params ["_position", "_target"];

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
 "x\zen\addons\modules\ui\explosion_ca.paa"] call zen_custom_modules_fnc_register;


// ----------------------------------------------------------------------------------------------------------------------------------
// CUSTOM SOUND PLAYER
// This module allows zeus to play sounds, including ones defined in the mission description.ext, with custom volume and distance settings. Can be used for ambiance or fun.
// -----------------------------------------------------------------------------------------------------------------------------------

if !(isClass (configFile >> "CfgPatches" >> "crowsEW_main")) then {
    systemChat "[Custom Sound Module] CROWS EW not detected - Registering standalone module.";

    ["[JM] Tools",
     "Custom Sound",
     {
        params ["_position", "_target"];
        

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
     "a3\ui_f\data\igui\rscingameui\rscunitinfoairrtdfull\ico_cpt_sound_on_ca.paa"] call zen_custom_modules_fnc_register;
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





// ----------------------------------------------------------------------------------------------------------------------------------
// CUTAWAY CINEMATIC BORDER
// This module displays a "chapter" style text with cinematic borders.
// -----------------------------------------------------------------------------------------------------------------------------------


["[JM] Tools",
 "Cutaway Cinematic",
 {
    params ["_pos", "_target"];

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
 "a3\modules_f_bootcamp\data\portraithint.paa"] call zen_custom_modules_fnc_register;


// ----------------------------------------------------------------------------------------------------------------------------------
// AWACS REPORT
// This module gives players a customisable AWACS report based on the position of the module and a reference point (defaulting to Bullseye or respawn marker). Useful for creating dynamic intel reports for air players.
// -----------------------------------------------------------------------------------------------------------------------------------



["[JM] Tools",
"AWACS Report",
{
    params ["_position", "_target"];

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

            private _dir = [_ref, _pos] call BIS_fnc_dirTo;
            private _bearing = floor (_dir + 0.5);
            private _dist = round ((_ref distance2D _pos) / 1000);
            private _angels = round (_altFt / 1000);

            private _infoLine = if (_extraInfo != "") then {
                format ["<br/><t size='1.25' color='#00c3ff'>INFO:</t> <t size='1.25' color='#ffffff'>%1</t>", _extraInfo]
            } else { "" };

            private _message = format [
                "<img size='3' image='a3\ui_f\data\igui\rsccustominfo\sensors\targets\enemyairremote_ca.paa'/><br/><br/>" +
                "<t size='2' color='#00c3ff'>AWACS REPORT</t><br/><br/>" +
                "<t size='1.5' color='#ffffff'>=======</t><br/><br/>" +
                "<t size='1.25' color='#00c3ff'>CONTACT:</t> <t size='1.25' color='#ffffff'>%1</t><br/>" +
                "<t size='1.25' color='#00c3ff'>DISTANCE:</t> <t size='1.25' color='#ffffff'>%2 KM</t><br/>" +
                "<t size='1.25' color='#00c3ff'>BEARING:</t> <t size='1.25' color='#ffffff'>%3°</t><br/>" +
                "<t size='1.25' color='#00c3ff'>ALTITUDE:</t> <t size='1.25' color='#ffffff'>%4</t>%5",
                _threatType,
                _dist,
                _bearing,
                _angels,
                _infoLine
            ];

            [parseText _message] remoteExec ["hint", 0];

            // hint parseText _message;
        },
        {},
        [_position, _reference]
    ] call zen_dialog_fnc_create;
},
"a3\data_f_jets\logos\jets_icon_ca.paa"] call zen_custom_modules_fnc_register;

// ----------------------------------------------------------------------------------------------------------------------------------
// SPAWN AMMO CRATE
// This module turns a container into an ammo crate based on player loadouts.
// -----------------------------------------------------------------------------------------------------------------------------------

[
    "[JM] Supply",
    "Ammo Crate",
    {
        params ["_pos", "_crate"];

        if (isNull _crate) exitWith {
            [objNull, "Object not valid"] call BIS_fnc_showCuratorFeedbackMessage;
        };

        // Zeus dialog to select how many of each mag to add
        [
            "Ammo Crate Contents",
            [
                ["SLIDER", "Primary Mags", [0, 50, 20, 0]],
                ["SLIDER", "Sidearm Mags", [0, 50, 10, 0]],
                ["SLIDER", "Launcher Mags", [0, 20, 5, 0]],
                ["SLIDER", "Grenades", [0, 50, 15, 0]]
            ],
            {
                params ["_results", "_args"];
                _args params ["_crate"];
                _results params ["_p", "_s", "_l", "_g"];

                // Pass values to the ammoCrate.sqf script
                [[_crate, _p, _s, _l, _g], "JM_Framework\Supply\ammoCrate.sqf"] remoteExec ["execVM", 0, false];
            },
            {},
            [_crate]
        ] call zen_dialog_fnc_create;
    },
    "a3\weapons_f\ammoboxes\data\ui\icomap_ammo_ca.paa"
] call zen_custom_modules_fnc_register;

// ----------------------------------------------------------------------------------------------------------------------------------
// SPAWN MEDICAL CRATE
// This module gturns a container into a medical crate, complete with items.
// -----------------------------------------------------------------------------------------------------------------------------------

[
    "[JM] Supply",
    "Medical Crate",
    {
        params ["_pos", "_crate"];

        if (isNull _crate) exitWith {
            [objNull, "Object not valid"] call BIS_fnc_showCuratorFeedbackMessage;
        };

        [
            "Medical Crate Contents",
            [
                ["SLIDER", "Field Dressings", [0, 100, 40, 0]],
                ["SLIDER", "Blood IV (1000ml)", [0, 20, 5, 0]],
                ["SLIDER", "Blood IV (500ml)", [0, 20, 10, 0]],
                ["SLIDER", "Blood IV (250ml)", [0, 20, 10, 0]],
                ["SLIDER", "Splints", [0, 20, 6, 0]],
                ["SLIDER", "Tourniquets", [0, 20, 6, 0]],
                ["SLIDER", "Painkillers", [0, 20, 8, 0]],
                ["SLIDER", "Epinephrine", [0, 20, 6, 0]],
                ["SLIDER", "Morphine", [0, 20, 6, 0]]
            ],
            {
                params ["_results", "_args"];
                _args params ["_crate"];

                _results params [
                    "_dressings", "_iv1000", "_iv500", "_iv250",
                    "_splints", "_tq", "_painkillers", "_epi", "_morph"
                ];

                [[
                    _crate,
                    _dressings,
                    _iv1000,
                    _iv500,
                    _iv250,
                    _splints,
                    _tq,
                    _painkillers,
                    _epi,
                    _morph
                ],  "JM_Framework\Supply\medCrate.sqf"] remoteExec ["execVM", 0, true];
            },
            {},
            [_crate]
        ] call zen_dialog_fnc_create;
    },
    "a3\characters_f\data\ui\icon_medic_ca.paa"
] call zen_custom_modules_fnc_register;



// ----------------------------------------------------------------------------------------------------------------------------------
// EDIT END TITLES
// This module allows editing of the custom end screen titles used in the custom end mission setup.
// -----------------------------------------------------------------------------------------------------------------------------------

[
    "[JM] Ending",
    "Set End Screen Titles",
    {
        params ["_pos", "_logic"];

        // Use current values or fall back to defaults
        private _defaults = [
            "The fighting in this mission was intense.",
            "The Misfits held the line, but at great cost.",
            "Buccaneer tried to use a squadmate's head to defuse a mine.",
            "Maybe next time, they’ll do better. Maybe."
        ];

        private _current = if (!isNil "JM_EndTitles") then { JM_EndTitles } else { _defaults };

        [
            "Edit End Screen Titles",
            [
                ["EDIT:MULTI", "Line 1", [_current param [0, _defaults#0], { _this }, 4]],
                ["EDIT:MULTI", "Line 2", [_current param [1, _defaults#1], { _this }, 4]],
                ["EDIT:MULTI", "Line 3", [_current param [2, _defaults#2], { _this }, 4]],
                ["EDIT:MULTI", "Line 4", [_current param [3, _defaults#3], { _this }, 4]]
            ],
            {
                params ["_results", "_args"];
                _results params ["_line1", "_line2", "_line3", "_line4"];

                JM_EndTitles = [_line1, _line2, _line3, _line4];
                publicVariable "JM_EndTitles";

                hint "End Titles Updated";
            },
            {},
            []
        ] call zen_dialog_fnc_create;
    },
    "a3\ui_f\data\igui\cfg\simpletasks\types\documents_ca.paa"
] call zen_custom_modules_fnc_register;

// ----------------------------------------------------------------------------------------------------------------------------------
// EDIT DEBRIEF DIALOG
// This module gives the player the ability to destroy units just by looking at them. THIS CANNOT BE REMOVED SO PLEASE USE WITH CAUTION.
// -----------------------------------------------------------------------------------------------------------------------------------

[
    "[JM] Ending",
    "Set Debrief Text",
    {
        params ["_pos", "_logic"];

        // Default text if not defined
        private _default = "The Misfits enjoyed playing around at the training ground with their friends.<br/><br/>" +
                           "Everyone had a good time, and went to bed with a newfound warmth in their hearts.<br/><br/>" +
                           "Well done, everyone.";

        private _current = if (!isNil "JM_CustomDebriefText") then { JM_CustomDebriefText } else { _default };

        [
            "Edit Custom Debrief Text",
            [
                ["EDIT:MULTI", "Debrief Text", [_current, { _this }, 10]]
            ],
            {
                params ["_results", "_args"];
                _results params ["_text"];

                JM_CustomDebriefText = _text;
                publicVariable "JM_CustomDebriefText";

                hint parseText "<t size='1.2' color='#33cc33'>Custom debrief text updated!</t>";
            },
            {},
            []
        ] call zen_dialog_fnc_create;
    },
    "a3\ui_f\data\igui\cfg\simpletasks\types\documents_ca.paa"
] call zen_custom_modules_fnc_register;


// ----------------------------------------------------------------------------------------------------------------------------------
// ASSIGN LEADER ROLES
// Allows zeus to assign or remove squad leader and platoon leader roles at will.
// -----------------------------------------------------------------------------------------------------------------------------------

    ["[JM] Tools", "Assign Leader Roles", {
      params ["_pos", "_unit"];

      if (isNull _unit) exitWith {[objNull, "Error: Please pick a valid unit"] call BIS_fnc_showCuratorFeedbackMessage};


      // Initial checkbox states from the units current vars
      private _initSL = _unit getVariable ["JM_isSquadLead",   false];
      private _initPL = _unit getVariable ["JM_isPlatoonLead", false];

      [
        format ["Assign / Unassign Roles: %1", name _unit],

        [

        ["TOOLBOX:ENABLED", "Squad Leader", _initSL],  // BOOL default value
        ["TOOLBOX:ENABLED", "Platoon Leader", _initPL],
        ["CHECKBOX", "Remove Rally & Marker", true]

        ],
        // onConfirm
        {
          params ["_results", "_args"];
          _args params ["_unit"];
          _results params ["_newSL", "_newPL", "_doCleanup"];

          private _oldSL = _unit getVariable ["JM_isSquadLead",   false];
          private _oldPL = _unit getVariable ["JM_isPlatoonLead", false];

          // Set slot variables (public)
          _unit setVariable ["JM_isSquadLead",   _newSL, true];
          _unit setVariable ["JM_isPlatoonLead", _newPL, true];

          // Optional cleanup when turning roles OFF
          if (_doCleanup) then {
            if (_oldSL && !_newSL) then {
              private _r = _unit getVariable ["JM_RallyObject", objNull];
              if (!isNull _r) then { deleteVehicle _r; };
              private _m = _unit getVariable ["JM_RallyMarker",""];
              if (_m != "") then { deleteMarker _m; };
              _unit setVariable ["JM_RallyObject", nil, true];
              _unit setVariable ["JM_RallyMarker", nil, true];
              // remove SL action from the client UI (idempotent)
              [_unit,1,["ACE_SelfActions","DeploySquadRally"]]
                remoteExecCall ["ace_interact_menu_fnc_removeActionFromObject", owner _unit];
            };
            if (_oldPL && !_newPL) then {
              private _plt = missionNamespace getVariable ["JM_PltRallyObject", objNull];
              if (!isNull _plt) then { deleteVehicle _plt; };
              private _pm = missionNamespace getVariable ["JM_PltRallyMarker",""];
              if (_pm != "") then { deleteMarker _pm; };
              missionNamespace setVariable ["JM_PltRallyObject", nil, true];
              missionNamespace setVariable ["JM_PltRallyMarker", nil, true];
              // remove PL action from the client UI
              [_unit,1,["ACE_SelfActions","DeployPlatoonRally"]]
                remoteExecCall ["ace_interact_menu_fnc_removeActionFromObject", owner _unit];
            };
          };

          // Reapply ACE actions on that client
          if (isPlayer _unit) then {
            [] remoteExecCall ["JM_RallyPoint_fnc_addLocalRallyActions", owner _unit];
          };

            // Broadcast changes to everyone
            private _msgs = [];

            if (!_oldSL && _newSL) then {
                _msgs pushBack format ["%1 has been promoted to Squad Leader.", name _unit];
            };
            if (_oldSL && !_newSL) then {
                _msgs pushBack format ["%1 has been demoted from Squad Leader.", name _unit];
            };
            if (!_oldPL && _newPL) then {
                _msgs pushBack format ["%1 has been promoted to Platoon Leader.", name _unit];
            };
            if (_oldPL && !_newPL) then {
                _msgs pushBack format ["%1 has been demoted from Platoon Leader.", name _unit];
            };

            {
                [_x] remoteExecCall ["systemChat", 0];
            } forEach _msgs;

            // If nothing changed, give the Zeus a local heads-up
            if (_msgs isEqualTo []) then {
                systemChat format ["[JM] No role changes for %1.", name _unit];
            };
            
        },
        // onCancel
        {},
        // args passed to onConfirm
        [_unit]
      ] call zen_dialog_fnc_create;

    }] call zen_custom_modules_fnc_register;


// ----------------------------------------------------------------------------------------------------------------------------------
// ADD MEDEVAC TICKETS
// This module allows zeus to manually add tickets to the team pool.
// -----------------------------------------------------------------------------------------------------------------------------------


    [
    "[JM] Tools",                                  // Category
    "Add Medevac Tickets",                         // Module name
    {
        params ["_posASL", "_attachedObject"];

        private _currentPool = missionNamespace getVariable ["JM_tickets_pool", 0];

        [
            format ["Add Medevac Tickets (Current Pool: %1)", _currentPool],
            [
                [
                    "SLIDER",
                    [
                        "Tickets to Add",
                        format ["Current pool: %1\nChoose how many tickets to add.", _currentPool]
                    ],
                    [
                        0,      // min
                        100,    // max
                        10,     // default
                        0       // 0 decimal places
                    ]
                ]
            ],
            {
                params ["_dialogValues", "_args"];
                _dialogValues params ["_delta"];

                _delta = round _delta;
                if (_delta <= 0) exitWith {};

                [_delta] remoteExecCall ["JM_TicketsMedevac_fnc_addTickets", 2];
            },
            {},
            []
        ] call zen_dialog_fnc_create;
    },
    "\a3\ui_f\data\igui\cfg\simpletasks\types\heal_ca.paa"
] call zen_custom_modules_fnc_register;

// ----------------------------------------------------------------------------------------------------------------------------------
// ASSIGN JTAC ROLE
// This module allows the zeus to assign or remove the JTAC role at will.
// -----------------------------------------------------------------------------------------------------------------------------------

[
    "[JM] Tools",
    "Assign JTAC Role",
    {
        params ["_pos", "_object"];

        if (isNull _object) exitWith {
            hint "No unit selected.";
        };

        if !(_object isKindOf "CAManBase") exitWith {
            hint "Target must be a humanoid you idiot.";
        };

        private _current = _object getVariable ["JM_isJTAC", false];

        [
            "Set JTAC Status",
            [
                [
                    "CHECKBOX",
                    ["JTAC Enabled", "Grant or remove JTAC capability from this unit."],
                    _current,
                    true
                ]
            ],
            {
                params ["_dialogResult", "_args"];
                _dialogResult params ["_enabled"];
                _args params ["_unit"];

                _unit setVariable ["JM_isJTAC", _enabled, true];

                if (isPlayer _unit) then {
                    [] remoteExec ["JM_JTAC_fnc_refreshLocalActions", _unit];
                };
            },
            {},
            [_object]
        ] call zen_dialog_fnc_create;
    }
] call zen_custom_modules_fnc_register;


// ----------------------------------------------------------------------------------------------------------------------------------
// FLYOVER V2
// This module spawns a flyover, with customised parameters, but should work for all vehicles. Its quite cool if I say so myself.
// -----------------------------------------------------------------------------------------------------------------------------------

[
    "[JM] Tools",
    "Spawn Aircraft Flyover (Universal)",
    {
        params ["_pos", "_object"];

        private _vehicleValues = [];
        private _vehiclePrettyNames = [];

        {
            private _cfg = _x;
            private _className = configName _cfg;

            if (getNumber (_cfg >> "scope") < 2) then { continue };
            if !(_className isKindOf ["Air", configFile >> "CfgVehicles"]) then { continue };

            private _displayName = getText (_cfg >> "displayName");
            if (_displayName isEqualTo "") then { continue };

            private _faction = getText (_cfg >> "faction");
            private _editorSubcategory = getText (_cfg >> "editorSubcategory");

            private _picture = getText (_cfg >> "editorPreview");
            if (_picture isEqualTo "") then {
                _picture = getText (_cfg >> "picture");
            };

            private _tooltip = format [
                "%1\nClass: %2\nFaction: %3\nSubcategory: %4",
                _displayName,
                _className,
                _faction,
                _editorSubcategory
            ];

            _vehicleValues pushBack _className;
            _vehiclePrettyNames pushBack [_displayName, _tooltip, _picture];
        } forEach ("true" configClasses (configFile >> "CfgVehicles"));

        if (_vehicleValues isEqualTo []) exitWith {
            ["Flyover Module", "No air vehicles found in CfgVehicles."] call zen_common_fnc_showMessage;
        };

        private _combined = [];
        {
            _combined pushBack [
                _vehiclePrettyNames # _forEachIndex,
                _vehicleValues # _forEachIndex
            ];
        } forEach _vehicleValues;

        _combined sort true;

        _vehiclePrettyNames = [];
        _vehicleValues = [];

        {
            _x params ["_pretty", "_value"];
            _vehiclePrettyNames pushBack _pretty;
            _vehicleValues pushBack _value;
        } forEach _combined;

        [
            "Aircraft Flyover (Universal)",
            [
                [
                    "LIST",
                    ["Aircraft", "Select an aircraft class from all Air vehicles"],
                    [_vehicleValues, _vehiclePrettyNames, 0, 16]
                ],
                [
                    "SLIDER",
                    ["Plane count", "Number of aircraft to spawn"],
                    [1, 25, 7, 0]
                ],
                [
                    "SLIDER",
                    ["Heading", "Direction (N=0, E=90, S=180, W=270)"],
                    [0, 359, 90, 0]
                ],
                [
                    "SLIDER",
                    ["Speed (m/s)", "Forward speed"],
                    [20, 600, 56, 0]
                ],
                [
                    "SLIDER",
                    ["Altitude", "Formation altitude"],
                    [25, 3000, 350, 0]
                ],
                [
                    "SLIDER",
                    ["Spacing", "Base spacing / formation radius"],
                    [20, 200, 60, 0]
                ],
                [
                    "SLIDER",
                    ["Spawn distance", "Distance before the flyover point"],
                    [500, 15000, 4000, 0]
                ],
                [
                    "SLIDER",
                    ["Despawn distance", "Distance after the flyover point"],
                    [500, 15000, 4000, 0]
                ],
                [
                    "COMBO",
                    ["Formation", "Preset formation type"],
                    [
                        ["wedge", "line", "column", "scatter"],
                        [
                            ["Wedge", "Classic V formation"],
                            ["Line", "Line abreast"],
                            ["Column", "Single file"],
                            ["Scatter", "Loose circular cluster"]
                        ],
                        0
                    ]
                ],
                [
                    "SLIDER",
                    ["Random X offset", "Left / right natural variation"],
                    [0, 100, 0, 0]
                ],
                [
                    "SLIDER",
                    ["Random Y offset", "Front / back natural variation"],
                    [0, 100, 0, 0]
                ],
                [
                    "SLIDER",
                    ["Random Z offset", "Vertical height natural variation"],
                    [0, 100, 0, 0]
                ],
                [
                    "SIDES",
                    ["Side", "Crew/group side for the spawned aircraft"],
                    independent
                ],
                [
                    "SLIDER",
                    ["Critical damage threshold", "Damage level at which aircraft stop scripted control and break formation"],
                    [0.1, 1, 0.8, 2]
                ]
            ],
            {
                params ["_values", "_args"];
                _args params ["_pos"];

                _values params [
                    "_planeClass",
                    "_count",
                    "_heading",
                    "_speedMS",
                    "_altitude",
                    "_spacing",
                    "_spawnDistance",
                    "_despawnDistance",
                    "_formation",
                    "_randX",
                    "_randY",
                    "_randZ",
                    "_side",
                    "_releaseDamage"
                ];

                [
                    _pos,
                    _planeClass,
                    _count,
                    _heading,
                    _speedMS,
                    _altitude,
                    _spacing,
                    _spawnDistance,
                    _despawnDistance,
                    _formation,
                    _randX,
                    _randY,
                    _randZ,
                    _side,
                    _releaseDamage
                ] remoteExecCall ["JM_ZeusModules_fnc_flyoverUniversal", 2];
            },
            {},
            [_pos]
        ] call zen_dialog_fnc_create;
    }
] call zen_custom_modules_fnc_register;



// ----------------------------------------------------------------------------------------------------------------------------------
// CBRN ZONE CONTROL
// This module allows zeus to toggle on/off cbrn zone activity at will.
// -----------------------------------------------------------------------------------------------------------------------------------

[
    "[JM] Tools",
    "CBRN Zone Control",
    {
        params ["_pos", "_object"];

        private _zoneMap = missionNamespace getVariable ["JM_CBRN_zoneMap", createHashMap];
        private _zoneIds = keys _zoneMap;

        if (_zoneIds isEqualTo []) exitWith {
            ["JM CBRN: No registered zones found."] call zen_common_fnc_showMessage;
        };

        _zoneIds sort true;

        private _content = [];

        {
            private _zoneId = _x;
            private _zone = _zoneMap get _zoneId;

            if (isNull _zone) then { continue };

            private _isActive = _zone getVariable ["cbrn_active", true];

            _content pushBack [
                "CHECKBOX",
                [
                    _zoneId,
                    format ["Toggle CBRN zone '%1'. Checked = active, unchecked = inactive.", _zoneId]
                ],
                _isActive
            ];
        } forEach _zoneIds;

        [
            "CBRN Zone Control",
            _content,
            {
                params ["_dialogValues", "_args"];
                _args params ["_zoneIds"];

                {
                    private _zoneId = _x;
                    private _newState = _dialogValues param [_forEachIndex, true];

                    [_zoneId, _newState] remoteExecCall ["JM_CBRN_fnc_setZoneActive", 2];
                } forEach _zoneIds;

                [
                    format ["JM CBRN: Updated %1 zone(s).", count _zoneIds]
                ] call zen_common_fnc_showMessage;
            },
            {},
            [_zoneIds]
        ] call zen_dialog_fnc_create;
    }
] call zen_custom_modules_fnc_register;

























































 



