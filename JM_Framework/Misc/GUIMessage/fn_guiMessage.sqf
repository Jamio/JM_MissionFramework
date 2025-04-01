/*
  # File: fn_guiMessage.sqf
  # Function: JM_fnc_guiMessage
  # Author: LoboArdiente
*/

#define HORZ_LEFT ( safeZoneX )
#define HORZ_CENTER ( safeZoneX + ( safeZoneW / 2 ))
#define HORZ_RIGHT ( safeZoneX + safeZoneW )
#define VERT_TOP ( safeZoneY )
#define VERT_CENTER ( safeZoneY + ( safeZoneH / 2 ))
#define VERT_BOTTOM ( safeZoneY + safeZoneH )
#define w(NUM) ( safeZoneWAbs * NUM)
#define h(NUM) ( safeZoneH * NUM)

params[
	["_title", "", [""]],
	["_desc", "", [""]],
	["_color", [1,1,1,1], [[]]],
	["_blockInput", false, [false]],
	["_buttons", [], [[]]],
	["_timeout", 0, [0]],
	["_timeoutCodeInfo", [], [[]]]
];

disableSerialization;
private _display = (findDisplay 46) createDisplay 'RscDisplayEmpty';

private _haveButtons = _buttons isNotEqualTo [];
private _haveTimeout = _timeout > 0;

// Blur effect
"dynamicBlur" ppEffectEnable true;
"dynamicBlur" ppEffectAdjust [0];
"dynamicBlur" ppEffectCommit 0;
"dynamicBlur" ppEffectAdjust [2];
"dynamicBlur" ppEffectCommit 0.25;

// Block user input
if (_blockInput) then { _display displayAddEventHandler ['KeyDown', {true}] };

// Sounds comment them if u dont want to use them
playSoundUI ["border_in", 0.1, 1];
_display displayAddEventHandler ['Unload', {
	"dynamicBlur" ppEffectAdjust [0];
	"dynamicBlur" ppEffectCommit 0.25;
	playSoundUI ["border_out", 0.1, 1]
}];

private _background = _display ctrlCreate ["RscStructuredText", -1];
_background ctrlSetPosition [safeZoneXAbs,safeZoneY,safeZoneWAbs,safeZoneH];
_background ctrlSetBackgroundColor [0,0,0,0.75];
_background ctrlEnable false;
_background ctrlSetFade 1;
_background ctrlCommit 0;
_background ctrlSetFade 0;
_background ctrlCommit 0.5;

private _descCtrl = _display ctrlCreate ["RscStructuredText", -1];
_descCtrl ctrlSetStructuredText parseText format ["<t font='RobotoCondensedLight' color='#d9d9d9' size='1.3' align='center'>%1</t>", _desc];
_descCtrl ctrlSetPosition [0,0,0.8,2];
_descCtrl ctrlCommit 0;
private _posY = [VERT_CENTER - h(0.059), VERT_CENTER + h(0.009)] select (_title isNotEqualTo "");
_descCtrl ctrlSetPosition [
	HORZ_CENTER - (ctrlTextWidth _descCtrl) / 2,
	_posY,
	(ctrlTextWidth _descCtrl),
	(ctrlTextHeight _descCtrl)
];
_descCtrl ctrlSetFade 1;
_descCtrl ctrlCommit 0;
_descCtrl ctrlSetFade 0;
_descCtrl ctrlCommit 0.5;
(ctrlPosition _descCtrl) params ['_xDesc','_yDesc','_wDesc','_hDesc'];

uiNamespace setVariable ["lastBtnYPos", (_yDesc + _hDesc)];

if (_title isNotEqualTo "") then {
	private _titleCtrl = _display ctrlCreate ["RscStructuredText", -1];
	_titleCtrl ctrlSetStructuredText parseText format ["<t font='RobotoCondensedBold' size='2' align='center'>%1</t>", _title];
	_titleCtrl ctrlCommit 0;
	_titleCtrl ctrlSetPosition [
		HORZ_CENTER - (ctrlTextWidth _titleCtrl) / 2,
		_yDesc - h(0.059),
		(ctrlTextWidth _titleCtrl),
		h(0.06)
	];
	_titleCtrl ctrlEnable false;
	_titleCtrl ctrlSetFade 1;
	_titleCtrl ctrlCommit 0;
	_titleCtrl ctrlSetFade 0;
	_titleCtrl ctrlCommit 0.5;

	private _barra = _display ctrlCreate ["RscStructuredText", -1];
	_barra ctrlSetPosition [
		HORZ_CENTER - w(0.2) / 2,
		_yDesc - h(0.01),
		w(0.2),
		h(0.001)
	];
	_barra ctrlSetBackgroundColor _color;
	_barra ctrlEnable false;
	_barra ctrlSetFade 1;
	_barra ctrlCommit 0;
	_barra ctrlSetFade 0;
	_barra ctrlCommit 0.5;
};

