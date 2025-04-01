//this addAction ["TeleportText","teleport.sqf",[objectName]];

// Check if teleporting to squad is enabled
if !(JM_Rally) exitWith {
    hint "Rally Points are currently disabled.";
};

// Get the destination.
_dest = (_this select 3) select 0;

// Get a random direction
_dir = random 359;

// Move the person about 2 meters away from the destination (in the direction of _dir)

"test" cutText ["", "BLACK", 0.5, true];
sleep 1;
player setVehiclePosition [(_dest modelToWorld[0,2,0]), [],1, "CAN_COLLIDE"];
"test" cutFadeout 2;