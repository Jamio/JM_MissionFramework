/*
    JM_JTAC_fnc_selectTargetMap
    Client: closes dialog, opens main map, captures ONE click as ASL target, then reopens dialog.
*/

systemChat "JTAC map opened.";
if (!hasInterface) exitWith {};
//if (uiNamespace getVariable ["JM_JTAC_isSelecting", false]) exitWith {};

uiNamespace setVariable ["JM_JTAC_isSelecting", true];

// Close dialog for clean map click
closeDialog 0;

// Clear any previous handler
onMapSingleClick "";

// Open map
openMap true;
hint "Click on the map to set target.";

// One-click capture
onMapSingleClick {
    private _atl = _pos;


    private _asl = ATLtoASL _atl;
    uiNamespace setVariable ["JM_JTAC_targetASL", _asl];        

    onMapSingleClick "";
    openMap false;

    hint format ["Target set: %1", mapGridPosition _atl];

    uiNamespace setVariable ["JM_JTAC_isSelecting", false];

    [] spawn {
        sleep 0.05;
        createDialog "JM_JTAC_Dialog";
    };
};



