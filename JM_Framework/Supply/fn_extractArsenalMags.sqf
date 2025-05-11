// JM_Supply_fnc_extractArsenalMags.sqf
if (!isServer) exitWith {};

private _allItems = [];

{
    private _items = _x select 1;
    _allItems append _items;
} forEach JM_allowedArsenalItems;

// Remove duplicates
_allItems = _allItems arrayIntersect _allItems;

// Clear/resync global arrays
JM_PrimMags = [];
JM_SecMags = [];
JM_HGmags  = [];
JM_Grenades = [];

{
    private _item = _x;

    if (isClass (configFile >> "CfgMagazines" >> _item)) then {
        private _cfg = configFile >> "CfgMagazines" >> _item;

        if (isText (_cfg >> "ammo")) then {
            private _ammo = getText (_cfg >> "ammo");

            if (_ammo isKindOf "BulletBase") then {
                JM_PrimMags pushBackUnique _item;
            } else {
                if (_ammo isKindOf "GrenadeHand") then {
                    JM_Grenades pushBackUnique _item;
                } else {
                    if (_ammo isKindOf "MissileBase" || _ammo isKindOf "RocketBase") then {
                        JM_SecMags pushBackUnique _item;
                    } else {
                        JM_HGmags pushBackUnique _item;
                    };
                };
            };
        };
    };
} forEach _allItems;

// Public variables for use in crate script or clients
publicVariable "JM_PrimMags";
publicVariable "JM_SecMags";
publicVariable "JM_HGmags";
publicVariable "JM_Grenades";
