
/*
    JM_JTAC_fnc_localInboundHint
    Params:
      0: missionName (string)
      1: grid (string)
      2: etaSeconds (number)
      3: dangerClose (bool)
      4: usesLeft (number, -1 unlimited)
      5: cooldown (number, seconds, 0 none)
*/
if (!hasInterface) exitWith {};

params ["_name", "_grid", ["_eta", 0], ["_dc", false], ["_usesLeft", -1], ["_cooldown", 0]];

private _etaInt = round (_eta max 0);

private _dcLine = if (_dc) then {
    "<t color='#FF4444'>DANGER CLOSE</t><br/>"
} else { "" };

private _usesLine = if (_usesLeft >= 0) then {
    format ["Uses left: %1<br/>", _usesLeft]
} else { "" };

private _cdLine = if (_cooldown > 0) then {
    format ["Cooldown: %1s<br/>", round _cooldown]
} else { "" };

hint parseText format [
    "<img size='3' image='a3\modules_f_curator\data\portraitradio_ca.paa'/><br/>" +
    "<t size='1.4' color='#27EE1F'>TRANSMISSION CONFIRMED</t><br/>" +
    "<t size='1.1' color='#FFFFFF'>%1<br/>Grid: %2<br/>ETA: %3s<br/>%4%5</t>%6",
    _name, _grid, _etaInt, _usesLine, _cdLine, _dcLine
];


