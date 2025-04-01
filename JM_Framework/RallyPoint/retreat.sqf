_dest = (_this select 3) select 0; // Get the destination.
_dir = random 359; // Get a random direction

// Move the person a few meters away from the destination (in the direction of _dir)

disableUserInput true;

"retreat" cutText ["Retreating", "BLACK", 1, true];
sleep 2;
player SetPos (getPos _dest);
call ace_medical_treatment_fnc_fullHeal;
_rettime = 30;
while {_rettime>0} do {
	_rettime = _rettime - 1;
	titleText [str(_rettime), "PLAIN DOWN", 1];
	sleep 1;
};
titleFadeOut 1;
"retreat" cutFadeout 4;

disableUserInput false;