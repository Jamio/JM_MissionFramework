
if !(JM_Rally) exitWith {};

addMissionEventHandler ["Draw3D", {
    if (!isNull MF_fobradio1) then {
        private _pos = getPosASL MF_fobradio1; // Get radio position
        _pos set [2, (_pos select 2) - 5]; // Raise text above the object

        drawIcon3D [
            "", // No icon
            [1, 1, 1, 1], // White text
            _pos, // Position
            0, 0, // No icon scaling
            0, // No rotation
            "Platoon Hub", // Text to display
            2, // Text shadow (0=none, 1=light, 2=heavy)
            0.05, // Text size
            "PuristaMedium" // Font
        ];
    };
}];

while {true} do {
"marker_rp1" setmarkerpos getpos MF_Srp1;
"marker_rp2" setmarkerpos getpos MF_Srp2;
"marker_rp3" setmarkerpos getpos MF_Srp3;
"marker_rp4" setmarkerpos getpos MF_Srp4;
sleep 180;
};