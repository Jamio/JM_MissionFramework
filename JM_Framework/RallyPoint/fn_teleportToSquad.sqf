// JM_Framework\RallyPoint\fn_teleportToSquad.sqf
disableSerialization;

if (!JM_tpToSL) exitWith {hint "Squad deployment has been disabled by the mission-maker"; closeDialog 0;};

private _disp = findDisplay 9010;
private _list = _disp displayCtrl 1501;
private _index = lbCurSel _list;

if (_index < 0) exitWith {
    hint "Select a squadmate to teleport to.";
};

// Retrieve the selected unit by its netId
private _targetNetId = _list lbData _index;
private _target = objectFromNetId _targetNetId;

if (isNull _target || {!alive _target}) exitWith {
    hint "Invalid or dead teleport target.";
};

private _pos = getPosATL _target;
private _nearbyUnits = _pos nearEntities [["Man", "Tank", "Car", "Air"], 30];

private _nearbyEnemies = _nearbyUnits select {
    alive _x &&
    side _x getFriend side player < 0.6
};

if (count _nearbyEnemies > 0) exitWith {
    hint parseText format [
        "<t size='1.2' color='#ff0000'>Cannot deploy to %1 – hostiles nearby!</t>",
        name _target
    ];
};

// Close the dialog afterwards
closeDialog 0;

// Begin teleport
[_target] spawn {
    params ["_target"];

    sleep 1;

    private _veh = vehicle _target;

    if (_veh != _target) then {
        // Target is in a vehicle
        private _seats = fullCrew [_veh, "cargo", true];  // include empty
        private _emptySeats = _seats select { _x select 0 isEqualTo objNull };

        if (count _emptySeats > 0) then {

			// === Show redeploying text
			titleText ["<t font='PuristaBold' color='#ffdb33' size='2'>Redeploying...</t>", "BLACK OUT", 1, true, true];

			sleep 2;

            player moveInCargo _veh;


            sleep 1;
            if (vehicle player == _veh) then {
                hint format ["Teleported into %1's vehicle!", name _target];

                // Notify crew
                private _crew = crew _veh select {isPlayer _x}; // Filter only players
                private _msg = format ["%1 has deployed into your vehicle.", name player];

                [_msg] remoteExec ["hint", _crew, false];  // Broadcast to just the crew
            } else {
                hint "Vehicle was full. Teleport failed.";
            };
        } else {
            hint "No available passenger seats.";
        };
    } else {

		// === Show redeploying text
		titleText ["<t font='PuristaBold' color='#ffdb33' size='2'>Redeploying...</t>", "BLACK OUT", 1, true, true];

		sleep 3;

        // Target is on foot
        player setPosATL getPosATL _target;
        hint format ["Teleported to %1!", name _target];
    };

    sleep 2;

    titleText ["", "BLACK IN", 3, true];
};
