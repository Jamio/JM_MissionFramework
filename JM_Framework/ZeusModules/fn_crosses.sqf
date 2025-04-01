// fn_crosses.sqf
params ["_targetPlayer"];



// +++++++++++++++++++++++++++++++++++++
// ++++++++++++++ APPLY POST PROC EFFECTS
// +++++++++++++++++++++++++++++++++++++

PP_radial = ppEffectCreate ["radialBlur",100];
PP_radial ppEffectEnable true;
PP_radial ppEffectAdjust [0.17,0.19,0.3,0.3];
PP_radial ppEffectCommit 15;
PP_chrom = ppEffectCreate ["ChromAberration",200];
PP_chrom ppEffectEnable true;
PP_chrom ppEffectAdjust [0.05,0.05,true];
PP_chrom ppEffectCommit 15;
PP_colorC = ppEffectCreate ["ColorCorrections",1500];
PP_colorC ppEffectEnable true;
PP_colorC ppEffectAdjust [0.68,1.51,0.14,[-0.08,0,0,0.03],[4.23,1,1,-1],[1.93,0.33,0.33,0.11],[0.58,0.46,-0.01,0,0,0,4]];
PP_colorC ppEffectCommit 15;



// Array of tombstone classnames; replace with your specific tombstone classnames
private _tombstoneClasses = [
"Land_Tombstone_06_F", 
"Land_Tombstone_12_F", 
"Land_Tombstone_13_F", 
"Land_Church_tomb_2", 
"Land_Church_tomb_1"
];

// +++++++++++++++++++++++++++++++++++++
// ++++++++++++++ SETUP TOMBSTONES
// +++++++++++++++++++++++++++++++++++++

// Number of tombstones to spawn
private _numberOfTombstones = 50;

// Radius within which to spawn the tombstones
private _spawnRadius = 50;

_tombstones = []; // setup array to catch tombstones for deletion

// +++++++++++++++++++++++++++++++++++++
// ++++++++++++++ WAIT AND MAKE PLAYER AFRAID
// +++++++++++++++++++++++++++++++++++++

sleep 10;

[_targetPlayer, "Acts_ShockedUnarmed_2_Loop"] remoteExec ["switchMove", 0, true]; // Ensure animation plays globally

sleep 2;

// +++++++++++++++++++++++++++++++++++++
// ++++++++++++++ TOMBSTONE SPAWN and SOUNDS
// +++++++++++++++++++++++++++++++++++++

// Spawn tombstones around the target player
for "_i" from 1 to _numberOfTombstones do {
    // Random position around the player within the defined radius
    private _randomPos = _targetPlayer getPos [(_spawnRadius * random 1), random 360];
    private _randomClass = selectRandom _tombstoneClasses; // Select a random tombstone class

    // Spawn the tombstone locally at the random position
    private _tombstone = _randomClass createVehicleLocal _randomPos;

    // Calculate direction to face the player
    private _directionToPlayer = _tombstone getDir _targetPlayer;

    // Set the tombstone direction to face towards the player
    _tombstone setDir _directionToPlayer;

	    // Add the tombstone to the array for cleanup later
    _tombstones pushBack _tombstone;
};

// Play a spooky sound, replace "CrossSound" with the actual sound class you want to use

sleep 15;

// +++++++++++++++++++++++++++++++++++++
// ++++++++++++++ CLEANUP EVERYTHING
// +++++++++++++++++++++++++++++++++++++

PP_radial ppEffectAdjust [0.1,0.1,0.3,0.3];
PP_radial ppEffectCommit 15;
PP_chrom ppEffectAdjust [0.01,0.01,true];
PP_chrom ppEffectCommit 15;
PP_colorC ppEffectAdjust [1,1,0,[0,0,0,0],[1,1,1,1],[0.33,0.33,0.33,0],[0,0,0,0,0,0,4]];
PP_colorC ppEffectCommit 15;

sleep 10;

ppEffectDestroy [PP_radial, PP_chrom, PP_colorC]; 

{
    deleteVehicle _x;
} forEach _tombstones;

titleText ["", "BLACK FADED"];

[_targetPlayer, ""] remoteExec ["switchMove", 0, true];

sleep 1;

titleText ["", "BLACK IN"];


// "ApanPknlMstpSnonWnonDnon_G02"

/*
"Land_Tombstone_06_F", 
"Land_Tombstone_12_F", 
"Land_Tombstone_13_F", 
"Land_Church_tomb_2", 
"Land_Church_tomb_1"
*/