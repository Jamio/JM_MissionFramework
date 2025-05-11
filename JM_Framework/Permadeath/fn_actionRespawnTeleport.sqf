/*
    JM_Permadeath_fnc_actionRespawnTeleport.sqf
    Params:
        0: OBJECT - Object to teleport to
*/

params ["_destinationObject"];

if (alive player) exitWith {};

// === Exit ACE Spectator
[false, false, false] call ace_spectator_fnc_setSpectator;

// === Reset respawn timer
setPlayerRespawnTime 3;

// === Show redeploying text
titleText ["<t font='PuristaBold' color='#ffdb33' size='2'>Redeploying...</t>", "BLACK OUT", 1, true, true];

sleep 3;

// === Wait for respawn
waitUntil {alive player};

// === Teleport
player setPosATL (getPosATL _destinationObject);

// === Fade back in
titleText ["", "BLACK IN", 1];
sleep 1;


