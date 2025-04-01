// onPlayerKilled.sqf

if !(JM_unconSpectator) exitWith {};

// Ensure spectator mode is disabled before camera effect starts
[false] call ace_spectator_fnc_setSpectator;

// Block respawn if permadeath is enabled
if (JM_Permadeath) then {
    setPlayerRespawnTime 99999;
};

// Camera Sequence
[] spawn {
    sleep 2;

    private _camera = "camera" camCreate (position player);
    _camera cameraEffect ["Internal", "Back"];
    _camera camSetTarget player;
    _camera camSetPos [
        (position player select 0),
        (position player select 1),
        (position player select 2) + 10
    ];
    _camera camSetFOV 0.2;
    _camera camCommit 0;
    waitUntil { camCommitted _camera };

    _camera camSetFOV 0.5;
    _camera camCommit 15;

    sleep 15;

    // Clean up camera and ensure spectator is enabled if permadeath is on
    _camera cameraEffect ["Terminate", "Back"];
    camDestroy _camera;

    if (JM_Permadeath) then {
        [true, true, true] call ace_spectator_fnc_setSpectator;

            // Display the formatted hint explaining permadeath
    [] spawn {
        sleep 3; // Ensure spectator mode activates first
        hint parseText "<t size='2' color='#FF0000'><br/>PERMADEATH</t><br/><br/>
        <t size='1.2' color='#FFFFFF'>You are unable to respawn until a mission event or a Zeus intervenes.</t><br/><br/>
        <t size='1' color='#AAAAAA'>(Wait for further instructions.)</t>";
    };

    };
};






