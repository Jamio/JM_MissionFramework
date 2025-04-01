/*
HOW TO USE:
1. Place any container or object in the editor.
2. In its **init field**, add:
   `this execVM "JM_Framework\Supply\boxspawner.sqf";`
3. It will automatically apply the supply crate spawning actions to that object.
*/

if (!hasInterface) exitWith {};  // Only needed for clients

params ["_box"];

// Ensure the script is applied to a valid object
if (isNull _box) exitWith { systemChat "ERROR: Box spawner object is null."; };

// Add Medical Crate Action
_box addAction
[
    "<t color='#e0a133'>Medical Supply Crate</t>",
    { [_this select 0] execVM "JM_Framework\Supply\medCrate_spawn.sqf"; },
    nil, 1.5, true, true, "", "true", 10, false, "", ""
];

// Add Ammo Resupply Crate Action (Now uses global loadout data)
_box addAction
[
    "<t color='#e0a133'>Ammo Supply Crate</t>",
    { [_this select 0] execVM "JM_Framework\Supply\ammoCrate_spawn.sqf"; },
    nil, 1.5, true, true, "", "true", 10, false, "", ""
];

// Add CSW (Crew-Served Weapons) Crate Action
_box addAction
[
    "<t color='#e0a133'>CSW Supply Crate</t>",
    { [_this select 0] execVM "JM_Framework\Supply\cswCrate_spawn.sqf"; },
    nil, 1.5, true, true, "", "true", 10, false, "", ""
];

// Add Empty Box Action
_box addAction
[
    "<t color='#e0a133'>Empty Supply Box</t>",
    { [_this select 0] execVM "JM_Framework\Supply\emptyCrate_spawn.sqf"; },
    nil, 1.5, true, true, "", "true", 10, false, "", ""
];

// Add Custom Crate Action
_box addAction
[
    "<t color='#e0a133'>Custom Supply Crate</t>",
    { [_this select 0] execVM "JM_Framework\Supply\customCrate_spawn.sqf"; },
    nil, 1.5, true, true, "", "true", 10, false, "", ""
];

