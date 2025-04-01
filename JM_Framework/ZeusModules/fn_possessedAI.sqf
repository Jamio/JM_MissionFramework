// possessed.sqf
params ["_unit"];

if !(local _unit) exitWith {};

// Check if the unit is valid and alive
if !(alive _unit) exitWith {
    systemChat "Error: Target is invalid or already dead.";
    diag_log format ["Error: Target %1 is invalid or already dead.", name _unit];
};

systemChat "Started possess function.";

sleep 2;


// Sleep for the specified duration
sleep 15;


// +++++++++++++++++++++++++++++++++++++
// ++++++++++++ POSSESSION ANIMATION
// +++++++++++++++++++++++++++++++++++++

 // _randomAnim = selectRandom ["A_PlayerDeathAnim_Electric","SM_Sword_Execution_Victim", "STAR_WARS_FORCE_CHOKE_victim", "WBK_IMS_zwei_execution_victim", "WBK_Smasher_Execution"];
// "Corrupted_Attack_Victim"

_randomAnim = selectRandom ["Corrupted_Attack_Victim", "A_PlayerDeathAnim_Electric"];

// Play the specific animation on the unit, visible to all clients
[_unit, _randomAnim] remoteExec ["switchMove", 0, true]; // Ensure animation plays globally

// Wait for the animation to play (adjust sleep time as needed)
sleep 1;

// +++++++++++++++++++++++++++++++++++++
// ++++++++++++ BLOOD CHUNKS PARTICLES
// +++++++++++++++++++++++++++++++++++++

// Create particle effects at the unit's position to simulate an explosion
private _explosionPos = getPosASL _unit;
private _particleEffect = "#particlesource" createVehicle _explosionPos; // Create the particle effect globally

_particleEffect setParticleCircle [0, [0, 0, 0]];
_particleEffect setParticleRandom [0, [0, 0.1, 0.5], [0.175, 0.175, 0], 1.1, 0.5, [1, 0, 0, 0.1], 0, 0];
_particleEffect setParticleParams [
    ["\A3\data_f\ParticleEffects\Universal\Meat_ca.p3d", 1, 0, 1], // 0: Model parameters
    "",                                                          // 1: AnimationName (unused, keep empty)
    "SpaceObject",                                                // 2: Type ("Billboard" or "SpaceObject")
    1,                                                            // 3: Timer period (in seconds)
    12.5,                                                         // 4: Lifetime (in seconds)
    [0, 0, 1.5],                                                  // 5: Position
    [0.05, 0.05, 0.75],                                           // 6: Move velocity
    0,                                                            // 7: Rotation velocity
    15,                                                           // 8: Weight
    10,                                                           // 9: Volume
    0.075,                                                        // 10: Rubbing (wind friction)
    [1.2, 10, 4],                                                 // 11: Size over time
    [[0.1, 0.1, 0.1, 1], [0.25, 0.25, 0.25, 0.5], [0.5, 0.5, 0.5, 0]], // 12: Color (RGBA)
    [0.08],                                                       // 13: Animation phase (speed over lifetime)
    2,                                                            // 14: Random direction period
    0.5,                                                          // 15: Random direction intensity
    "",                                                           // 16: OnTimer (optional script)
    "",                                                           // 17: BeforeDestroy (optional script)
    _unit
];

_particleEffect setDropInterval 0.05;

// +++++++++++++++++++++++++++++++++++++
// ++++++++++++ BLOOD MIST
// +++++++++++++++++++++++++++++++++++++

// "WarFXPE\ParticleEffects\Universal\smoke_02"; "\A3\data_f\cl_basic.p3d"

// Create particle effects at the unit's position to simulate an explosion
private _explosionPos2 = getPosASL _unit;
private _particleEffect2 = "#particlesource" createVehicle _explosionPos2; // Create the particle effect globally

