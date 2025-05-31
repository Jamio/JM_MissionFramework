// JM_Framework\RallyPoint\fn_addRallyAction.sqf
// Usage: [_unit, "squad"] or [_unit, "platoon"]

params ["_passedUnit", "_type"];
if (!local _passedUnit) exitWith {};

private _unit = _passedUnit;

private _actionID = "";
private _path = ["ACE_SelfActions"];
private _varFlag = "";
private _action = [];

switch (_type) do {
    case "squad": {

        _actionID = "DeploySquadRally";
        _varFlag = "JM_HasRallyAction";

        _action = [
            _actionID,
            "Deploy Squad Rally",
            ["z\ace\addons\flags\data\icons\carry\white_carry_icon.paa", "#1551e8"],
            {
                private _nearby = (player nearEntities ["Man", 15]) select {side _x == side player};
                if ((count _nearby) <= 2) exitWith { hint "Need at least 1 ally nearby to deploy Squad Rally"; };

                [player] call ace_common_fnc_goKneeling;
                [player, "AinvPknlMstpSnonWnonDnon_medic_1", 1] call ace_common_fnc_doAnimation;

                [10, [], {
                    // Clean up previous rally
                    private _old = player getVariable ["JM_RallyObject", objNull];
                    if (!isNull _old) then {
                        deleteVehicle _old;

                        // Remove old from rally list
                        private _list = missionNamespace getVariable ["JM_allSquadRallies", []];
                        private _filtered = _list select { _x select 0 != _old };
                        missionNamespace setVariable ["JM_allSquadRallies", _filtered, true];
                    };

                    private _oldMarker = player getVariable ["JM_RallyMarker", ""];
                    if (_oldMarker != "") then { deleteMarker _oldMarker; };

                    // Create new rally bag
                    private _bag = createVehicle ["Land_TentSolar_01_folded_olive_F", player modelToWorld [0, 2, 0], [], 0, "CAN_COLLIDE"];
                    _bag allowDamage false;
                    player setVariable ["JM_RallyObject", _bag, true];

                    // Add to global rally list
                    private _entry = [_bag, name player];
                    private _existing = missionNamespace getVariable ["JM_allSquadRallies", []];
                    missionNamespace setVariable ["JM_allSquadRallies", _existing + [_entry], true];

                    // Create marker
                    private _marker = createMarker [format ["RALLY_%1", name player], getPos _bag];
                    _marker setMarkerTypeLocal "mil_triangle";
                    _marker setMarkerSizeLocal [0.7, 0.7];
                    _marker setMarkerTextLocal format ["%1's Rally", name player];
                    _marker setMarkerColor "ColorBlue";
                    player setVariable ["JM_RallyMarker", _marker, true];

                    hint "Rally Point Deployed";
                }, {
                    hint "Deployment interrupted";
                }, "Deploying Rally Point"] call ace_common_fnc_progressBar;
            },
            { true },
            {},
            [],
            [0,0,0],
            2,
            [false, false, false, false, false],
            {}
        ];
    };
    case "platoon": {
    
        systemChat "Setting up Platoon Rally action...";
        _actionID = "DeployPlatoonRally";
        _varFlag = "JM_HasPlatoonRallyAction";

    _action = [
        "DeployPlatoonRally",
        "Deploy Platoon Rally",
        ["z\ace\addons\flags\data\icons\carry\white_carry_icon.paa", "#e8b015"],
        {
            private _nearby = (player nearEntities ["Man", 15]) select {side _x == side player};
            if ((count _nearby) <= 3) exitWith { hint "Need at least 3 allies nearby to deploy Platoon Rally"; };

            [player] call ace_common_fnc_goKneeling;
            [player, "AinvPknlMstpSnonWnonDnon_medic_1", 1] call ace_common_fnc_doAnimation;

            [20, [], {
                // === Variables for tracking
                private _platoonRally = missionNamespace getVariable ["JM_PltRallyObject", objNull];
                private _markerName = missionNamespace getVariable ["JM_PltRallyMarker", ""];

                if (isNull _platoonRally) then {
                    // === First time: create Platoon Rally
                    _platoonRally = createVehicle ["PortableFlagPole_01_F", player modelToWorld [0,2,0], [], 0, "CAN_COLLIDE"];
                    _platoonRally allowDamage false;
                    _platoonRally setFlagTexture "JM_Framework\RallyPoint\rallyflag.paa"; // <--- custom flag texture
                    _platoonRally animateSource ['Flag_source', 1, true];

                    missionNamespace setVariable ["JM_PltRallyObject", _platoonRally, true];

                    // === Create Marker
                    _markerName = format ["JM_PltRallyMarker_%1", floor (random 9999)];
                    private _marker = createMarker [_markerName, getPos _platoonRally];
                    _marker setMarkerType "mil_flag";
                    _marker setMarkerColor "ColorBlue";
                    _marker setMarkerText "Platoon Rally";
                    missionNamespace setVariable ["JM_PltRallyMarker", _markerName, true];

                    // === Add Retreat Action (remotely for all clients)
                    [
                        _platoonRally,
                        [
                            "<t color='#e03a4e'>Retreat</t>",
                            "JM_Framework\RallyPoint\retreat.sqf",
                            [HQ_Retreat_01], // Argument passed
                            1,               // Priority
                            false,           // ShowWindow
                            true,            // HideOnUse
                            "",              // Statement Condition
                            "side player == WEST", // Visibility Condition
                            4                // Interaction Radius
                        ]
                    ] remoteExec ["addAction", 0];
                } else {
                    // === Already exists: move Platoon Rally
                    _platoonRally setVehiclePosition [(player modelToWorld [0,2,0]), [], 0.5, "CAN_COLLIDE"];

                    // === Move marker if exists
                    if (_markerName != "") then {
                        _markerName setMarkerPos (getPos _platoonRally);
                    };
                };

                // === Move all squad rallies near the new platoon rally
                {
                    private _rallyObj = _x select 0;
                    if (!isNull _rallyObj) then {
                        private _offset = [random 4 - 2, random 4 - 2, 0];
                        _rallyObj setVehiclePosition [(player modelToWorld _offset), [], 0.2, "CAN_COLLIDE"];
                    };
                } forEach (missionNamespace getVariable ["JM_allSquadRallies", []]);


                hint "Platoon Rally Deployed!";
            }, { hint "Deployment interrupted" }, "Deploying Platoon Rally"] call ace_common_fnc_progressBar;
        },
        { true },
        {},
        [],
        [0,0,0],
        2,
        [false,false,false,false,false],
        {}
    ];
};
};

[player, 1, _path, _action] call ace_interact_menu_fnc_addActionToObject;
_unit setVariable [_varFlag, true, true];

