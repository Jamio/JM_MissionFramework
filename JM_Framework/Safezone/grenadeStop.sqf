/*
   GrenadeStop v0.8 for ArmA 3 Alpha by Bake (tweaked slightly by Rarek)

   DESCRIPTION:
   Stops players from throwing grenades in safety zones.

   INSTALLATION:
   Move grenadeStop.sqf to your mission's folder. Then add the
   following line to your init.sqf file (create one if necessary):
   execVM "grenadeStop.sqf";

   CONFIGURATION:
   Edit the #defines below.
*/

if !(JM_Safezone) exitWith {systemChat "[JM SAFEZONES] is not active";};

if (isDedicated) exitWith {};
waitUntil {!isNull player};

player addEventHandler ["Fired", {
   if ({(_this select 0) distance getMarkerPos (_x select 0) < _x select 1} count JM_safeZones > 0) then
   {
       deleteVehicle (_this select 6);
       titleText [JM_safeMsg, "PLAIN", 3];
   };
}];

systemChat "[JM SAFEZONES] is active";
