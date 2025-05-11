// JM_Framework\RallyPoint\fnc_updateRallyAssignments.sqf

[] spawn {
    while {true} do {
        {
            private _unit = _x;
            if (!alive _unit) then { continue };

            // -------------------------
            // SQUAD RALLY ASSIGNMENT
            // -------------------------
            private _isSquadLead = (leader group _unit == _unit);
            if (_isSquadLead) then {
                if (isNil {_unit getVariable "JM_HasRallyAction"}) then {
                    [_unit, "squad"] remoteExec ["JM_RallyPoint_fnc_addRallyAction", _unit];
                };
            } else {
                if (!isNil {_unit getVariable "JM_HasRallyAction"}) then {
                    // Remove ACE action
                    [_unit, 1, ["ACE_SelfActions", "DeploySquadRally"]] remoteExec ["ace_interact_menu_fnc_removeActionFromObject", _unit];

                    // Delete rally object if placed
                    private _rally = _unit getVariable ["JM_RallyObject", objNull];
                    if (!isNull _rally) then {
                        deleteVehicle _rally;
                    };

                    // Delete rally marker if exists
                    private _marker = _unit getVariable ["JM_RallyMarker", ""];
                    if (_marker != "") then {
                        deleteMarker _marker;
                    };

                    // Clear tracking vars
                    _unit setVariable ["JM_HasRallyAction", nil, true];
                    _unit setVariable ["JM_RallyObject", nil, true];
                    _unit setVariable ["JM_RallyMarker", nil, true];
                };
            };

            // -------------------------
            // PLATOON RALLY ASSIGNMENT
            // -------------------------
            private _isPlatoonLead = _unit getVariable ["JM_isPlatoonLead", false];
            if (_isPlatoonLead) then {
                if (isNil {_unit getVariable "JM_HasPlatoonRallyAction"}) then {
                    [_unit, "platoon"] remoteExec ["JM_RallyPoint_fnc_addRallyAction", _unit];
                };
            } else {
                if (!isNil {_unit getVariable "JM_HasPlatoonRallyAction"}) then {
                    [_unit, 1, ["ACE_SelfActions", "DeployPlatoonRally"]] remoteExec ["ace_interact_menu_fnc_removeActionFromObject", _unit];

                    _unit setVariable ["JM_HasPlatoonRallyAction", nil, true];
                };
            };
        } forEach allPlayers;

        sleep 10;
    };
};




