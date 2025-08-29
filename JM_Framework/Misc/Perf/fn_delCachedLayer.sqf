/*
    Deletes all cached local objects in the specified layer.
    Usage:
        ["Layer_Phase1"] remoteExecCall ["TAG_fnc_deleteCachedLayer", 0];
*/

params ["_layer"];

if (isNil "JM_CleanupObjects") exitWith {};
private _objs = JM_CleanupObjects getOrDefault [_layer, []];
private _deleted = [];

{
    if (local _x) then {
        deleteVehicle _x;
        _deleted pushBack _x;
    };
} forEach _objs;

diag_log format ["[Cleanup] Deleted %1 objects from layer '%2' on %3", count _deleted, _layer, name player];

// Optional: remove the layer from cache to prevent re-use
// JM_CleanupObjects deleteAt _layer;