// JM_Framework\RallyPoint\teleport.sqf

// Check if teleporting to squad is enabled
if !(JM_Rally) exitWith {
    hint "Rally Points are currently disabled.";
};

// Get the destination marker from arguments
params ["_dest"];

// Get a random direction
private _dir = random 359;

// Teleport the player ~2 meters offset from the destination
"test" cutText ["", "BLACK", 0.5, true];
sleep 1;
player setVehiclePosition [(_dest modelToWorld [0, 2, 0]), [], 1, "CAN_COLLIDE"];
"test" cutFadeout 2;
