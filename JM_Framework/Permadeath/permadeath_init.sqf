// Initialize permadeath management and respawn modules

// Initialize permadeath management and respawn modules


// Retrieve the default respawn delay set in description.ext
if (isServer) then {
    missionNamespace setVariable ["JM_DefaultRespawnTime", getNumber (missionConfigFile >> "respawnDelay")];
};

// **********************************************************
// ************************ PERMADEATH RESPAWN REWORK
// **********************************************************

["[JM] Permadeath", "Permadeath Respawn", {
    params ["_target", "_vehicle"];

    private _deadPlayers = allPlayers select {!alive _x};
    private _spectators = [] call ace_spectator_fnc_players;
    { if (!isNull _x) then { _deadPlayers pushBackUnique _x } } forEach _spectators;
    _deadPlayers = _deadPlayers select { isPlayer _x && {!isNull _x} };

    if (_deadPlayers isEqualTo []) exitWith {
        ["No dead players to respawn."] call zen_common_fnc_showMessage;
    };

    private _names = _deadPlayers apply { name _x };

    ["Respawn Tool", [
        ["LIST", "Select Dead Players", [_deadPlayers, _names, 0, 10]],
        ["CHECKBOX", "Respawn ALL dead players?", false],
        ["CHECKBOX", "Teleport Here?", true]
    ], {
        params ["_dialogValues", "_args"];
        _dialogValues params ["_selection", "_respawnAll", "_teleportHere"];
        _args params ["_target", "_vehicle"];



        private _deadPlayers = allPlayers select {!alive _x};
        private _spectators = [] call ace_spectator_fnc_players;
        { if (!isNull _x) then { _deadPlayers pushBackUnique _x } } forEach _spectators;
        _deadPlayers = _deadPlayers select { isPlayer _x && {!isNull _x} };

        private _players = if (_respawnAll) then {
            _deadPlayers
        } else {
            [_selection]
        };

        _players = _players select { !isNull _x && {!alive _x} };
        if (_players isEqualTo []) exitWith {
            ["No players selected."] call zen_common_fnc_showMessage;
        };

        private _destinationData = if (
            (!isNull _vehicle) &&
            { _vehicle isKindOf "LandVehicle" || _vehicle isKindOf "Air" || _vehicle isKindOf "Ship" }
        ) then {
            ["VEHICLE", netId _vehicle]
        } else {
            ["POS", ASLToAGL _target]
        };

        [_players, _destinationData, _teleportHere] remoteExec ["JM_Permadeath_fnc_handleForceRespawn", 2];

        private _playerNames = _players apply { name _x };
        private _message = format ["Attempted respawn on: %1", _playerNames joinString ", "];
        [_message] call zen_common_fnc_showMessage;

    }, {}, [_target, _vehicle]] call zen_dialog_fnc_create;

}, "\a3\ui_f\data\igui\cfg\actions\take_ca.paa"] call zen_custom_modules_fnc_register;




// **********************************************************
// ************************ ENABLE PERMADEATH
// **********************************************************



