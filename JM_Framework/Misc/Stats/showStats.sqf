[] spawn {
    sleep 1;

    if (!isServer) exitWith {};

    private _missionTime = time;
    private _hours = floor (_missionTime / 3600);
    private _minutes = floor ((_missionTime % 3600) / 60);
    private _seconds = round (_missionTime % 60);

    private _pad = {
        params ["_n"];
        if (_n < 10) then { format ["0%1", _n] } else { str _n };
    };

    private _timeString = format [
        "%1:%2:%3",
        _hours call _pad,
        _minutes call _pad,
        _seconds call _pad
    ];

	private _formatDistance = {
    params ["_meters"];
    if (_meters >= 1000) then {
        format ["%1km", (_meters / 1000) toFixed 2]
    } else {
        format ["%1m", round _meters]
    };
	};

	private _formatTime = {
    params ["_seconds"];
    private _mins = floor (_seconds / 60);
    private _secs = _seconds mod 60;

    if (_mins > 0) then {
        format ["%1m %2s", _mins, _secs]
    } else {
        format ["%1s", _secs]
    };
	};

    // Set up tracking
    private _topKiller = "";
    private _mostKills = -1;

    private _topDeath = "";
    private _mostDeaths = -1;

    private _longestKill = 0;
    private _longestKiller = "";
    private _longestWeapon = "";

    private _topFoot = 0;
    private _topFootName = "";

    private _topVeh = 0;
    private _topVehName = "";

    private _topVehTime = 0;
    private _topVehTimeName = "";

    {
        private _unit = _x;
        private _uid = getPlayerUID _unit;
        private _name = name _unit;

        // Get stats hashMap if it exists
        private _stats = JM_Stats getOrDefault [_uid, createHashMap];

        // Kills / Deaths
        private _kills = _stats getOrDefault ["kills", 0];
        private _deaths = _stats getOrDefault ["deaths", 0];

        if (_kills > _mostKills) then {
            _mostKills = _kills;
            _topKiller = _name;
        };

        if (_deaths > _mostDeaths) then {
            _mostDeaths = _deaths;
            _topDeath = _name;
        };

        // Longest kill
        private _killDist = _stats getOrDefault ["longestKill", 0];
        if (_killDist > _longestKill) then {
            _longestKill = _killDist;
            _longestKiller = _name;
            _longestWeapon = _stats getOrDefault ["longestKillWeapon", "Unknown"];
        };

        // Distance on foot
        private _foot = JM_DistanceFoot getOrDefault [_uid, 0];
        if (_foot > _topFoot) then {
            _topFoot = _foot;
            _topFootName = _name;
        };

        // Distance in vehicle
        private _veh = JM_DistanceVehicle getOrDefault [_uid, 0];
        if (_veh > _topVeh) then {
            _topVeh = _veh;
            _topVehName = _name;
        };

        // Time in vehicle
        private _vehTime = JM_TimeInVehicle getOrDefault [_uid, 0];
        if (_vehTime > _topVehTime) then {
            _topVehTime = _vehTime;
            _topVehTimeName = _name;
        };

    } forEach allPlayers;

    // Fallbacks
    if (_mostKills == -1) then {_topKiller = "N/A"; _mostKills = 0};
    if (_mostDeaths == -1) then {_topDeath = "N/A"; _mostDeaths = 0};
    if (_longestKill == 0) then {_longestKiller = "N/A"; _longestWeapon = "N/A"};

    // Format final message
    private _msg = format [
        "=== Mission Stats ===\n\n" +
        "Mission Duration: %1\n\n" +
        "Team Kills: %2\n" +
        "Team Deaths: %3\n\n" +
        "Top Killer: %4 (%5 kills)\n" +
        "Most Deaths: %6 (%7 deaths)\n" +
        "Longest Kill: %8m by %9 with %10\n\n" +
        "Most Distance on Foot: %11 (%12)\n" +
        "Most Distance in Vehicle: %13 (%14)\n" +
        "Most Time in Vehicle: %15 (%16)",
        _timeString,
        JM_TotalKills,
        JM_TotalDeaths,
        _topKiller, _mostKills,
        _topDeath, _mostDeaths,
        round _longestKill, _longestKiller, _longestWeapon,
    	_topFootName, [_topFoot] call _formatDistance,
    	_topVehName, [_topVeh] call _formatDistance,
    	_topVehTimeName, [_topVehTime] call _formatTime
    ];

    [_msg] remoteExec ["hint", 0];
};