_particleEffect2 setParticleCircle [0, [0, 0, 0]];
_particleEffect2 setParticleRandom [0, [0.05, 0.05, 0.5], [0.3, 0.3, 0], 0, 0.25, [0, 0, 0, 0.1], 0.2, 1.5];
_particleEffect2 setParticleParams [
    ["WarFXPE\ParticleEffects\Universal\smoke_02", 1, 0, 1],                         // 0: Model parameters
    "",                                                           // 1: AnimationName (unused, keep empty)
    "Billboard",                                                   // 2: Type ("Billboard" or "SpaceObject")
    1,                                                            // 3: Timer period (in seconds)
    3,                                                            // 4: Lifetime (in seconds)
    [0, 0, 1.2],                                                  // 5: Position
    [0, 0, 1],                                                    // 6: Move velocity
    0,                                                            // 7: Rotation velocity
    15,                                                           // 8: Weight
    7.9,                                                          // 9: Volume
    0.075,                                                        // 10: Rubbing (wind friction)
    [0.5, 0.7, 2],                                                // 11: Size over time
    [[0.3, 0.05, 0.05, 0.5],                                      // 12: Color (RGBA) over lifetime
[0.3, 0.05, 0.05, 0.5], 
[0.3, 0.05, 0.05, 0.5], 
[0.3, 0.05, 0.05, 0.5], 
[0.3, 0.05, 0.05, 0.5], 
[0.3, 0.05, 0.05, 0.5], 
[0.3, 0.05, 0.05, 0.5], 
[0.3, 0.05, 0.05, 0.5], 
[0.3, 0.05, 0.05, 0.5], 
[0.3, 0.05, 0.05, 0.5]],
    [0.08, 0, 1],                                                 // 13: Animation phase (speed over lifetime)
    1,                                                            // 14: Random direction period
    0,                                                            // 15: Random direction intensity
    "",                                                           // 16: OnTimer (optional script)
    "",                                                           // 17: BeforeDestroy (optional script)
    _unit                                                        // 18: Object (attach particle to object)
];

_particleEffect2 setDropInterval 0.025;

_particleEffect attachTo [_unit, [0,0.15,0], "neck"];
_particleEffect2 attachTo [_unit, [0,0.15,0], "neck"];

// Play explosion sound effect, audible to all clients
[_unit, "ExplosionSoundClass"] remoteExec ["say3D", 0, true]; // Replace "ExplosionSoundClass" with the correct sound class

sleep 4;

// Define the object class names for the body prop and blood pool
private _bodyPropClass = "no_skin_body_pos1"; // Replace with the actual classname of the body prop
private _bloodPoolClass = "BloodPool_01_Large_New_F"; // Replace with the actual classname of the blood pool object

// Spawn the body prop at a temporary safe position, allowing collision, then manually set its position
private _bodyProp = createVehicle [_bodyPropClass, [0, 0, 0], [], 0, "CAN_COLLIDE"];
_bodyProp setPosASL _explosionPos; // Manually set to the exact desired position
_bodyProp setDir getDir _unit; // Align the prop with the unit's direction
_bodyProp enableSimulationGlobal false; // Disable simulation to prevent further movement

// Spawn the blood pool at a temporary safe position, allowing collision, then manually set its position
private _bloodPool = createVehicle [_bloodPoolClass, [0, 0, 0], [], 0, "CAN_COLLIDE"];
_bloodPool setPosASL _explosionPos; // Manually set to the exact desired position
_bloodPool enableSimulationGlobal false; // Disable simulation to prevent further movement


// +++++++++++++++++++++++++++++++++++++
// ++++++++++++ TELEPORT UNIT AND SET BLOOD
// +++++++++++++++++++++++++++++++++++++


// Find a random safe position within 50 meters of the unit's current position
_safePosition = [_unit, 50, 100, 2, 0] call BIS_fnc_findSafePos;

// Have to add a 0 to the end of the safePos array because it only returns x and y
_safePosition pushBack 0;

// Teleport the unit to the safe position
_unit setPosASL _safePosition;

// Play unconscious wakeup animation on the unit
[_unit, "Acts_UnconsciousStandUp_part1"] remoteExec ["switchMove", 0, true]; // Replace with the correct wakeup animation if needed

sleep 1;

deleteVehicle _particleEffect;
deleteVehicle _particleEffect2;

// Log the action for debugging
systemChat format ["Unit %1 was possessed, exploded, and body removed.", name _unit];
diag_log format ["Unit %1 was possessed, exploded, and body removed.", name _unit];





