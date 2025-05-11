params ["_uid"];

systemChat format ["[SUPPLY] Server received UID: %1 | players known: %2", _uid, allPlayers];

if (!isServer) exitWith {systemChat "exited because was not server"};

private _unit = objNull;


{
    if (getPlayerUID _x == _uid) exitWith { _unit = _x };
} forEach allPlayers;

systemChat format ["[UID] UNIT UID: %1", _uid];

if (isNull _unit) exitWith {
    systemChat format ["[SUPPLY] Could not resolve UID to unit: %1", _uid];
};

[_unit] call JM_Supply_fnc_scanPlayerMags;