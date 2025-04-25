if (isServer) then {
    JM_TotalKills = 0;
    JM_TotalDeaths = 0;
    JM_Stats = createHashMap;

    publicVariable "JM_TotalKills";
    publicVariable "JM_TotalDeaths";

	addMissionEventHandler ["EntityKilled", {
		params ["_unit", "_killer", "_instigator", "_useEffects"];

		// Track player death
		if (isPlayer _unit) then {
			JM_TotalDeaths = JM_TotalDeaths + 1;
			publicVariable "JM_TotalDeaths";

			private _uid = getPlayerUID _unit;
			private _stats = JM_Stats getOrDefault [_uid, createHashMap];
			private _deaths = _stats getOrDefault ["deaths", 0];
			_stats set ["deaths", _deaths + 1];
			JM_Stats set [_uid, _stats];
		};

		// Track player kill
		if (!isNull _killer && {isPlayer _killer} && {_killer != _unit}) then {
			JM_TotalKills = JM_TotalKills + 1;
			publicVariable "JM_TotalKills";

			private _uid = getPlayerUID _killer;
			private _stats = JM_Stats getOrDefault [_uid, createHashMap];
			private _kills = _stats getOrDefault ["kills", 0];
			_stats set ["kills", _kills + 1];

			// Longest kill tracking
			private _distance = _killer distance _unit;
			private _currentLongest = _stats getOrDefault ["longestKill", 0];
			if (_distance > _currentLongest) then {
				_stats set ["longestKill", _distance];

				private _weaponClass = primaryWeapon _killer;
				private _weaponName = getText (configFile >> "CfgWeapons" >> _weaponClass >> "displayName");
				_stats set ["longestKillWeapon", _weaponName];
			};


			JM_Stats set [_uid, _stats];
		};
	}];

};

// New maps
JM_LastPositions = createHashMap;
JM_DistanceFoot = createHashMap;
JM_DistanceVehicle = createHashMap;
JM_TimeInVehicle = createHashMap;

[] spawn {
    while {true} do {
        {
            private _uid = getPlayerUID _x;
            if (_uid isEqualTo "") then { continue };

            private _lastPos = JM_LastPositions getOrDefault [_uid, getPosASL _x];
            private _newPos = getPosASL _x;
            private _dist = _newPos distance2D _lastPos;

            private _isInVehicle = vehicle _x != _x;

            if (_isInVehicle) then {
                private _vehDist = JM_DistanceVehicle getOrDefault [_uid, 0];
                JM_DistanceVehicle set [_uid, _vehDist + _dist];

                private _vehTime = JM_TimeInVehicle getOrDefault [_uid, 0];
                JM_TimeInVehicle set [_uid, _vehTime + 10]; // 10s per loop
            } else {
                private _footDist = JM_DistanceFoot getOrDefault [_uid, 0];
                JM_DistanceFoot set [_uid, _footDist + _dist];
            };

            JM_LastPositions set [_uid, _newPos];
        } forEach allPlayers;

        sleep 10; // Slow and safe
    };
};
