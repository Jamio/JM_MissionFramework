/*
  JM_JTAC_fnc_epd_fireServer
  Params: [caller, epdIndex, targetASL, incomingDir]
*/
if (!isServer) exitWith {};
params ["_caller", "_idx", "_targetASL", "_incomingDir"];

systemChat format ["[JM_JTAC] Received fire mission request from %1", name _caller];

private _list = missionNamespace getVariable ["EPDJtacAvailableAttacks", []];
private _meta = missionNamespace getVariable ["JM_JTAC_AttackMeta", []];
if (_idx < 0 || {_idx >= count _list} || {_idx >= count _meta}) exitWith {};

private _attack = _list select _idx;
private _m = _meta select _idx;

_attack params ["_category", "_name", "_acq", "_cap", "_methodName", "_params"];

private _id       = _m get "id";
private _cooldown = _m get "cooldown";
private _capacity = _m get "capacity";
private _delay    = _m get "delay";
private _eta      = _m get "eta";
private _flyClass = _m get "flyoverClass";

systemChat format ["[JM_JTAC] %1 requested fire mission: %2", name _caller, _name];



// --- Capacity (uses)
private _usesVar = format ["JM_JTAC_usesLeft_%1", _id];
private _usesLeft = missionNamespace getVariable [_usesVar, _capacity];
if (_capacity >= 0 && { _usesLeft <= 0 }) exitWith {
    ["No uses remaining for this fire mission."] remoteExecCall ["hint", owner _caller];
};

systemChat format ["[JM_JTAC] %1 uses left for mission %2", _usesLeft, _name];

// --- Cooldown
private _lastVar = format ["JM_JTAC_lastUsed_%1", _id];
private _last = missionNamespace getVariable [_lastVar, -1];
if (_cooldown > 0 && { _last >= 0 } && { (serverTime - _last) < _cooldown }) exitWith {
    private _rem = ceil (_cooldown - (serverTime - _last));
    [format ["Fire mission unavailable. Available for request in %1s.", _rem]] remoteExecCall ["hint", owner _caller];
};

systemChat format ["[JM_JTAC] Mission %1 cooldown check passed.", _name];

// --- Optional: EPD category reload gate as well
private _can = _category call CAN_PERFORM_FIRE_MISSION;
if (!_can) exitWith {
    ["Fire support unavailable (EPD reload)."] remoteExecCall ["systemChat", owner _caller];
};

systemChat format ["can call in fire mission %1", _can];

// --- Record now (so spam clicks don't queue multiple)
missionNamespace setVariable [_lastVar, serverTime, true];
if (_capacity >= 0) then {
    missionNamespace setVariable [_usesVar, (_usesLeft - 1) max 0, true];
};

// EPD record + timer (category system)
[_category, _cap] call RECORD_FIRE_MISSION;
0 = _category spawn START_RELOAD_TIMER;

// --- Local marker + formatted hint for JTAC caller only
private _targetATL = ASLtoATL _targetASL;
private _grid = mapGridPosition _targetATL;

[_targetATL, format ["%1 INBOUND", _name], (_delay + _eta + 30)] remoteExecCall ["JM_JTAC_fnc_localInboundMarker", owner _caller];

private _etaTotal = (_delay max 0) + (_eta max 0);

// uses left (after consuming)
private _usesLeftAfter = if (_capacity >= 0) then {
    (missionNamespace getVariable [_usesVar, 0])
} else { -1 };

// show hint
[_name, _grid, _etaTotal, false, _usesLeftAfter, _cooldown] remoteExecCall ["JM_JTAC_fnc_localInboundHint", owner _caller];


// --- Delay, then execute
[
    _caller, _methodName, _params, _targetASL, _incomingDir,
    _delay, _eta, _flyClass
] spawn {
    params ["_caller", "_methodName", "_params", "_targetASL", "_incomingDir", "_delay", "_eta", "_flyClass"];

    private _totalDelay = (_delay max 0) + (_eta max 0);
    if (_totalDelay > 0) then { uiSleep _totalDelay; };

    // Optional flyover (cosmetic) – start slightly before impact if possible
    if (_flyClass != "") then {
        // keep it simple: start flyby immediately before strike
        private _atl = ASLtoATL _targetASL;
        private _start = _atl getPos [1500, _incomingDir];
        private _end   = _atl getPos [1500, _incomingDir + 180];

        // BIS_fnc_ambientFlyby: [startPos, endPos, alt, speed, side, vehicleClass]
        // side can be any; this is cosmetic
        [_start, _end, selectRandom [200, 250, 350], "FULL", _flyClass, west] spawn BIS_fnc_ambientFlyby;
    };

    private _fn = missionNamespace getVariable [_methodName, {}];
    if (_fn isEqualTo {}) exitWith {
        systemChat format ["[JM_JTAC] Missing EPD method: %1", _methodName];
    };

    [_targetASL, _incomingDir, _params] spawn _fn;
};

