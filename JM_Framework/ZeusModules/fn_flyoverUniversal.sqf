/*
    JM_ZeusModules_fnc_flyoverUniversal

    A kinematic flyover that does not rely on the vehicle flight model cooperating.
    Intended as a second, separate variant from your current velocity-based flyover.

    Params:
        0: ARRAY   - flyover position
        1: STRING  - vehicle classname
        2: NUMBER  - vehicle count
        3: NUMBER  - heading
        4: NUMBER  - speed (m/s)
        5: NUMBER  - altitude ASL
        6: NUMBER  - spacing
        7: NUMBER  - spawn distance
        8: NUMBER  - despawn distance
        9: STRING  - formation type ("wedge", "line", "column", "scatter")
        10: NUMBER - random horizontal offset
        11: NUMBER - random depth offset
        12: NUMBER - random height offset
        13: SIDE   - crew/group side
        14: NUMBER - release damage threshold (0-1)
*/

if (!isServer) exitWith {};

params [
    ["_flyoverPos", [0, 0, 0], [[]]],
    ["_vehicleClass", "", [""]],
    ["_count", 5, [0]],
    ["_heading", 90, [0]],
    ["_speedMS", 55.5, [0]],
    ["_altitudeASL", 350, [0]],
    ["_spacing", 60, [0]],
    ["_spawnDistance", 4000, [0]],
    ["_despawnDistance", 4000, [0]],
    ["_formation", "wedge", [""]],
    ["_randX", 0, [0]],
    ["_randY", 0, [0]],
    ["_randZ", 0, [0]],
    ["_side", independent, [west]],
    ["_releaseDamage", 0.8, [0]]
];

if (_vehicleClass isEqualTo "") exitWith {};
if (_count < 1) exitWith {};

private _centerASL = AGLToASL _flyoverPos;
_centerASL set [2, _altitudeASL];

private _dirVec = [sin _heading, cos _heading, 0];
private _startASL = _centerASL vectorAdd (_dirVec vectorMultiply -_spawnDistance);
private _endDistance = _spawnDistance + _despawnDistance;

private _offsets = [
    _formation,
    _count,
    _spacing,
    _randX,
    _randY,
    _randZ
] call JM_ZeusModules_fnc_getFlyoverOffsets;

private _vehicles = [];
private _released = [];

{
    _x params ["_offX", "_offY", "_offZ"];

    private _worldOffset = [
        (_offX * cos _heading) + (_offY * sin _heading),
        (-_offX * sin _heading) + (_offY * cos _heading),
        _offZ
    ];

    private _spawnASL = _startASL vectorAdd _worldOffset;
    private _spawnATL = ASLToAGL _spawnASL;
    private _wpPosATL = ASLToAGL (_spawnASL vectorAdd (_dirVec vectorMultiply 12000));

    private _spawned = [_spawnATL, _heading, _vehicleClass, _side] call BIS_fnc_spawnVehicle;
    _spawned params ["_veh", "_crew", "_group"];

    _veh setPosASL _spawnASL;
    _veh setVectorDirAndUp [_dirVec, [0, 0, 1]];
    _veh setVelocity [0, 0, 0];
    _veh engineOn true;

    {
        _x disableAI "AUTOCOMBAT";
        _x disableAI "TARGET";
        _x disableAI "AUTOTARGET";
        _x disableAI "SUPPRESSION";
        _x setBehaviour "CARELESS";
        _x setCombatMode "BLUE";
        _x allowFleeing 0;
    } forEach _crew;

    // Keep a distant waypoint as a fallback for anything that gets released
    private _wp = _group addWaypoint [_wpPosATL, 0];
    _wp setWaypointType "MOVE";
    _wp setWaypointBehaviour "CARELESS";
    _wp setWaypointForceBehaviour true;

    _vehicles pushBack _veh;
    _released pushBack false;
} forEach _offsets;

