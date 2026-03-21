/*
    JM_JTAC_fnc_onDialogLoad
    Called from dialog onLoad.
*/
params ["_disp"];
if (isNull _disp) exitWith {};

uiNamespace setVariable ["JM_JTAC_display", _disp];

// ---- Grab controls (replace these IDCs)
private _ctrlList      = _disp displayCtrl 1500;              // listbox
private _ctrlIngress   = _disp displayCtrl 2100;  // optional
private _ctrlGridEdit  = _disp displayCtrl 1502;      // optional
private _ctrlTargetTxt = _disp displayCtrl IDC_JTAC_TARGET_TEXT;    // optional
private _btnTransmit   = _disp displayCtrl 1503;
private _btnCancel     = _disp displayCtrl 1504;
private _btnPickTarget = _disp displayCtrl 1602; // “Map” button

// --- Set themed background
private _ctrlBG = _disp displayCtrl 1200;

private _theme = toLower (missionNamespace getVariable ["JM_JTAC_theme", "modern"]);

private _bgPath = switch (_theme) do {
    case "ww2": {
        "JM_Framework\JTAC\ui\bg_ww2_ca.paa"
    };
    case "scifi": {
        "JM_Framework\JTAC\ui\bg_scifi_ca.paa"
    };
    case "modern": {
        "JM_Framework\JTAC\ui\bg_modern_ca.paa"
    };
    default {
        "JM_Framework\JTAC\ui\bg_modern_ca.paa"
    };
};

_ctrlBG ctrlSetText _bgPath;

// ---- Populate list from EPDJtacAvailableAttacks
private _attacks = missionNamespace getVariable ["EPDJtacAvailableAttacks", []];
lbClear _ctrlList;

{
    _x params ["_cat", "_name", "_acq", "_cap", "_method", "_params"];

    private _row = _ctrlList lbAdd _name;
    // store EPD index in row data
    _ctrlList lbSetData [_row, str _forEachIndex];
    // optional: store category/method in tooltip
    _ctrlList lbSetTooltip [_row, format ["%1 | %2", _cat, _method]];
} forEach _attacks;

// ---- Restore selection
private _savedIdx = uiNamespace getVariable ["JM_JTAC_selectedIndex", 0];
_savedIdx = _savedIdx max 0;
if ((lbSize _ctrlList) > 0) then {
    _savedIdx = _savedIdx min ((lbSize _ctrlList) - 1);
    _ctrlList lbSetCurSel _savedIdx;
};

// Keep selection in state whenever list changes
_ctrlList ctrlAddEventHandler ["LBSelChanged", {
    params ["_ctrl", "_newIndex"];
    uiNamespace setVariable ["JM_JTAC_selectedIndex", _newIndex];
}];

// ---- Ingress dropdown (optional)
if (!isNull _ctrlIngress) then {
    // Populate once if empty
    if ((lbSize _ctrlIngress) == 0) then {
        {
            _ctrlIngress lbAdd _x;
        } forEach ["RANDOM","N","NE","E","SE","S","SW","W","NW"];
    };

    private _savedIngress = uiNamespace getVariable ["JM_JTAC_ingressChoice", "RANDOM"];
    private _found = ["RANDOM","N","NE","E","SE","S","SW","W","NW"] find (toUpper _savedIngress);
    if (_found < 0) then { _found = 0; };
    _ctrlIngress lbSetCurSel _found;

    _ctrlIngress ctrlAddEventHandler ["LBSelChanged", {
        params ["_ctrl", "_idx"];
        uiNamespace setVariable ["JM_JTAC_ingressChoice", toUpper (_ctrl lbText _idx)];
    }];
};

// ---- Restore target display
private _t = uiNamespace getVariable ["JM_JTAC_targetASL", []];
if !(_t isEqualTo []) then {
    private _grid = mapGridPosition (ASLtoATL _t);
    if (!isNull _ctrlTargetTxt) then { _ctrlTargetTxt ctrlSetText format ["Target: %1", _grid]; };
    if (!isNull _ctrlGridEdit) then { _ctrlGridEdit ctrlSetText _grid; };
} else {
    if (!isNull _ctrlTargetTxt) then { _ctrlTargetTxt ctrlSetText "Target: (none)"; };
};



