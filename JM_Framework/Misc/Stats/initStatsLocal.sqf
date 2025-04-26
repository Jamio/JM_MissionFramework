// ============================
// JM_Framework\Misc\Stats\initStatsLocal.sqf
// (Client-side Distance Tracking)
// ============================

if (!hasInterface) exitWith {};

waitUntil {!isNull player};

// Initialize Local Stats if not present
if (isNil "JM_LastPositions") then { JM_LastPositions = createHashMap; };
if (isNil "JM_DistanceFoot") then { JM_DistanceFoot = createHashMap; };
if (isNil "JM_DistanceVehicle") then { JM_DistanceVehicle = createHashMap; };
if (isNil "JM_TimeInVehicle") then { JM_TimeInVehicle = createHashMap; };

private _uid = getPlayerUID player;
private _lastPos = getPosASL player;

[] spawn {
    waitUntil {!(isNull player) && {alive player} && {getPosASL player select 0 != 0 || getPosASL player select 1 != 0}}; 
    // Wait until the player exists and position is initialized

    private _uid = getPlayerUID player;
    if (_uid isEqualTo "") exitWith {}; // Extra safety

    JM_LastPositions set [_uid, getPosASL player]; // Properly set first position

    while {true} do {
        private _lastPos = JM_LastPositions getOrDefault [_uid, []];

        if (_lastPos isEqualTo []) then {
            _lastPos = getPosASL player;
            JM_LastPositions set [_uid, _lastPos];
        };

        private _newPos = getPosASL player;
        private _dist = _newPos distance2D _lastPos;

        private _isInVehicle = vehicle player != player;

        if (_isInVehicle) then {
            private _vehDist = JM_DistanceVehicle getOrDefault [_uid, 0];
            JM_DistanceVehicle set [_uid, _vehDist + _dist];

            private _vehTime = JM_TimeInVehicle getOrDefault [_uid, 0];
            JM_TimeInVehicle set [_uid, _vehTime + 10];
        } else {
            private _footDist = JM_DistanceFoot getOrDefault [_uid, 0];
            JM_DistanceFoot set [_uid, _footDist + _dist];
        };

        JM_LastPositions set [_uid, _newPos];

        sleep 10;
    };
};

