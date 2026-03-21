/*
    cbrn_fnc_initFramework
*/

if !(missionNamespace getVariable ["JM_CBRN_enabled", false]) exitWith {};

[] call cbrn_fnc_applyCBRNSettings;
[] call cbrn_fnc_postInit;

if (isServer) then {
    [] call cbrn_fnc_createCBRNZones;
};