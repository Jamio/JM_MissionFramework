

// *********************************************************************************************************
// ************************************* MISSION FRAMEWORK - DO NOT TOUCH **********************************
// *********************************************************************************************************


// Marker Scaling Script
#include "JM_Framework\MarkerSize\markerScaling.sqf"

// Grass Cutter script
#include "JM_Framework\GrassCutter\grassCutter.sqf"

// Rally Point Script - PLT Rally
#include "JM_Framework\RallyPoint\pltRally.sqf"

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

// ************************************** MISSION TITLE DISPLAY *******************************************************

waitUntil {time > 15};

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

// ************************************** PLAYER DEATH TRACKING *******************************************************

// Event handler for tracking player losses (deaths)
player addEventHandler ["Killed", {
    if (isServer) then {
        totalLosses = totalLosses + 1;  // Increment global loss tally
        publicVariable "totalLosses";   // Broadcast the updated value to all clients
    };
}];

// ************************************** UNCONSCIOUS SPECTATOR ********************************************************

#include "JM_Framework\UnconSpectator\initLocal.sqf"



// ************************************** DLC GEAR CHECK ON SPAWN ********************************************************

#include "JM_Framework\Misc\DLCParser\ownDLCCheck.sqf"

// ************************************** JOIN IN PROGRESS *******************************************************


if (didJIP) exitWith {
// hint "You joined in-progress, Moving you to your Squad leader";

uiSleep 7;

[ 
 "YOU JOINED MID-MISSION", 
 "<t color='#ffffff' font='RobotoCondensedBold' size='1'>You joined in-progress, You will be moved to your Squad leader.</t>", 
 [1,0.6,0,1], 
 true, 
 [ 
    ["I am ready to go!", {

        _TPpos = [];
        _plyer = player;

        if ((leader player) == objnull) then {
            
            _plyer = selectRandom allPlayers;
            _TPpos = getPosATL _plyer; 
         
        } else {

            _plyer = (leader player);
            _TPpos = getPosATL _plyer;             

        };

        player setPosATL _TPpos;

    }],

    ["I am not ready to go yet...", {

        [ 
            "ATTENTION!", 
            "<t color='#ffffff' font='RobotoCondensed' size='1'>Ping Zeus or use the respawn system when ready.<br/> (Default key: Y)</t>", 
            [1,0.6,0,1],
            true, 
            [ 
                ["Got it!", {systemChat "Ping Zeus or use the respawn system when ready."}]
            ] 
        ] call JM_fnc_guiMessage;

    }]
 
 ], 
 0 
] call JM_fnc_guiMessage;

};
