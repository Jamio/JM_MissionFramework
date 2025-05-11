// JM_Framework\RallyPoint\fn_teleportToSelectedRally.sqf
disableSerialization;

if (!JM_Rally) exitWith {hint "Rally deployment has been disabled by the mission-maker"; closeDialog 0;};

private _disp = findDisplay 9010;
private _list = _disp displayCtrl 1500;
private _index = lbCurSel _list;

if (_index < 0) exitWith {
    hint "Select a rally to redeploy to.";
};

private _posString = _list lbData _index;
private _pos = call compile _posString;

if (_pos isEqualTo [0,0,0]) exitWith {
    hint "Invalid rally position.";
};

private _nearbyUnits = _pos nearEntities [["Man", "Tank", "Car", "Air"], 30];

private _nearbyEnemies = _nearbyUnits select {
    alive _x &&
    side _x getFriend side player < 0.6
};

if (count _nearbyEnemies > 0) exitWith {
    hint parseText "<t size='1.2' color='#ff0000'>Rally Unavailable - hostiles nearby!</t>";
};

// Close the dialog afterwards
closeDialog 0;


[_pos] spawn {
	params ["_teleportPos"];

	// === Show redeploying text
	titleText ["<t font='PuristaBold' color='#ffdb33' size='2'>Redeploying...</t>", "BLACK OUT", 1, true, true];
	sleep 2;
	player setPosATL _teleportPos;
	sleep 2;
	titleText ["", "BLACK IN", 3, true];
};

