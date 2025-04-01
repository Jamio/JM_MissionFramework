params ["_players", "_positionsAndDirections"]; // Receive the list of players and positions

private _playerIndex = _players findIf {player == _x}; // Find the index of the current player in the list

// Get the assigned position and direction for this player
private _assignedPosAndDir = _positionsAndDirections select _playerIndex;
private _assignedPosition = _assignedPosAndDir select 0; // The ASL position
private _assignedDirection = _assignedPosAndDir select 1; // The direction (degrees)

// Store the player's original position and direction
private _originalPosition = getPosASL player;
private _originalDirection = getDir player;


// **************************************************************
// **************** START EFFECTS
// **************************************************************

// Apply the blur effect
private _blurEffect = ppEffectCreate ["DynamicBlur", 100];  // Create the blur effect

// Enable and apply the blur effect with a 5-second transition
_blurEffect ppEffectEnable true;
_blurEffect ppEffectAdjust [3];  // Adjust the blur intensity to 3
_blurEffect ppEffectCommit 5;    // Commit the effect over 5 seconds

[player, "Acts_Stunned_Unconscious"] remoteExec ["switchMove", 0, true];

sleep 2;

// Black out the screen
cutText ["", "BLACK OUT", 3, true];

sleep 5;

cutText ["", "BLACK IN", 5, true];

// Later, when you want to revert the effect:
_blurEffect ppEffectAdjust [1];  // Set blur intensity back to 0
_blurEffect ppEffectCommit 6;    // Commit over 5 seconds

// Teleport the player to the assigned position and set their direction
player setPosASL _assignedPosition;
player setDir _assignedDirection; // Set the player's facing direction

// Play an animation on the player
[player, "ACE_AmovPercMstpSsurWnonDnon"] remoteExec ["switchMove", 0, true];

// Wait for a few seconds
sleep 15;

// black out
cutText ["", "BLACK FADED", 3, true];

sleep 2;

// Teleport back to the original position and direction
player setPosASL _originalPosition;
player setDir _originalDirection;

sleep 1;

// Black in again
cutText ["", "BLACK IN", 3, true];

// Later, when you want to revert the effect:
_blurEffect ppEffectAdjust [0];  // Set blur intensity back to 0
_blurEffect ppEffectCommit 5;    // Commit over 5 seconds

// Play another animation after teleporting back
[player, "Acts_UnconsciousStandUp_part1"] remoteExec ["switchMove", 0, true];

// Wait for the transition to finish, then destroy the effect
sleep 5;
ppEffectDestroy _blurEffect;