_createButton = {
	params[
		["_name", "", [""]],
		["_codeInfo", [], [[]]]
	];

	private _Ypos = uiNamespace getVariable ["lastBtnYPos", 0];
	if (_Ypos isEqualTo 0) exitwith {};

	private _button = _display ctrlCreate ["RscButtonTestCentered", -1];
	_button ctrlSetText toUpper _name;
	_button ctrlSetFont "RobotoCondensedBold";
	_button ctrlSetBackgroundColor [0,0,0,0.5];
	_button ctrlSetPosition [
		HORZ_CENTER - w(0.2) / 2,
		_Ypos + h(0.007),
		w(0.2),
		h(0.04)
	];

	_button ctrlSetFade 1;
	_button ctrlCommit 0;
	_button ctrlSetFade 0;
	_button ctrlCommit 0.5;
	(ctrlPosition _button) params ['','_ybtn','','_hbtn'];

	uiNamespace setVariable ["lastBtnYPos", (_ybtn + _hbtn)];
	uiNamespace setVariable ["hoveredBtn", controlnull];
	uiNamespace setVariable ["barColor", _color];
	_button setVariable ["codeInfo", _codeInfo];

	_button ctrlAddEventHandler ['MouseButtonDown',{
		params [["_ctrl", controlNull, [controlnull]]];
		private _display = ctrlParent _ctrl;
		private _codeInfo = _ctrl getVariable ["codeInfo", []];

		if (_codeInfo isNotEqualTo []) then {
			_codeInfo params [ ["_args", [], [[]]], ["_code", {}, [{}]] ];
			_args call _code;
		};

		_display closeDisplay 1;
	}];

	_button ctrlAddEventHandler ['MouseEnter',{
		params [["_ctrl", controlNull, [controlnull]]];
		private _display = ctrlParent _ctrl;
		(ctrlPosition _ctrl) params ['_PosX','_PosY','_PosW','_PosH'];

		playSoundUI ["ReadoutHideClick1", 0.2, 1];
		private _colorBar = uiNamespace getVariable ["barColor", [1,1,1,1]];
		private _bar = _display ctrlCreate ["RscText", -1];
		_bar ctrlSetBackgroundColor _colorBar;
		_bar ctrlSetPosition [
			_PosX,
			_PosY + h(0.037),
			_PosW,
			_PosH - h(0.037)
		];
		_bar ctrlCommit 0;
		_ctrl setVariable ["barHovered", _bar];
	}];

	_button ctrlAddEventHandler ['MouseExit', {
		params [["_ctrl", controlNull, [controlnull]]];
		private _hovered = _ctrl getVariable ["barHovered", controlnull];
		if (!isNull _hovered) then { ctrlDelete _hovered };
	}];

};

// Block ESC button if there its buttons or timeout
if (_haveButtons || { _haveTimeout }) then { _display displayAddEventhandler ["KeyDown", {(_this select 1) isEqualTo 1}]; };

if (_haveButtons) then {
	{
		_x params [ ["_name", "", [""]], ["_code", {}, [{}]], ["_args", [], [[]]] ];
		[_name, [_args, _code]] call _createButton;
	} forEach _buttons;
};

if (_haveTimeout) then {
	[_display, _timeout, _timeoutCodeInfo] spawn {
		params [ ["_display", displayNull, [displayNull]], ["_timeout", 0, [0]], ["_timeoutCodeInfo", [], [[]]] ];

		_timeoutCodeInfo params [ ["_code", {}, [{}]], ["_args", [], [[]]] ];

		private _startTime = diag_tickTime;
		waitUntil {
			if (isNull _display) exitwith {true};
			if (diag_tickTime - _startTime > _timeout) exitwith {
				_display closeDisplay 1;
				_args call _code;
				true
			};

			false
		};
	};
};