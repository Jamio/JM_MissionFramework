// ============================
// JM_Framework\Misc\Stats\initStats.sqf
// (Server-only Stat Tracking Initialization)
// ============================

if (!isServer) exitWith {};

// Initialize Global Stats Variables
JM_TotalKills = 0;
JM_TotalDeaths = 0;
JM_Stats = createHashMap;

// Broadcast so clients have initial values
publicVariable "JM_TotalKills";
publicVariable "JM_TotalDeaths";
publicVariable "JM_Stats";

// Server tracks kills/deaths only
addMissionEventHandler ["EntityKilled", {
    params ["_unit", "_killer", "_instigator", "_useEffects"];

    // Track player deaths
    if (isPlayer _unit) then {
        JM_TotalDeaths = JM_TotalDeaths + 1;
        publicVariable "JM_TotalDeaths";

        private _uid = getPlayerUID _unit;
        private _stats = JM_Stats getOrDefault [_uid, createHashMap];
        private _deaths = _stats getOrDefault ["deaths", 0];
        _stats set ["deaths", _deaths + 1];
        JM_Stats set [_uid, _stats];

        publicVariable "JM_Stats";
    };

    // Track player kills
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

            private _weaponName = "";

            if (vehicle _instigator == _instigator) then {
                // On foot, use primary weapon
                private _weapon = primaryWeapon _instigator;

                if (_weapon != "") then {
                    _weaponName = getText (configFile >> "CfgWeapons" >> _weaponClass >> "displayName");
                } else {
                    _weaponName = "Unknown Weapon";
                };
            } else {
                // In vehicle, use vehicle name
                _weaponName = getText (configFile >>  "CfgVehicles" >> typeOf (vehicle _instigator) >> "displayName");
            };

            _stats set ["longestKillWeapon", _weaponName];

    
        };

        JM_Stats set [_uid, _stats];
        publicVariable "JM_Stats";
    };
}];
