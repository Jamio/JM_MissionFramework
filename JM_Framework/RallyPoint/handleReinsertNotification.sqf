params ["_name"];

hint parseText format [
    "<img size='3' image='a3\modules_f_curator\data\portraitradio_ca.paa'/><br/>" +
    "<t size='1.4' color='#FF4444'>Reinsertion Request</t><br/>" +
    "<t size='1.1' color='#FFFFFF'>%1 is requesting a reinsertion from the staging area.<br/><br/>" +
    "Any available transports, please respond when able.</t>",
    _name
];