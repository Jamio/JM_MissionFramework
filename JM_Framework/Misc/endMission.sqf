// endMission.sqf

[] spawn {

// get current state of variable, missionNameSpace used to catch error when machine is not running DUI
private _state = missionNameSpace getVariable ["diwako_dui_main_toggled_off", false];
// time in seconds when ui should be re-enabled
private _wait = 80;
// hide DUI, just setting this variable is enough
diwako_dui_main_toggled_off = true;

[{
    // _this is the boolean that was retrieved using missionNameSpace
    // this will ensure the same value that was set before the cutscene is being set again
    // there are players that prefer having DUI hidden as the default value
    diwako_dui_main_toggled_off = _this;
}, _state, _wait] call CBA_fnc_waitAndExecute;

    setWind [10, 0, true];
    playMusic "Outro";

	cutText ["", "BLACK OUT", 5, true, false, true];

	sleep 2;

	

    // Disable player control
    [player] call ace_medical_treatment_fnc_fullHealLocal;
    player allowDamage false;
    player setCaptive true;
	5 fadeSound 0;
	5 fadeRadio 0;
	5 fadeEnvironment 0;

	sleep 2;

    // Create and configure the camera
    private _camera = "camera" camCreate [0, 0, 0];
    _camera cameraEffect ["Internal", "Back"];
    
    // Position and set camera to a desired view (example position and angle)
    _camera camSetPos getPos cam_1; // Adjust camera position
    _camera camSetTarget cam_focus1;  // Focus camera on the player or a specific object
    _camera camSetFOV 0.55;  // Field of view (can be adjusted)
    _camera camCommit 0;

	cutText ["", "BLACK IN", 2, true, false, true];

	sleep 2;

titleText [
    "<t valign='middle' align='center' size='3' color='#ffe396' font='PuristaMedium' shadow='0'>The fighting in this template mission was bigly.</t>",
    "PLAIN", -1, true, true
		];	


sleep 10;

	titleText [
    "<t valign='middle' align='center' size='3' color='#ffe396' font='PuristaMedium' shadow='0'>The Misfits died lots, because they are sometimes very stupid.</t>",
    "PLAIN", -1, true, true
		];


sleep 10;

	titleText [
    "<t valign='middle' align='center' size='3' color='#ffe396' font='PuristaMedium' shadow='0'>Buccaneer designated an LZ on top of an AA emplacement, and Max flew a C-130</t><br/>
	<t valign='middle' align='center' size='3' color='#ffe396' font='PuristaMedium' shadow='0'>into the side of a mountain</t>",
    "PLAIN", -1, true, true
		];

sleep 10;

	titleText [
    "<t valign='middle' align='center' size='3' color='#ffe396' font='PuristaMedium' shadow='0'>Maybe they will have better luck next time.</t><br/>
	<t valign='middle' align='center' size='3' color='#ffe396' font='PuristaMedium' shadow='0'>But I doubt that very much.</t>",
    "PLAIN", -1, true, true
		];


sleep 15;

_totalKills = totalKills;
_totalLosses = totalLosses;


	titleText [
    format [
        "<t valign='middle' align='center' size='5' color='#32a852' font='PuristaMedium'>MISSION COMPLETED</t><br/>
		<t valign='middle' align='center' size='2.5' color='#FFFFFF' font='PuristaMedium' shadow='0'>Misfits PMC</t><br/>
		<t valign='middle' align='center' size='2.5' color='#FFFFFF' font='PuristaMedium' shadow='0'>Confirmed Kills: %1</t><br/>
		<t valign='middle' align='center' size='2.5' color='#FFFFFF' font='PuristaMedium' shadow='0'>Losses: %2</t>",
        _totalKills, _totalLosses
    ], 
    "PLAIN", -1, true, true
];

sleep 15;

cutText ["", "BLACK OUT", 5, true, false, true];


["end1", true, 5, false, false] call BIS_fnc_endMission;

};