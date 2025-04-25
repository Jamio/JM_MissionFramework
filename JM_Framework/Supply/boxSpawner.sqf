/*
HOW TO USE:
1. Place any container or object in the editor.
2. In its **init field**, add:
   `this execVM "JM_Framework\Supply\boxspawner.sqf";`
3. It will automatically apply the supply crate spawning actions to that object.
*/

// JM_Framework\Supply\boxSpawner.sqf

if (!hasInterface) exitWith {};  // Clients only

params ["_box"];
if (isNull _box) exitWith { systemChat "ERROR: Box spawner object is null."; };

// Tag this object as a valid supply spawner
_box setVariable ["JM_SupplySpawner", true, true];

// Add one clean action to open the GUI
_box addAction [ 
    "<img image='\a3\ui_f\data\map\vehicleicons\iconcrateord_ca.paa' size='1.2' shadow='0'/> <t color='#ffdb33'>Open Supply Menu</t>", 
    { [] call JM_Supply_fnc_showSupplyDialog}, 
    [], 
    1.5, 
    true, 
    true, 
    "", 
    "_target distance _this < 4", 
    5 
];


