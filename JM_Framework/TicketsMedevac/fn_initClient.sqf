if (!hasInterface) exitWith {};
if !(missionNamespace getVariable ["JM_TicketsMedevac", false]) exitWith {};

// Fancy hint handler (unchanged)
["JM_TicketsMedevac_notify", {
    params ["_msg", ["_title", "MEDEVAC"], ["_icon", "a3\modules_f_curator\data\portraitradio_ca.paa"]];

    hint parseText format [
        "<img size='3' image='%1'/><br/>" +
        "<t size='1.4' color='#FF4444'>%2</t><br/>" +
        "<t size='1.1' color='#FFFFFF'>%3</t>",
        _icon,
        _title,
        _msg
    ];
}] call CBA_fnc_addEventHandler;

// Add vanilla addAction to dropoff objects
{
    private _varName = _x;

    [{
        params ["_varName"];
        !isNull (missionNamespace getVariable [_varName, objNull])
    }, {
        params ["_varName"];
        private _obj = missionNamespace getVariable [_varName, objNull];
        if (isNull _obj) exitWith {};

        _obj addAction [
            "<img image='z\ace\addons\medical_gui\ui\bodybag.paa' size='1.2' shadow='0'/> <t color='#ffdb33'>Submit Bodybags</t>",
            {
                params ["_target", "_caller", "_actionId", "_arguments"];
                [_target, _caller] remoteExecCall ["JM_TicketsMedevac_fnc_submit", 2];
            },
            nil,                 // arguments
            1.5,                 // priority
            true,                // showWindow
            true,                // hideOnUse
            "",                  // shortcut
            "alive _this"        // condition
        ];

    }, [_varName]] call CBA_fnc_waitUntilAndExecute;

} forEach (missionNamespace getVariable ["JM_TicketsDropoffObjects", []]);

