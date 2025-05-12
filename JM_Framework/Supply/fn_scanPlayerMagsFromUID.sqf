params ["_uid"];

if (!isServer) exitWith {systemChat "exited because was not server"};

private _unit = objNull;


{
    if (getPlayerUID _x == _uid) exitWith { _unit = _x };
} forEach allPlayers;

systemChat format ["[JM SUPPLY] UNIT UID: %1", _uid];

if (isNull _unit) exitWith {
    systemChat format ["[JM SUPPLY] Could not resolve UID to unit: %1", _uid];
};

[_unit] call JM_Supply_fnc_scanPlayerMags;