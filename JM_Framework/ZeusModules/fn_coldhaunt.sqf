// Foggy breath 20110122
//Updated by dedmen 27.07.2019

params ["_unit"];

_unit setVariable ["coldHaunt", true, true];

// Ensure you have the frostOverlay resource, or use default visual effect for testing
cutRsc ["frostOverlay", "PLAIN", 10, true, true]; // Replace with a default effect if this fails for debugging

// Create the fog source object
private _source = createSimpleObject ["CBA_NamespaceDummy", getPos _unit]; // Test with a visible object for now
_source attachTo [_unit, [0,0.15,0], "neck"]; // Attach the object to the player's neck

// Debugging: Check if object is created and attached
systemChat "Fog source object attached.";

// Start fog particle effects loop
/* while {alive _unit && _unit getVariable ["coldHaunt", false]} do {
    systemChat "Breath particle effect triggered."; // Debugging line
    sleep (2 + random 2); // Random time between breaths

    private _fog = "#particlesource" createVehicleLocal getPos _source;
    _fog setParticleParams [
        ["\A3\Data_F\ParticleEffects\Universal\universal.p3d", 16, 12, 13,0],
        "", 
        "Billboard", 
        0.5, // Timer
        0.5, // Lifetime
        [0,0,0], // Position
        [0, 0.2, -0.2], // Move velocity
        1, // Rotation velocity
        1.275, // Weight
        1, // Volume
        0.2, // Rubbing
        [0, 0.2,0], // SizeOverLiftime
        [[1,1,1,0.5], // Colour
        [1,1,1, 0.01], // AnimSpeed
        [1,1,1, 0]], // Random
        [1000], 
        1, 
        0.04, 
        "", 
        "", 
        _source
    ];
    _fog setParticleRandom [2, [0, 0, 0], [0.25, 0.25, 0.25], 0, 0.5, [0, 0, 0, 0.1], 0, 0, 10];
    _fog setDropInterval 0.001;

    sleep 0.5; // Half-second exhalation
    deleteVehicle _fog; // Clean up the fog particle effect
};
*/

// Start a `for` loop that runs _maxLoops times
for "_i" from 1 to 30 do {
    // Check if the unit is still alive
    if !(alive _unit) exitWith {};

    systemChat "Breath particle effect triggered."; // Debugging line
    sleep (2 + random 2); // Random time between breaths

    private _fog = "#particlesource" createVehicleLocal getPos _source;
    _fog setParticleParams [
        ["\A3\Data_F\ParticleEffects\Universal\universal.p3d", 16, 12, 13, 0],
        "", 
        "Billboard", 
        0.5, // Timer
        0.5, // Lifetime
        [0, 0, 0], // Position
        [0, 0.2, -0.2], // Move velocity
        1, // Rotation velocity
        1.275, // Weight
        1, // Volume
        0.2, // Rubbing
        [0, 0.2, 0], // SizeOverLiftime
        [[1, 1, 1, 0.5], [1, 1, 1, 0.01], [1, 1, 1, 0]], // Color
        [1000], 
        1, 
        0.04, 
        "", 
        "", 
        _source
    ];
    _fog setParticleRandom [2, [0, 0, 0], [0.25, 0.25, 0.25], 0, 0.5, [0, 0, 0, 0.1], 0, 0, 10];
    _fog setDropInterval 0.001;

    sleep 0.5; // Half-second exhalation
    deleteVehicle _fog; // Clean up the fog particle effect
};

deleteVehicle _source; // Clean up the attached object

// Placeholder for adding breathing sounds
// Add sound using remoteExec ["say3D", _unit] or similar

sleep 15;

// Cleanup the visual effects
cutText ["", "PLAIN"]; // Clear overlay

systemChat "coldhaunt finished";


