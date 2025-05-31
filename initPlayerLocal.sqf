cutText ["","BLACK FADED",2];


// *********************************************************************************************************
// ************************************* MISSION FRAMEWORK - DO NOT TOUCH **********************************
// *********************************************************************************************************


// Marker Scaling Script
#include "JM_Framework\MarkerSize\markerScaling.sqf"

// Grass Cutter script
#include "JM_Framework\GrassCutter\grassCutter.sqf"

// Framework Status - Briefing Entry for debugging
#include "JM_Framework\Misc\frameworkStatus.sqf"

// Handle loadout persistence
#include "JM_Framework\Loadouts\loadoutPersist.sqf"

// Handle restricted arsenal
#include "JM_Framework\Loadouts\arsenalPostInitClient.sqf"

// Stamina handler
#include "JM_Framework\Stamina\staminaInit.sqf"

// Initialise Custom briefing   
#include "JM_Framework\Misc\briefing.sqf";

// ************************************** UNCONSCIOUS SPECTATOR ********************************************************

#include "JM_Framework\UnconSpectator\initLocal.sqf"



// ************************************** DLC GEAR CHECK ON SPAWN ********************************************************

#include "JM_Framework\Misc\DLCParser\ownDLCCheck.sqf"

// ************************************** INIT STATS THAT TRACK LOCALLY ********************************************************
#include "JM_Framework\Misc\Stats\initStatsLocal.sqf"

// ************************************** TFAR SETIINGS (WIP MAY DELETE) ********************************************************

#include "JM_Framework\TFAR\manageTFARRadios.sqf"

// ************************************** AMEND SUPPLY SYSTEM ARRAYS *******************************************************

#include "JM_Framework\Supply\supplyInitPlayer.sqf"

// ************************************** DISABLE ACE ARSENAL FACE *******************************************************

if (!JM_arsenalIdentity) then {
["ace_arsenal_displayOpened", {
    params ["_display"];

    [{
        params ["_display"];

        {
            private _ctrl = _display displayCtrl _x;
            _ctrl ctrlEnable false;
            _ctrl ctrlSetFade 0.6;
            _ctrl ctrlCommit 0;
        } forEach [2033, 2035]; // Face and Voice buttons

    }, [_display]] call CBA_fnc_execNextFrame;
}] call CBA_fnc_addEventHandler;
};

// ************************************** RALLY CHECKING EH *******************************************************

if (JM_Rally) then {
    ["group", {
        params ["_unit", "_newGroup"];

        if (isNil {_newGroup getVariable "JM_HasLeaderEH"}) then {
            _newGroup setVariable ["JM_HasLeaderEH", true];

            _newGroup addEventHandler ["LeaderChanged", {
                params ["_group", "_newLeader"];
                [] remoteExec ["JM_RallyPoint_fnc_updateRallyAssignments", 2];
            }];
        };
    }] call CBA_fnc_addPlayerEventHandler;
};


// ************************************** BLACK IN *******************************************************


waitUntil {!isNull player} && {(getClientStateNumber == 10)};
waitUntil{ !isNull findDisplay 46 };
waitUntil { time > 0 };

sleep 2;

cutText ["", "BLACK IN", 1];

playMusic "JM_Intro";

// ************************************** MISSION TITLE DISPLAY *******************************************************

waitUntil {time > 30};

private _missionName = getText (missionConfigFile >> "onLoadName");
private _author = getText (missionConfigFile >> "author");

[parseText format [
    "<t font='PuristaBold' size='2.6'>%1</t><br /><t font='PuristaBold' size='1.6'>by %2</t>",
    _missionName,
    _author
], 
[0.5, 0.5, 2, 2], 
[10, 10], 
7, 
0.7, 
0] spawn BIS_fnc_textTiles;