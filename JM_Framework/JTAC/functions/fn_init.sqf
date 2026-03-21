/*
  JM_JTAC_fnc_init
  Must run on server and all clients (dialog needs the list).
*/
if !(missionNamespace getVariable ["JM_JTAC", false]) exitWith {};

[] call JM_JTAC_fnc_epd_compile;

private _useDefaults = missionNamespace getVariable ["JM_JTAC_UseEPDDefaults", false];
private _base = [];
if (_useDefaults) then {
  _base = missionNamespace getVariable ["EPDJtacAvailableAttacks", []];
};

private _jm = [] call JM_JTAC_fnc_epd_buildAttacksFromJM;

// overwrite / set the list used by your dialog + server calls
missionNamespace setVariable ["EPDJtacAvailableAttacks", _base + _jm, true];
