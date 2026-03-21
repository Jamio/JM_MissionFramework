/*
  JM_JTAC_fnc_epd_compile
  Compile EPD scripts so STRAFING_RUN_ROCKET etc exist.
  Call on server AND clients.
*/
if !(missionNamespace getVariable ["JM_JTAC", false]) exitWith {};

call compile preprocessFileLineNumbers "JM_Framework\JTAC\EPD\VirtualJTAC\init.sqf";
