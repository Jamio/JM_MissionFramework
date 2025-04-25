params [["_duration", 3], ["_text", "Sample Text"]]; // Default = 3 seconds

disableSerialization;
"blake_cinemaBorder" cutRsc ["RscCinemaBorder", "PLAIN"];
private _borderDialog = uiNamespace getVariable "RscCinemaBorder";
private _borderTop = _borderDialog displayCtrl 100001;
private _borderBottom = _borderDialog displayCtrl 100002;
private _height = 0.125 * safeZoneH;
private _offset = 0.1;

showHUD false;

_borderTop ctrlSetPosition [safeZoneX - _offset, safeZoneY - _height - _offset, safeZoneW + 2 * _offset, _height + _offset];
_borderBottom ctrlSetPosition [safeZoneX - _offset, safeZoneY + safeZoneH, safeZoneW + 2 * _offset, _height + _offset];
{_x ctrlCommit 0} forEach [_borderTop, _borderBottom];

_borderTop ctrlSetPosition [safeZoneX - _offset, safeZoneY - _offset, safeZoneW + 2 * _offset, _height + _offset];
_borderBottom ctrlSetPosition [safeZoneX - _offset, safeZoneY + safeZoneH - _height, safeZoneW + 2 * _offset, _height + _offset];
{_x ctrlCommit 1.5} forEach [_borderTop, _borderBottom];

waitUntil {
    sleep 1;
    ctrlCommitted _borderTop &&
    ctrlCommitted _borderBottom
};

private _text = format ["<t font='PuristaSemiBold' >%1</t>", _text];
[_text, .95, 1.2, _duration, 0.2, 0, 789] spawn BIS_fnc_dynamicText;

sleep (_duration - 1);

_borderTop ctrlSetPosition [safeZoneX - _offset, safeZoneY - _height - _offset, safeZoneW + 2 * _offset, _height + _offset];
_borderBottom ctrlSetPosition [safeZoneX - _offset, safeZoneY + safeZoneH, safeZoneW + 2 * _offset, _height + _offset];
{_x ctrlCommit 1.5} forEach [_borderTop, _borderBottom];

waitUntil {
    sleep 1;
    ctrlCommitted _borderTop &&
    ctrlCommitted _borderBottom
};

"blake_cinemaBorder" cutText ["", "PLAIN"];
playSound "border_out";
showHUD true;
