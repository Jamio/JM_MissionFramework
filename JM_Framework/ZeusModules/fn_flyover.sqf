/*
    JM_ZeusModules_fnc_flyover

    Params:
        0: ARRAY   - flyover position
        1: STRING  - plane classname
        2: NUMBER  - plane count
        3: NUMBER  - heading
        4: NUMBER  - speed (m/s)
        5: NUMBER  - altitude
        6: NUMBER  - spacing
        7: NUMBER  - spawn distance
        8: NUMBER  - despawn distance
        9: STRING  - formation type ("wedge", "line", "column", "scatter")
        10: NUMBER - random horizontal offset
        11: NUMBER - random depth offset
        12: NUMBER - random height offset
        13: SIDE   - crew/group side
*/

if (!isServer) exitWith {};

params [
    ["_flyoverPos", [0, 0, 0], [[]]],
    ["_planeClass", "", [""]],
    ["_count", 5, [0]],
    ["_heading", 90, [0]],
    ["_speedMS", 55.5, [0]],
    ["_altitude", 350, [0]],
    ["_spacing", 60, [0]],
    ["_spawnDistance", 4000, [0]],
    ["_despawnDistance", 4000, [0]],
    ["_formation", "wedge", [""]],
    ["_randX", 0, [0]],
    ["_randY", 0, [0]],
    ["_randZ", 0, [0]],
    ["_side", independent, [west]]
];

if (_planeClass isEqualTo "") exitWith {};
if (_count < 1) exitWith {};

private _centerPos = +_flyoverPos;
_centerPos set [2, _altitude];

private _dirVec = [sin _heading, cos _heading, 0];
private _startPos = _centerPos vectorAdd (_dirVec vectorMultiply -_spawnDistance);
private _endPos = _centerPos vectorAdd (_dirVec vectorMultiply _despawnDistance);

private _planes = [];

private _offsets = [
    _formation,
    _count,
    _spacing,
    _randX,
    _randY,
    _randZ
] call JM_ZeusModules_fnc_getFlyoverOffsets;

{
    _x params ["_offX", "_offY", "_offZ"];

    private _worldOffset = [
        (_offX * cos _heading) + (_offY * sin _heading),
        (-_offX * sin _heading) + (_offY * cos _heading),
        _offZ
    ];

    private _spawnPos = _startPos vectorAdd _worldOffset;
    private _wpPos = _spawnPos vectorAdd (_dirVec vectorMultiply 12000);

    private _spawned = [_spawnPos, _heading, _planeClass, _side] call BIS_fnc_spawnVehicle;
    _spawned params ["_plane", "_crew", "_group"];

    _plane limitSpeed (_speedMS * 3.6);
    _plane flyInHeight _altitude;
    _plane setPos _spawnPos;
    _plane setVelocityModelSpace [0, _speedMS, 0];
    _plane setVectorDirAndUp [_dirVec, [0, 0, 1]];
    _plane engineOn true;

    {
        _x disableAI "AUTOCOMBAT";
        _x disableAI "TARGET";
        _x disableAI "AUTOTARGET";
        _x disableAI "SUPPRESSION";
        _x setBehaviour "CARELESS";
        _x setCombatMode "BLUE";
        _x allowFleeing 0;
    } forEach _crew;

    private _wp = _group addWaypoint [_wpPos, 0];
    _wp setWaypointType "MOVE";
    _wp setWaypointBehaviour "CARELESS";
    _wp setWaypointForceBehaviour true;

    _planes pushBack _plane;
} forEach _offsets;

/*
    Store formation instance:
    [
        _planes,
        _speedMS,
        _heading,
        _endPos
    ]
*/
if (isNil "JM_flyover_formations") then {
    JM_flyover_formations = [];
};

JM_flyover_formations pushBack [
    _planes,
    _speedMS,
    _heading,
    _endPos
];

/*
    Global controller for all active flyovers.
*/
if (isNil "JM_flyover_eachFrame") then {
    JM_flyover_eachFrame = addMissionEventHandler ["EachFrame", {
        private _remainingFormations = [];

        {
            _x params ["_planes", "_speedMS", "_heading", "_endPos"];

            {
                if (isNull _x) then { continue };
                if (!alive _x) then { continue };

                [_x, true] remoteExecCall ["engineOn", _x];
                [_x, [0, _speedMS, 0]] remoteExecCall ["setVelocityModelSpace", _x];
                [_x, [[sin _heading, cos _heading, 0], [0, 0, 1]]] remoteExecCall ["setVectorDirAndUp", _x];
            } forEach _planes;

            private _lead = objNull;
            {
                if (!isNull _x && {alive _x}) exitWith {
                    _lead = _x;
                };
            } forEach _planes;

            if (isNull _lead) then {
                continue;
            };

            if ((_lead distance2D _endPos) < 300) then {
                {
                    if (!isNull _x && {alive _x}) then {
                        { deleteVehicle _x } forEach crew _x;
                        deleteVehicle _x;
                    };
                } forEach _planes;
            } else {
                _remainingFormations pushBack _x;
            };
        } forEach JM_flyover_formations;

        JM_flyover_formations = _remainingFormations;

        if (JM_flyover_formations isEqualTo []) then {
            removeMissionEventHandler ["EachFrame", JM_flyover_eachFrame];
            JM_flyover_eachFrame = nil;
        };
    }];
};