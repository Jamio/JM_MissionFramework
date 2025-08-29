// Runs on the owning client. Adds/removes ACE actions based on per-slot vars.
// Safe to call on join and after respawn.

if (!hasInterface) exitWith {};
private _u = player;
private _path = ["ACE_SelfActions"];

[
  {
    // Wait until ACE interact is ready
    !isNil "ace_interact_menu_fnc_addActionToObject"
    && !isNil "ace_interact_menu_fnc_createAction"
    && time > 0
  },
  {
    private _u = player;
    private _path = ["ACE_SelfActions"];

    // Always remove first (idempotent UI)
    [_u, 1, _path + ["DeploySquadRally"]]   call ace_interact_menu_fnc_removeActionFromObject;
    [_u, 1, _path + ["DeployPlatoonRally"]] call ace_interact_menu_fnc_removeActionFromObject;

    // Add if flagged
    if (_u getVariable ["JM_isSquadLead", false]) then {
      [_u, "squad"] call JM_RallyPoint_fnc_addRallyAction;
    };
    if (_u getVariable ["JM_isPlatoonLead", false]) then {
      [_u, "platoon"] call JM_RallyPoint_fnc_addRallyAction;
    };
  }
] call CBA_fnc_waitUntilAndExecute;