/*
 * Author: jamio
 * Adds the ACE self-action for toggling HUD.
 *
 * Locality:
 * - CLIENT ONLY
 */

if (!hasInterface) exitWith {};

_action = [
    "JM_hideui_toggleScreenshotHud",
    "Toggle Screenshot HUD",
    "",
    {
        private _hidden = [] call JM_hideui_fnc_toggleHud;
        systemChat format [
            ["HUD restored", "HUD hidden"] select _hidden
        ];
    },
    {
        alive ACE_player
    }
] call ace_interact_menu_fnc_createAction;

// Add under ACE self actions for all men.
// Inheritance true so all infantry/player classes get it.
["CAManBase", 1, ["ACE_SelfActions"], _action, true] call ace_interact_menu_fnc_addActionToClass;