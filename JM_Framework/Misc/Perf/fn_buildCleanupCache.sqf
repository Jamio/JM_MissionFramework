/*
    Caches local-only objects into a hashmap by their custom 'layer' tag.
    Only includes objects that are:
    - local
    - not units
    - not vehicles
    - tagged with setVariable ["JM_layer", "LayerName"]
*/

JM_CleanupObjects = createHashMap;

{
    if (
        local _x &&
        {!(_x isKindOf "Man")} &&
        {!(_x isKindOf "LandVehicle" || _x isKindOf "Air" || _x isKindOf "Ship")} &&
        {_x getVariable ["JM_layer", ""] != ""}
    ) then {
        private _layer = _x getVariable ["JM_layer", ""];
        if (isNil { JM_CleanupObjects get _layer }) then {
            JM_CleanupObjects set [_layer, [_x]];
        } else {
            (JM_CleanupObjects get _layer) pushBack _x;
        };
    };
} forEach allMissionObjects ""; // This can be replaced with nearestObjects or limited to certain types if needed

diag_log format ["[Startup] Cached cleanup objects by layer: %1", keys JM_CleanupObjects];