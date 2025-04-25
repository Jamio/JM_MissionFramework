// JM_Framework\Supply\resupplyConfig.sqf

if (JM_arsenalRoleRestrict) then {
    // Dynamically extract items from JM_allowedArsenalItems

    JM_PrimMags = [];
    JM_SecMags = [];
    JM_HGmags  = [];
    JM_Grenades = [];

    private _allItems = [];

    {
        private _items = _x select 1;
        _allItems append _items;
    } forEach JM_allowedArsenalItems;

    _allItems = _allItems arrayIntersect _allItems; // remove duplicates

    {
        if (isClass (configFile >> "CfgMagazines" >> _x)) then {
            private _ammo = getText (configFile >> "CfgMagazines" >> _x >> "ammo");

            if (_ammo isKindOf "BulletBase") then {
                JM_PrimMags pushBackUnique _x;
            } else {
                if (_ammo isKindOf "GrenadeHand") then {
                    JM_Grenades pushBackUnique _x;
                } else {
                    JM_SecMags pushBackUnique _x;
                };
            };
        };
    } forEach _allItems;

} else {

#include "getMags.sqf"

};