/*
    Formation state:
    [
        0: ARRAY  vehicles
        1: ARRAY  released flags
        2: ARRAY  start ASL
        3: ARRAY  dirVec
        4: NUMBER heading
        5: NUMBER speedMS
        6: NUMBER distanceTravelled
        7: ARRAY  offsets
        8: NUMBER endDistance
        9: NUMBER releaseDamage
    ]
*/
if (isNil "JM_flyoverUniversal_formations") then {
    JM_flyoverUniversal_formations = [];
};

JM_flyoverUniversal_formations pushBack [
    _vehicles,
    _released,
    _startASL,
    _dirVec,
    _heading,
    _speedMS,
    0,
    _offsets,
    _endDistance,
    _releaseDamage
];

if (isNil "JM_flyoverUniversal_eachFrame") then {
    JM_flyoverUniversal_lastTick = diag_tickTime;

    JM_flyoverUniversal_eachFrame = addMissionEventHandler ["EachFrame", {
        private _now = diag_tickTime;
        private _dt = _now - JM_flyoverUniversal_lastTick;
        JM_flyoverUniversal_lastTick = _now;

        if (_dt <= 0) exitWith {};

        private _remaining = [];

        {
            _x params [
                "_vehicles",
                "_released",
                "_startASL",
                "_dirVec",
                "_heading",
                "_speedMS",
                "_distanceTravelled",
                "_offsets",
                "_endDistance",
                "_releaseDamage"
            ];

            _distanceTravelled = _distanceTravelled + (_speedMS * _dt);

            {
                private _veh = _vehicles # _forEachIndex;
                if (isNull _veh) then { continue };
                if (!alive _veh) then { continue };

                private _isReleased = _released # _forEachIndex;

                // Release once damaged enough
                if (!_isReleased && {damage _veh >= _releaseDamage}) then {
                    _released set [_forEachIndex, true];
                    _veh engineOn true;
                    _veh setVelocity (_dirVec vectorMultiply _speedMS);
                    continue;
                };

                if (_isReleased) then {
                    continue;
                };

                private _localOffset = _offsets # _forEachIndex;
                _localOffset params ["_offX", "_offY", "_offZ"];

                private _worldOffset = [
                    (_offX * cos _heading) + (_offY * sin _heading),
                    (-_offX * sin _heading) + (_offY * cos _heading),
                    _offZ
                ];

                private _formationCenterASL = _startASL vectorAdd (_dirVec vectorMultiply _distanceTravelled);
                private _targetASL = _formationCenterASL vectorAdd _worldOffset;

                _veh setPosASL _targetASL;
                _veh setVectorDirAndUp [_dirVec, [0, 0, 1]];
                _veh setVelocity [0, 0, 0];
            } forEach _offsets;

            if (_distanceTravelled < _endDistance) then {
                _remaining pushBack [
                    _vehicles,
                    _released,
                    _startASL,
                    _dirVec,
                    _heading,
                    _speedMS,
                    _distanceTravelled,
                    _offsets,
                    _endDistance,
                    _releaseDamage
                ];
            } else {
                {
                    private _veh = _vehicles # _forEachIndex;
                    if (isNull _veh) then { continue };

                    // Only clean up unreleased survivors.
                    // Released ones are left alone to crash / fly on naturally.
                    if (!(_released # _forEachIndex) && {alive _veh}) then {
                        { deleteVehicle _x } forEach crew _veh;
                        deleteVehicle _veh;
                    };
                } forEach _vehicles;
            };
        } forEach JM_flyoverUniversal_formations;

        JM_flyoverUniversal_formations = _remaining;

        if (JM_flyoverUniversal_formations isEqualTo []) then {
            removeMissionEventHandler ["EachFrame", JM_flyoverUniversal_eachFrame];
            JM_flyoverUniversal_eachFrame = nil;
            JM_flyoverUniversal_lastTick = nil;
        };
    }];
};