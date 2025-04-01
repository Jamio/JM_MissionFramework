params ["_unit"];

// Ensure the script only runs on the machine that owns the unit (locality check)
if (!local _unit) exitWith {};

// Check if the "destroy on look" script is already enabled
private _isScriptRunning = _unit getVariable ["destroyOnLookEnabled", false];

if (_isScriptRunning) then {
    // If the script is running, disable it
    _unit setVariable ["destroyOnLookEnabled", false, true];
    hint "Destroy on look disabled.";
} else {
    // If the script is not running, enable it
    _unit setVariable ["destroyOnLookEnabled", true, true];
	hint "destroyEyes enabled";

    // Start a loop to destroy whatever the unit looks at
    [] spawn {
        while {player getVariable ["destroyOnLookEnabled", false]} do {
				cursorObject setDamage 1;
            };
            sleep 0.5;  // Check every 100 milliseconds
        };
    };