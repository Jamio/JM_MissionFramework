/*
  JM Simple AI Caching (WebKnight-trimmed, globals + correct hide syntax)
*/

if (!isServer) exitWith {};
waitUntil { !isNil "JM_optimiseAI" };
if (!JM_optimiseAI) exitWith { diag_log "[JM_Framework] AI optimisation disabled (JM_optimiseAI=false)."; };

if (isNil "JM_AICacheRadius") then { JM_AICacheRadius = 200; };
if (isNil "JM_AICacheSides")  then { JM_AICacheSides  = [east]; };

WBK_OptimiseAiOnMap = {
    _unit = _this;

    // Hide/freeze globally (server-authoritative)
    _unit enableSimulationGlobal false;
    _unit hideObjectGlobal true;
    _unit disableAI "FSM";
    _unit disableAI "COVER";
    _unit disableAI "SUPPRESSION";

    // Wake once a player is within radius
    [{
        (({ (_x distance _this) <= JM_AICacheRadius } count allPlayers) >= 1)
    }, {
        _unit = _this;

        _unit enableSimulationGlobal true;
        _unit hideObjectGlobal false;   // <-- correct unhide

        _unit enableAI "FSM";
        _unit enableAI "COVER";
        _unit enableAI "SUPPRESSION";

        group _unit enableDynamicSimulation true;

    }, _unit, -1] call CBA_fnc_waitUntilAndExecute;
};

// Apply to configured sides
{
    if (!isPlayer _x && { (side _x) in JM_AICacheSides }) then {
        _x spawn WBK_OptimiseAiOnMap;
    };
} forEach allUnits;


// --- Vehicle caching (optional, crewed vehicles only) ---
WBK_OptimiseVehicleOnMap = {
    _veh = _this;
    if (!alive _veh) exitWith {};

    // Hide/freeze vehicle + crew
    _veh enableSimulationGlobal false;
    _veh hideObjectGlobal true;

    {
        if (alive _x) then {
            _x enableSimulationGlobal false;
            _x hideObjectGlobal true;
            _x disableAI "FSM";
            _x disableAI "COVER";
            _x disableAI "SUPPRESSION";
        };
    } forEach crew _veh;

    // Wake once a player is within radius of the vehicle
    [{
        (({ (_x distance _this) <= JM_AICacheRadius } count allPlayers) >= 1)
    }, {
        _veh = _this;
        if (!alive _veh) exitWith {};

        // Unhide/unfreeze vehicle + crew
        _veh enableSimulationGlobal true;
        _veh hideObjectGlobal false;
        
        (group (driver _veh)) enableDynamicSimulation true;

        {
            if (alive _x) then {
                _x enableSimulationGlobal true;
                _x hideObjectGlobal false;
                _x enableAI "FSM";
                _x enableAI "COVER";
                _x enableAI "SUPPRESSION";

                _x enableDynamicSimulation true;

            };
        } forEach crew _veh;
    }, _veh, -1] call CBA_fnc_waitUntilAndExecute;
};


