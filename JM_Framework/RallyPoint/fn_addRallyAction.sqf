// Usage: [_unit, "squad"] or [_unit, "platoon"]
params ["_unit", "_type"];
if (!hasInterface || {!local _unit}) exitWith {};

private _path   = ["ACE_SelfActions"];
private _id     = if (_type isEqualTo "platoon") then {"DeployPlatoonRally"} else {"DeploySquadRally"};
private _title  = if (_type isEqualTo "platoon") then {"Deploy Platoon Rally"} else {"Deploy Squad Rally"};
private _color  = if (_type isEqualTo "platoon") then {"#e8b015"} else {"#1551e8"};

private _action = [
  _id,
  _title,
  ["z\ace\addons\flags\data\icons\carry\white_carry_icon.paa", _color],

  // STATEMENT
  {
    params ["_target","_player","_params"];
    _params params ["_kind"];  // "squad" or "platoon"

    // Ally requirement (excluding self)
    private _need = if (_kind isEqualTo "platoon") then {3} else {1};
    private _allyCount = count ((getPosATL _player) nearEntities ["Man", 15] select {
      side _x == side _player && {_x != _player} && {alive _x}
    });
    if (_allyCount < _need) exitWith {
      hint format ["Need at least %1 ally nearby", _need];
    };

    [_player] call ace_common_fnc_goKneeling;
    [_player, "AinvPknlMstpSnonWnonDnon_medic_1", 1] call ace_common_fnc_doAnimation;

    // ACE progress bar: [time, args, onFinish, onFail, title, condition]
    [
      if (_kind isEqualTo "platoon") then {20} else {10},
      [_player, _kind],
      {
        // onFinish
        params ["_args","_elapsed","_total","_err"];
        _args params ["_ply","_kind"];

        // >>> KEEP YOUR EXISTING WORLD LOGIC HERE <<<
        // If you prefer, you can remoteExec to a server function; otherwise do your previous createVehicle/marker code.
        // Example (minimal, from your original squad path with tiny cleanups):

        if (_kind isEqualTo "squad") then {
          // Clean old
          private _old = _ply getVariable ["JM_RallyObject", objNull];
          if (!isNull _old) then {
            deleteVehicle _old;
            private _list = missionNamespace getVariable ["JM_allSquadRallies", []];
            missionNamespace setVariable ["JM_allSquadRallies", _list select { (_x select 0) != _old }, true];
          };
          private _oldMarker = _ply getVariable ["JM_RallyMarker", ""];
          if (_oldMarker != "") then { deleteMarker _oldMarker; };

          // Create new rally bag
          private _bag = createVehicle ["Land_TentSolar_01_folded_olive_F", _ply modelToWorld [0, 2, 0], [], 0, "CAN_COLLIDE"];
          _bag allowDamage false;
          _ply setVariable ["JM_RallyObject", _bag, true];

          // Track globally
          private _entry = [_bag, name _ply];
          private _existing = missionNamespace getVariable ["JM_allSquadRallies", []];
          missionNamespace setVariable ["JM_allSquadRallies", _existing + [_entry], true];

          // Marker (keep style but keep global const)
          private _m = createMarker [format ["RALLY_%1", name _ply], getPos _bag];
          _m setMarkerType "mil_triangle";
          _m setMarkerSize [0.7, 0.7];
          _m setMarkerText format ["%1's Rally", name _ply];
          _m setMarkerColor "ColorBlue";
          _ply setVariable ["JM_RallyMarker", _m, true];

          hint "Rally Point Deployed";
        } else {
          // Platoon path (original logic)
          private _platoonRally = missionNamespace getVariable ["JM_PltRallyObject", objNull];
          private _markerName   = missionNamespace getVariable ["JM_PltRallyMarker", ""];

          if (isNull _platoonRally) then {
            _platoonRally = createVehicle ["PortableFlagPole_01_F", _ply modelToWorld [0,2,0], [], 0, "CAN_COLLIDE"];
            _platoonRally allowDamage false;
            _platoonRally setFlagTexture "JM_Framework\RallyPoint\rallyflag.paa";
            _platoonRally animateSource ['Flag_source', 1, true];

            missionNamespace setVariable ["JM_PltRallyObject", _platoonRally, true];

            _markerName = format ["JM_PltRallyMarker_%1", floor (random 9999)];
            private _marker = createMarker [_markerName, getPos _platoonRally];
            _marker setMarkerType "mil_flag";
            _marker setMarkerColor "ColorBlue";
            _marker setMarkerText "Platoon Rally";
            missionNamespace setVariable ["JM_PltRallyMarker", _markerName, true];

            [
              _platoonRally,
              [
                "<t color='#e03a4e'>Retreat</t>",
                "JM_Framework\RallyPoint\retreat.sqf",
                [HQ_Retreat_01],
                1, false, true, "", "", 4
              ]
            ] remoteExec ["addAction", 0];
          } else {
            _platoonRally setVehiclePosition [_ply modelToWorld [0,2,0], [], 0.5, "CAN_COLLIDE"];
            if (_markerName != "") then {
              _markerName setMarkerPos (getPos _platoonRally);
            };
          };

          {
            private _rallyObj = _x select 0;
            if (!isNull _rallyObj) then {
              private _offset = [random 4 - 2, random 4 - 2, 0];
              _rallyObj setVehiclePosition [_ply modelToWorld _offset, [], 0.2, "CAN_COLLIDE"];
            };
          } forEach (missionNamespace getVariable ["JM_allSquadRallies", []]);

          hint "Platoon Rally Deployed!";
        };
      },
      {
        // onFail
        params ["_args","_elapsed","_total","_err"];
        hint "Deployment interrupted";
      },
      if (_kind isEqualTo "platoon") then {"Deploying Platoon Rally"} else {"Deploying Squad Rally"},
      { true }  // keep the bar alive (you can add a real condition later)
    ] call ace_common_fnc_progressBar;
  },

  // ACTION CONDITION
  { true },

  // insertChildren, params, pos, distance, exceptions, modifierFn
  {}, [_type], [0,0,0], 2, [false,false,false,false,false], {}
] call ace_interact_menu_fnc_createAction;

// Idempotent UI: remove-then-add so the button never duplicates
[_unit, 1, _path + [_id]] call ace_interact_menu_fnc_removeActionFromObject;
[_unit, 1, _path, _action] call ace_interact_menu_fnc_addActionToObject;
