/*
    JM_JTAC_fnc_removeLocalActions
    Removes the JTAC ACE action from the local player.
*/
if (!hasInterface) exitWith {};
if (isNull player) exitWith {};

if !(player getVariable ["JM_JTAC_actionAdded", false]) exitWith {};

[player, 1, ["ACE_SelfActions", "JM_JTAC_Open"]] call ace_interact_menu_fnc_removeActionFromObject;

player setVariable ["JM_JTAC_actionAdded", false];
player setVariable ["JM_JTAC_actionPath", nil];

