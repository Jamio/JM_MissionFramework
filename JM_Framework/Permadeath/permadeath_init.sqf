// Initialize permadeath management and respawn modules

// Initialize permadeath management and respawn modules

JM_isPermadeathEnabled = false;
publicVariable "JM_isPermadeathEnabled";


// Retrieve the default respawn delay set in description.ext
if (isServer) then {
    missionNamespace setVariable ["JM_DefaultRespawnTime", getNumber (missionConfigFile >> "respawnDelay")];
};

// **********************************************************
// ************************ PERMADEATH RESPAWN
// **********************************************************



["[JM] Permadeath", "Permadeath Respawn", {
    params ["_target"]; // Module position or vehicle

    // Gather dead players
    private _deadPlayers = allPlayers select {!alive _x};
    _deadPlayers = allPlayers; // REMOVE THIS WHEN DEBUG IS NO LONGER NEEDED
    if (_deadPlayers isEqualTo []) exitWith {
        ["No dead players found."] call zen_common_fnc_showMessage;
    };

    // Player name list for dropdown
    private _names = _deadPlayers apply {name _x};

    ["Respawn Tool", [
        ["OWNERS", "Select Players", [[], [], _deadPlayers, 2]], // Default tab: Players
        ["CHECKBOX", "Teleport to Module Position?", true],
        ["CHECKBOX", "Place in Cargo (if applicable)?", true]
    ], {
        params ["_dialogValues", "_args"];
        _dialogValues params ["_selection", "_teleportToPos", "_placeInCargo"];
        _args params ["_target"];

        private _players = _selection select 2; // Extract the selected players array

        if (_players isEqualTo []) exitWith {
            ["No players selected."] call zen_common_fnc_showMessage;
        };

        {
            if (!alive _x) then {
                [_target, _teleportToPos, _placeInCargo] remoteExec ["JM_Permadeath_fnc_forceRespawn", _x];
            } else {
                [format ["%1 is not dead, skipping.", name _x]] call zen_common_fnc_showMessage;
            };
        } forEach _players;

        [format ["Attempted respawn on %1 player(s).", count _players]] call zen_common_fnc_showMessage;

    }, {}, [_target]] call zen_dialog_fnc_create;

}, "\a3\ui_f\data\igui\cfg\actions\take_ca.paa"] call zen_custom_modules_fnc_register;



// **********************************************************
// ************************ ENABLE PERMADEATH
// **********************************************************



// Enable Permadeath Module
["[JM] Permadeath", "Enable Permadeath", {
    // Enable permadeath
    JM_isPermadeathEnabled = true;
    publicVariable "JM_isPermadeathEnabled";
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
    JM_isPermadeathEnabled = false;
    publicVariable "JM_isPermadeathEnabled";
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
// ************************ FORCE RESPAWN ALL
// **********************************************************

// Force Respawn (All) Module
["[JM] Permadeath", "Force Respawn ALL", {
    params ["_pos"];
    private _players = [] call ace_spectator_fnc_players;

    // Filter only dead players
    _players = _players select { !alive _x };

    if (count _players == 0) exitWith {["No dead players"] call zen_common_fnc_showMessage};

    // Call forceRespawn for all players using remoteExec
    [_pos] remoteExecCall ["JM_Permadeath_fnc_forceRespawn"];
    ["Respawned all players at %1", mapGridPosition _pos] call zen_common_fnc_showMessage;
}, "\a3\ui_f_curator\data\displays\rscdisplaycurator\modegroups_ca.paa"] call zen_custom_modules_fnc_register;


// **********************************************************
// ************************ FORCE RESPAWN SINGLE
// **********************************************************

// Force Respawn (Single) Module
["[JM] Permadeath", "Force Respawn SINGLE", {
    params ["_pos"];
    private _players = [] call ace_spectator_fnc_players;

    // Filter only dead players
    _players = _players select { !alive _x };

    if (count _players == 0) exitWith {["No dead players"] call zen_common_fnc_showMessage};

    private _names = _players apply {name _x};
    ["Respawn Single Player", [
        ["COMBO", "Player", [_players, _names]]
    ], {
        params ["_dialog", "_args"];
        _args params ["_pos"];
        _dialog params [["_plr", objNull, [objNull]]];
        if (isNull _plr) exitWith {["No player selected"] call zen_common_fnc_showMessage};

        // Call forceRespawn for the selected player using remoteExec
        [_pos] remoteExecCall ["JM_Permadeath_fnc_forceRespawn", _plr];
        ["Respawned %1 at %2", name _plr, mapGridPosition _pos] call zen_common_fnc_showMessage;
    }, {}, [_pos]] call zen_dialog_fnc_create;
}, "\a3\modules_f_bootcamp\data\portraitpunishment.paa"] call zen_custom_modules_fnc_register;


// **********************************************************
// ************************ FORCE RESPAWN CARGO
// **********************************************************


// Force Respawn in Vehicle Cargo Module
["[JM] Permadeath", "Force Respawn CARGO", {
    params ["_veh"];
    private _players = [] call ace_spectator_fnc_players;

    // Filter only dead players
    _players = _players select { !alive _x };

    if (count _players == 0 || {_veh emptyPositions "cargo" <= 0}) exitWith {["No dead players or no cargo space"] call zen_common_fnc_showMessage};

    private _cargoPlayers = _players select [0, _veh emptyPositions "cargo"];

    // Call forceRespawn for all players in cargo using remoteExec
    {
        [_veh] remoteExecCall ["JM_Permadeath_fnc_forceRespawn", _x];
    } forEach _cargoPlayers;

    ["Moved %1 players into vehicle", count _cargoPlayers] call zen_common_fnc_showMessage;
}, "\a3\ui_f\data\igui\cfg\actions\getincargo_ca.paa"] call zen_custom_modules_fnc_register;


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













