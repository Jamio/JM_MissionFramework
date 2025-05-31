
#include "JM_Framework\Misc\Stats\initStats.sqf"


// Whitelisting Arsenal weapons for the unknownWep module

[] spawn {
    // Wait for settings to initialize
    waitUntil {!isNil "JM_punishWep"};
    
            if (JM_punishWep) then {
                [] call JM_Loadouts_fnc_whitelistArsenalWeapons;
            };
    };



[] spawn {

waitUntil {!isNil "JM_Rally"}; 

if (JM_Rally) then {
    // Do the initial assignment for existing leaders
    [] spawn JM_RallyPoint_fnc_updateRallyAssignments;

    // Register LeaderChanged EH on all current player groups
    {
        private _group = group _x;
        if (isNil {_group getVariable "JM_HasLeaderEH"}) then {
            _group setVariable ["JM_HasLeaderEH", true];
            _group addEventHandler ["LeaderChanged", {
                params ["_group", "_newLeader"];
                [] remoteExec ["JM_RallyPoint_fnc_updateRallyAssignments", 2];
            }];
        };
    } forEach allPlayers;
};

};


// Supply Stuff

[] execVM "JM_Framework\Supply\supply_init.sqf";

JM_Supply_fnc_scanPlayerMagsFromUID = compile preprocessFileLineNumbers "JM_Framework\Supply\fn_scanPlayerMagsFromUID.sqf";




