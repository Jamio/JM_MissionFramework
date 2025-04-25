
// call with: [] call JM_Misc_fnc_showDebriefDialog

disableSerialization;
createDialog "JM_DebriefDialog";
waitUntil { !isNull findDisplay 9000 };

private _disp = findDisplay 9000;

// Load screen image from mission config
private _loadImage = getText (missionConfigFile >> "loadScreen");
(_disp displayCtrl 9001) ctrlSetText _loadImage;

// Set mission title from description.ext
private _missionName = getText (missionConfigFile >> "onLoadName");
(_disp displayCtrl 9002) ctrlSetStructuredText parseText format [
    "<t align='center' size='2'><t font='PuristaSemiBold'>%1</t></t>",
    _missionName
];


private _disp = findDisplay 9000;
private _ctrlHeader = _disp displayCtrl 9007;

_ctrlHeader ctrlSetStructuredText parseText "
<t size='4' align='center' shadow='1' color='#FFDD33'>
    <t font='PuristaSemiBold'>MISSION COMPLETE</t><br/>
</t>
";


private _rawDebrief = if (!isNil "JM_CustomDebriefText") then {
    JM_CustomDebriefText
} else {
    "Congratulations - you completed the mission.";
};

// Wrap it in visual formatting
private _debriefFormatted = parseText format [
    "<t align='left' size='0.95' font='PuristaMedium'>%1</t>",
    _rawDebrief
];

(_disp displayCtrl 9003) ctrlSetStructuredText _debriefFormatted;


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

    private _durationText = format [
    "<t align='left'><t font='PuristaBold' size='1.5'>Mission Duration:</t> <t font='PuristaMedium' size='1.5'>%1</t></t>",
    _timeString
];




(_disp displayCtrl 1105) ctrlSetStructuredText parseText _durationText;



// ************************************* THIS BIT WILL SORT OUT PERSONAL STATS FORM JM_STATS!

private _uid = getPlayerUID player;
private _name = name player;

// Handy formatters
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

// === PERSONAL STATS ===
private _stats = JM_Stats getOrDefault [_uid, createHashMap];
private _kills = _stats getOrDefault ["kills", 0];
private _deaths = _stats getOrDefault ["deaths", 0];
private _longestKill = _stats getOrDefault ["longestKill", 0];
private _longestWeapon = _stats getOrDefault ["longestKillWeapon", "Unknown"];
private _footDist = JM_DistanceFoot getOrDefault [_uid, 0];
private _vehDist = JM_DistanceVehicle getOrDefault [_uid, 0];
private _vehTime = JM_TimeInVehicle getOrDefault [_uid, 0];

private _personalText = format [
    "<t align='left'>" +
    "<t size='1.25' font='PuristaBold' color='#FFDD33'>%1's Statistics:</t><br/><br/>" +
    "<t font='PuristaBold'>Kills:</t> <t font='PuristaMedium'>%2</t><br/>" +
    "<t font='PuristaBold'>Deaths:</t> <t font='PuristaMedium'>%3</t><br/>" +
    "<t font='PuristaBold'>Longest Kill:</t> <t font='PuristaMedium'>%4m (%5)</t><br/><br/>" +
    "<t font='PuristaBold'>Distance Travelled (Foot):</t> <t font='PuristaMedium'>%6</t><br/>" +
    "<t font='PuristaBold'>Distance Travelled (Vehicle):</t> <t font='PuristaMedium'>%7</t><br/>" +
    "<t font='PuristaBold'>Time in Vehicles:</t> <t font='PuristaMedium'>%8</t>" +
    "</t>",
    _name,
    _kills,
    _deaths,
    round _longestKill, _longestWeapon,
    [_footDist] call _formatDistance,
    [_vehDist] call _formatDistance,
    [_vehTime] call _formatTime
];

(_disp displayCtrl 9005) ctrlSetStructuredText parseText _personalText;



// === TEAM STATS ===
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

    private _stats = JM_Stats getOrDefault [_uid, createHashMap];
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

    private _killDist = _stats getOrDefault ["longestKill", 0];
    if (_killDist > _longestKill) then {
        _longestKill = _killDist;
        _longestKiller = _name;
        _longestWeapon = _stats getOrDefault ["longestKillWeapon", "Unknown"];
    };

    private _foot = JM_DistanceFoot getOrDefault [_uid, 0];
    if (_foot > _topFoot) then {
        _topFoot = _foot;
        _topFootName = _name;
    };

    private _veh = JM_DistanceVehicle getOrDefault [_uid, 0];
    if (_veh > _topVeh) then {
        _topVeh = _veh;
        _topVehName = _name;
    };

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

private _teamText = format [
    "<t align='left'>" +
    "<t size='1.25' font='PuristaBold' color='#FFDD33'>Team Summary:</t><br/><br/>" +
    "<t font='PuristaBold'>Total Kills:</t> <t font='PuristaMedium'>%1</t><br/>" +
    "<t font='PuristaBold'>Total Deaths:</t> <t font='PuristaMedium'>%2</t><br/><br/>" +
    "<t font='PuristaBold'>Top Killer:</t> <t font='PuristaMedium'>%3 (%4)</t><br/>" +
    "<t font='PuristaBold'>Most Deaths:</t> <t font='PuristaMedium'>%5 (%6)</t><br/><br/>" +
    "<t font='PuristaBold'>Longest Kill:</t> <t font='PuristaMedium'>%7m by %8 with %9</t><br/><br/>" +
    "<t font='PuristaBold'>Most Distance (Foot):</t> <t font='PuristaMedium'>%10 (%11)</t><br/>" +
    "<t font='PuristaBold'>Most Distance (Vehicle):</t> <t font='PuristaMedium'>%12 (%13)</t><br/>" +
    "<t font='PuristaBold'>Most Time in Vehicle:</t> <t font='PuristaMedium'>%14 (%15)</t>" +
    "</t>",
    JM_TotalKills,
    JM_TotalDeaths,
    _topKiller, _mostKills,
    _topDeath, _mostDeaths,
    round _longestKill, _longestKiller, _longestWeapon,
    _topFootName, [_topFoot] call _formatDistance,
    _topVehName, [_topVeh] call _formatDistance,
    _topVehTimeName, [_topVehTime] call _formatTime
];

(_disp displayCtrl 9006) ctrlSetStructuredText parseText _teamText;







