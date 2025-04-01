// Function to populate an ammo resupply crate
// Parameters:
// _crate - The ammo crate object to populate
// _primaryCount - Number of magazines for primary weapons
// _secondaryCount - Number of magazines for secondary weapons
// _launcherCount - Number of rockets for launchers
// _grenadeCount - Number of grenades
//
// Instructions:
// To call this function from an object's init field, use the following syntax:
// [this, PRIMARY_COUNT, SECONDARY_COUNT, LAUNCHER_COUNT, GRENADE_COUNT] call JM_fnc_createAmmoCrate;
// Replace PRIMARY_COUNT, SECONDARY_COUNT, LAUNCHER_COUNT, and GRENADE_COUNT with the desired values.
// Example:
// [this, 50, 20, 5, 10] execVM "JM_Framework\Supply\ammoCrate.sqf";



if !(isServer) exitWith {};
waitUntil { time > 5 };

params ["_crate", "_pCount", "_sCount", "_lCount", "_gCount"];

if (isNull _crate) exitWith {};

clearItemCargoGlobal _crate;
clearMagazineCargoGlobal _crate;
clearWeaponCargoGlobal _crate;
clearBackpackCargoGlobal _crate;

_crate setVariable ["ace_dragging_ignoreweightdrag", true];
_crate setVariable ["ace_dragging_ignoreweightcarry", true];

{ _crate addMagazineCargoGlobal [_x, _pCount]; } forEach JM_PrimMags;
{ _crate addMagazineCargoGlobal [_x, _lCount]; } forEach JM_SecMags;
{ _crate addMagazineCargoGlobal [_x, _sCount]; } forEach JM_HGmags;
{ _crate addMagazineCargoGlobal [_x, _gCount]; } forEach JM_Grenades;





/*

    // Collect all weapons and grenades from players
    {
        private _primaryWeapon = primaryWeapon _x;
        private _secondaryWeapon = handgunWeapon _x;
        private _launcherWeapon = secondaryWeapon _x; // Launcher is also returned by secondaryWeapon
        private _unitGrenades = (magazines _x) select {getText (configFile >> "CfgMagazines" >> _x >> "ammo") find "HandGrenade" > -1};

        if (_primaryWeapon != "") then {_weapons pushBackUnique _primaryWeapon};
        if (_secondaryWeapon != "") then {_weapons pushBackUnique _secondaryWeapon};
        if (_launcherWeapon != "") then {_weapons pushBackUnique _launcherWeapon};
        {_grenades pushBackUnique _x} forEach _unitGrenades;
    } forEach allPlayers;

    // Add magazines for each weapon
    {
        private _mags = getArray (configFile >> "CfgWeapons" >> _x >> "magazines");
        {
            if (_mags isEqualTo []) exitWith {};
            {
                _crate addMagazineCargoGlobal [_x, _primaryCount];
            } forEach _mags;
        } forEach _weapons;
    };

    // Add grenades to the crate
    {
        _crate addMagazineCargoGlobal [_x, _grenadeCount];
    } forEach _grenades;

    // Add rockets for launchers
    {
        private _mags = getArray (configFile >> "CfgWeapons" >> _x >> "magazines");
        {
            if (_mags isEqualTo []) exitWith {};
            {
                _crate addMagazineCargoGlobal [_x, _launcherCount];
            } forEach _mags;
        } forEach (_weapons select {getText (configFile >> "CfgWeapons" >> _x >> "type") == "Launcher"});
    };

    // Log completion
    systemChat format ["Ammo crate populated: %1", _crate];
};


*/