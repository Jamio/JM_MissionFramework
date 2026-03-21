cutText ["","BLACK FADED",2];




// *********************************************************************************************************
// ************************************* MISSION FRAMEWORK - DO NOT TOUCH **********************************
// *********************************************************************************************************

[] call JM_Perf_fnc_buildCleanupCache;


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

[] spawn {
  waitUntil { !isNil "JM_Rally" };
  if (!JM_Rally) exitWith {};

  // First apply on join
  [] call JM_RallyPoint_fnc_addLocalRallyActions;

  // Keep in sync after respawn
  ["respawn", {
    params ["_new","_old"];
    {
      if (_old getVariable [_x,false]) then { _new setVariable [_x,true,true]; };
    } forEach ["JM_isSquadLead","JM_isPlatoonLead"];

    0 spawn { uiSleep 0.1; [] call JM_RallyPoint_fnc_addLocalRallyActions; };
  }] call CBA_fnc_addPlayerEventHandler;
};

// ************************************** TICKET-BASED RESPAWNING *******************************************************

if (JM_TicketsMedevac) then {
    [] call JM_TicketsMedevac_fnc_initClient;
};

// ************************************** JTAC SYSTEM *******************************************************

[] spawn {
    waitUntil { !isNil "JM_JTAC" };
    if (!JM_JTAC) exitWith {};

    [] call JM_JTAC_fnc_init;
    [] call JM_JTAC_fnc_refreshLocalActions;

    ["respawn", {
        params ["_new", "_old"];

        if (_old getVariable ["JM_isJTAC", false] || { _old getVariable ["isJTAC", false] }) then {
            _new setVariable ["JM_isJTAC", true, true];
        };

        _new setVariable ["JM_JTAC_actionAdded", false];

        0 spawn {
            uiSleep 0.1;
            [] call JM_JTAC_fnc_refreshLocalActions;
        };
    }] call CBA_fnc_addPlayerEventHandler;
};


// ************************************ 3D LABELS FOR BOXES AND STUFF *****************************************************

if (hasInterface) then {
    addMissionEventHandler ["Draw3D", {
        {
            private _box = _x;
            if (isNull _box) then { continue };
            if (_box distance player > 25) then { continue };
            if ([_box, "VIEW", player] checkVisibility [eyePos _box, eyePos player] < 0.3) then { continue };

            private _pos = ASLToAGL (getPosASL _box vectorAdd [0,0,2]);

            drawIcon3D [
                "",
                [1,1,1,1],
                _pos,
                0.2,
                0.2,
                45,
                _box getVariable ["JM_drawLabel_text", "Interaction"],
                2,
                0.04,
                "PuristaSemiBold"
            ];
        } forEach JM_draw3D_boxes;
    }];
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




// ************************************** INIT SCREENSHOT HUD TOGGLE *******************************************************

[] call JM_hideui_fnc_addAceHudAction;