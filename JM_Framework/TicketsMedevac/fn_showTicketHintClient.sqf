params ["_spent", "_remaining"];
if (!hasInterface) exitWith {};

hint parseText format [
    "<img size='3' image='a3\ui_f\data\IGUI\Cfg\Actions\heal_ca.paa'/><br/>" +
    "<t size='1.35' color='#FFCC44'>Reinsertion Authorized</t><br/>" +
    "<t size='1.05' color='#FFFFFF'>Tickets spent: <t color='#FFD27F'>%1</t><br/>" +
    "Tickets remaining: <t color='#FFD27F'>%2</t></t>",
    _spent,
    _remaining
];