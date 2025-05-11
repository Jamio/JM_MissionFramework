disableSerialization;
createDialog "JM_RedeployDialog";

private _disp = findDisplay 9010;
private _map = _disp displayCtrl 1200;
private _list = _disp displayCtrl 1500;

lbClear _list;

// Add Platoon Rally if it exists
private _platoonRally = missionNamespace getVariable ["JM_PltRallyObject", objNull];
if (!isNull _platoonRally) then {
    private _index = _list lbAdd "Platoon Rally";
    _list lbSetData [_index, str getPosATL _platoonRally];
};

// Add Squad Rallies
private _rallies = missionNamespace getVariable ["JM_allSquadRallies", []];
{
    private _rallyObj = _x select 0;
    private _ownerName = _x select 1;

    if (!isNull _rallyObj) then {
        private _index = _list lbAdd format ["%1's Rally", _ownerName];
        _list lbSetData [_index, str getPosATL _rallyObj];
    };
} forEach _rallies;

// === Teammate ListBox (IDC 1501) ===
private _teammateList = _disp displayCtrl 1501;
lbClear _teammateList;

{
    if (
        alive _x &&
        _x != player &&
        isNull getAssignedCuratorLogic _x
    ) then {
        private _index = _teammateList lbAdd name _x;
        _teammateList lbSetData [_index, netId _x];
    };
} forEach units group player;
