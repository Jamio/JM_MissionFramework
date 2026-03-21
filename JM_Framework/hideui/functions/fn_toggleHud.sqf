/*
 * Author: jamio
 * Toggles screenshot HUD mode for the local client.
 *
 * Locality:
 * - CLIENT ONLY
 * - Do not remoteExec this globally, HUD/UI is local.
 *
 * Arguments:
 * 0: Force state <BOOL, optional>
 *
 * Return:
 * <BOOL> New hidden-state
 */

params [["_forceState", objNull, [false, objNull]]];

private _prefix = "JM_hideui__screenshot_";
private _stateVar = _prefix + "hidden";
private _duiToggleVar = "diwako_dui_main_toggled_off";

// Format: [variableName, hiddenValue, restoreInitValue(optional)]
if (isNil "JM_hideui_screenshotHudValues") then {
    JM_hideui_screenshotHudValues = [
        ["showHUD", [false, false, false, false, false, false, false, false, false, false, false], shownHUD],
        ["diwako_dui_compass_style", ["", "", ""]],
        ["diwako_dui_compass_opacity", 0],
        ["diwako_dui_enable_compass_dir", 0],
        ["diwako_dui_nametags_enabled", false],
        ["diwako_dui_namelist", false]
    ];
};

private _setValue = {
    params ["_name", "_value"];

    if (_name isEqualTo "showHUD") then {
        showHUD _value;
    } else {
        missionNamespace setVariable [_name, _value];
    };
};

private _isHidden = missionNamespace getVariable [_stateVar, false];
private _hideHud = if (_forceState isEqualType false) then {_forceState} else {!_isHidden};

if (_hideHud) then {
    {
        _x params ["_varName", "_hiddenValue", ["_restoreValue", nil]];

        private _currentValue = if (!isNil "_restoreValue") then {
            _restoreValue
        } else {
            missionNamespace getVariable [_varName, nil]
        };

        missionNamespace setVariable [format ["%1saved_%2", _prefix, _varName], _currentValue];
        [_varName, _hiddenValue] call _setValue;
    } forEach JM_hideui_screenshotHudValues;

    // Save current DUI master toggle state, then force DUI off
    private _currentDuiToggle = missionNamespace getVariable [_duiToggleVar, false];
    missionNamespace setVariable [format ["%1saved_%2", _prefix, _duiToggleVar], _currentDuiToggle];
    missionNamespace setVariable [_duiToggleVar, true];

} else {
    {
        _x params ["_varName"];

        private _savedValue = missionNamespace getVariable [format ["%1saved_%2", _prefix, _varName], nil];
        if (!isNil "_savedValue") then {
            [_varName, _savedValue] call _setValue;
        };
    } forEach JM_hideui_screenshotHudValues;

    // Restore previous DUI master toggle state
    private _savedDuiToggle = missionNamespace getVariable [format ["%1saved_%2", _prefix, _duiToggleVar], nil];
    if (!isNil "_savedDuiToggle") then {
        missionNamespace setVariable [_duiToggleVar, _savedDuiToggle];
    };
};

missionNamespace setVariable [_stateVar, _hideHud];
_hideHud