// Enable Permadeath Module
["[JM] Permadeath", "Enable Permadeath", {
    // Enable permadeath
    JM_Permadeath = true;
    publicVariable "JM_Permadeath";
    ["PERMADEATH ENABLED"] call zen_common_fnc_showMessage;

    // Create Dialog Function

    _checkBoxPermadeath = [
	// 0) Content Type
	"CHECKBOX",

	// 1) Display Name and Tooltip
	["Notify Players?", "Display message for all players about Permadeath toggle"], // or  ["Title", "Tooltip"],

	// 2) Control Specific Arguments - Default Control State
	false, // or false,

	// 3) Force Default, default: false
	false
];

[
	// 0) Title
	"NOTIFY PLAYERS",

	// 1) Content Array of Zen Dialogs
	[_checkBoxPermadeath],

	// 2) On Confirm, unscheduled
	// Passed Arguments:
	// 0) Dialog Values in order of Content
	// 1) Arguments, the same ones passed in arg4 for zen_dialog_fnc_create
	{
		params ["_dialogValues","_args"];
		_dialogValues params ["_param1"];
		_args params ["_arg1"];

        if (_param1) then {

            private _message = 
                "<img size='3' image='a3\ui_f\data\gui\cfg\hints\death_ca.paa'/><br/><br/>" +
                "<t size='1.5' color='#ffffff'>PERMADEATH ENABLED</t><br/><br/>" +
                "<t size='1.25' color='#f23535'>Warning:</t> <t size='1.25' color='#ffffff'>Reinforcements are unavailable.</t><br/><br/>";

            [parseText _message] remoteExec ["hint", 0, false];

};
	},

	// 3) On Cancel, default: {}, unscheduled
	{}, 

	// 4) Arguments, default: []
	[]

] call zen_dialog_fnc_create;

}, "\a3\ui_f\data\igui\cfg\holdactions\holdaction_forcerespawn_ca.paa"] call zen_custom_modules_fnc_register;



// **********************************************************
// ************************ DISABLE PERMADEATH
// **********************************************************

// Disable Permadeath Module
["[JM] Permadeath", "Disable Permadeath", {
    JM_Permadeath = false;
    publicVariable "JM_Permadeath";
    ["PERMADEATH DISABLED"] call zen_common_fnc_showMessage;

        // Create Dialog Function

    _checkBoxPermadeath = [
	// 0) Content Type
	"CHECKBOX",

	// 1) Display Name and Tooltip
	["Notify Players?", "Display message for all players about Permadeath toggle"], // or  ["Title", "Tooltip"],

	// 2) Control Specific Arguments - Default Control State
	false, // or false,

	// 3) Force Default, default: false
	false
];

[
	// 0) Title
	"NOTIFY PLAYERS",

	// 1) Content Array of Zen Dialogs
	[_checkBoxPermadeath],

	// 2) On Confirm, unscheduled
	// Passed Arguments:
	// 0) Dialog Values in order of Content
	// 1) Arguments, the same ones passed in arg4 for zen_dialog_fnc_create
	{
		params ["_dialogValues","_args"];
		_dialogValues params ["_param1"];
		_args params ["_arg1"];

        if (_param1) then {

            private _message = 
                "<img size='3' image='a3\ui_f\data\gui\cfg\hints\death_ca.paa'/><br/><br/>" +
                "<t size='1.5' color='#ffffff'>PERMADEATH DISABLED</t><br/><br/>" +
                "<t size='1.25' color='#4ded45'>Warning:</t> <t size='1.25' color='#ffffff'>Reinforcements are available.</t><br/><br/>";

            [parseText _message] remoteExec ["hint", 0, false];

};
	},

	// 3) On Cancel, default: {}, unscheduled
	{}, 

	// 4) Arguments, default: []
	[]

] call zen_dialog_fnc_create;
}, "\a3\ui_f_aow\data\igui\cfg\holdactions\holdaction_charity_ca.paa"] call zen_custom_modules_fnc_register;

// **********************************************************
// ************************ LIST DEAD PLAYERS
// **********************************************************



// List Dead Players Module
["[JM] Permadeath", "List Dead Players", {
    // Get all players on the server
    private _allPlayers = allPlayers;
    
    // Filter only dead players
    private _deadPlayers = _allPlayers select { !alive _x };

    // Get the names of the dead players
    private _deadNames = _deadPlayers apply {name _x};

    // Count the number of dead players
    private _deadCount = count _deadPlayers;

    // If no players are dead, notify Zeus
    if (_deadCount == 0) exitWith {
        hint "No dead players at the moment.";
    };

    // Create a message with the list of dead players, each on a new line
    private _message = format ["%1 player(s) dead:\n%2", _deadCount, _deadNames joinString "\n"];

    // Display the message locally to Zeus
    hint _message;
}, "\a3\modules_f_curator\data\portraitdiary_ca.paa"] call zen_custom_modules_fnc_register;













