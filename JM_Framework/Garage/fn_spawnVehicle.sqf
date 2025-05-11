// JM_Garage_fnc_spawnVehicle.sqf

systemChat "Spawning vehicle...";

private _list = findDisplay 9100 displayCtrl 1500;
private _selectedIndex = lbCurSel _list;

if (_selectedIndex < 0) exitWith {
    systemChat "Select a vehicle first!";
};

private _className = _list lbData _selectedIndex;

// Find vehicle info
private _vehicleInfoIndex = JM_Garage findIf { (_x select 0) isEqualTo _className };
if (_vehicleInfoIndex == -1) exitWith { systemChat "Vehicle data error."; };

private _vehicleInfo = JM_Garage select _vehicleInfoIndex;
private _limit = _vehicleInfo select 2;

if (_limit == 0) exitWith {
    systemChat "No more spawns for this vehicle!";
};

// --- Determine spawn marker based on vehicle type ---

private _spawnMarker = "JM_GarageSpawn_Land"; // Default fallback

if (_className isKindOf "Air") then {
    _spawnMarker = "JM_GarageSpawn_Air";
};
if (_className isKindOf "Ship") then {
    _spawnMarker = "JM_GarageSpawn_Sea";
};

private _spawnPos = getMarkerPos _spawnMarker;
if (_spawnPos isEqualTo [0,0,0]) exitWith {
    systemChat format ["Garage spawn marker %1 missing!", _spawnMarker];
};

// --- Actually spawn the vehicle ---
[_className, _spawnPos] remoteExec ["JM_Garage_fnc_serverSpawn", 2];

// --- Decrease the limit ---
if (_limit > 0) then {
    _vehicleInfo set [2, (_limit - 1)];
};

// --- Close the dialog ---
closeDialog 0;