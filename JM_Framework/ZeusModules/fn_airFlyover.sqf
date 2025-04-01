if (!isServer) exitWith {};

private _spawnPos = player getPos [500, 90];  // Spawns 500m east of player
private _direction = 90;  // Fixed direction (east)

// Spawn the plane
private _plane = createVehicle ["B_Plane_CAS_01_F", _spawnPos, [], 0, "FLY"];

// Ensure it exists before proceeding
if (isNull _plane) exitWith { systemChat "ERROR: Plane spawn failed!"; };

// Add a crew
createVehicleCrew _plane;

// Set altitude manually
_plane setPosATL [_spawnPos select 0, _spawnPos select 1, 500];

// Disable AI control
{ _x disableAI "ALL"; } forEach crew _plane;

//*************************************************************
//           APPLY INITIAL VELOCITY & SPEED LIMIT
//*************************************************************

private _velocity = [0, 200, 0];  // **Using WW2 script speed**
_plane setVelocityModelSpace _velocity;
_plane setVectorDirAndUp [[1, -0.08, 0], [0, 0, 1]];  // **Slight downward tilt like WW2 script**
_plane limitSpeed 205; // **Lock AI behavior**

//*************************************************************
//           APPLY AI-LOCKING SETTINGS
//*************************************************************

[_plane, true] remoteExec ["allowCrewInImmobile", _plane];  
[_plane, [false, false]] remoteExec ["setUnloadInCombat", _plane];

[_plane, true] remoteExec ["lockDriver", _plane];
[_plane, [[0], true]] remoteExec ["lockTurret", _plane];

[_plane, 1] remoteExec ["setFuel", _plane];  // **Ensures full fuel, prevents depletion**
[_plane, true] remoteExec ["EngineOn", _plane];  // **Forces engine ON**
[_plane, false] remoteExec ["allowDamage", _plane];  // **Prevents AI from being affected by damage**

//*************************************************************
//           EXACTLY MIRRORED `EachFrame` HANDLER
//*************************************************************

if (isNil "PlaneFlightHandler") then {
    PlaneFlightHandler = addMissionEventHandler ["EachFrame", {
        {
            [_x, [0, 55.5, 0]] remoteExec ["setVelocityModelSpace", _x];
            [_x, [[1, -0.08, 0], [0, 0, 1]]] remoteExec ["setVectorDirAndUp", _x];
        } forEach (entities "Air");  // Apply to all active aircraft
    }];
};

// Debug Message
systemChat format ["Spawned plane at %1, moving east at %2 km/h using precompiled script.", _spawnPos, 205];
