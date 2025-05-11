// JM_Supply_fnc_scanPlayerMags.sqf
// Scans a player's gear for magazines and categorises them just like the arsenal scan hopefully lol

params ["_unit"];

systemChat format ["[SCAN] Scanning mags for: %1", _unit];

if (!isServer || isNull _unit) exitWith {};

systemChat format ["[SCAN] Scanning mags for: %1", _unit];

// Ensure global arrays exist
if (isNil "JM_PrimMags") then { JM_PrimMags = []; };
if (isNil "JM_SecMags") then { JM_SecMags = []; };
if (isNil "JM_HGmags")  then { JM_HGmags  = []; };
if (isNil "JM_Grenades") then { JM_Grenades = []; };

// Gather all magazines from the unit
private _rawMags = (
    magazines _unit +
    primaryWeaponMagazine _unit +
    secondaryWeaponMagazine _unit +
    handgunMagazine _unit +
    (throwables _unit apply { _x select 0 })
);

systemChat format ["[SCAN] Raw mags: %1", _rawMags];

// Manually deduplicate
private _magsToCheck = [];
{ _magsToCheck pushBackUnique _x } forEach _rawMags;

// Classify each mag by ammo type
{
    private _mag = _x;
    private _cfg = configFile >> "CfgMagazines" >> _mag;

    if (isClass _cfg && isText (_cfg >> "ammo")) then {
        private _ammo = getText (_cfg >> "ammo");

        if (_ammo isKindOf "BulletBase") then {
            JM_PrimMags pushBackUnique _mag;
        } else {
            if (_ammo isKindOf "GrenadeHand") then {
                JM_Grenades pushBackUnique _mag;
            } else {
                if (_ammo isKindOf "MissileBase" || _ammo isKindOf "RocketBase") then {
                    JM_SecMags pushBackUnique _mag;
                } else {
                    JM_HGmags pushBackUnique _mag;
                };
            };
        };
    };
} forEach _magsToCheck;

// Broadcast for use in crate scripts etc.
publicVariable "JM_PrimMags";
publicVariable "JM_SecMags";
publicVariable "JM_HGmags";
publicVariable "JM_Grenades";

systemChat format ["[SCAN] global mag arrays: %1 %2 %3 %4", JM_PrimMags, JM_SecMags, JM_HGmags, JM_Grenades];
