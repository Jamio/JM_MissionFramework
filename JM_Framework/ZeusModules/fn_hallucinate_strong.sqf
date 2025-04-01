
// zeusmodules_fnc_hallucinate.sqf

params ["_player"];

// Ensure it runs on the correct client
if (!isPlayer _player) exitWith {
    diag_log "Error: Script executed on the wrong client or target is not a player.";
};

// Simple action for testing
removeAllWeapons _player;

// Debug log to confirm execution
diag_log format ["Hallucinate function executed on: %1", name _player];

// Optional hint for visual confirmation
["Function executed on player!"] remoteExec ["hint", _player];

