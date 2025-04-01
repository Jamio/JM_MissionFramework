


// Initialize global public variables for tracking total kills and losses
totalKills = 0;
publicVariable "totalKills";

totalLosses = 0;
publicVariable "totalLosses";

// Event handler for tracking player kills (human players only)
addMissionEventHandler ["EntityKilled", {
    params ["_killed", "_killer", "_instigator"];

    // Check if the killer is a player and controlled by a human (not AI, not Zeus)
    if (!isNull _killer && {isPlayer _killer}) then {
        totalKills = totalKills + 1;  // Increment global kill tally
        publicVariable "totalKills";  // Broadcast the updated value to all clients
    }
}];

// Precompile the plane flyover function for optimized execution
JM_fnc_airFlyover = compile preprocessFileLineNumbers "JM_Framework\ZeusModules\fn_airFlyover.sqf";
