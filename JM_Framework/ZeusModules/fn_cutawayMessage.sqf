params ["_message", "_duration"];

// Display the message
[{ 
    params ["_message"];
    cutText [_message, "BLACK OUT", 3, true, false, false];
}, [_message]] call CBA_fnc_execNextFrame;

// Hold for duration
sleep _duration;

// Fade screen back in
cutText ["", "BLACK IN", 2];

