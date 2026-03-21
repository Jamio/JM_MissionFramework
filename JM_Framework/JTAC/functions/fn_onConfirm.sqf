/*
    JM_JTAC_fnc_onConfirm
*/
if (!hasInterface) exitWith {};

private _disp = uiNamespace getVariable ["JM_JTAC_display", displayNull];
if (isNull _disp) then { _disp = findDisplay 1234; };
if (isNull _disp) exitWith { hint "Dialog not found."; };

private _ctrlList = _disp displayCtrl 1500;
private _row = lbCurSel _ctrlList;
if (_row < 0) exitWith { hint "Select a fire mission."; };

// EPD index stored in lbData
private _epdIndex = parseNumber (_ctrlList lbData _row);

systemChat format ["JTAC selected EPD index: %1", _epdIndex];

// Target
private _targetASL = uiNamespace getVariable ["JM_JTAC_targetASL", []];
if (_targetASL isEqualTo []) exitWith {
    hint "No target selected. Click Pick Target.";
};

// Ingress dir
private _choice = uiNamespace getVariable ["JM_JTAC_ingressChoice", "RANDOM"];
private _incomingDir = [_choice] call JM_JTAC_fnc_dirFromChoice;

// Send to server
[player, _epdIndex, _targetASL, _incomingDir] remoteExecCall ["JM_JTAC_fnc_epd_fireServer", 2];

closeDialog 0;
