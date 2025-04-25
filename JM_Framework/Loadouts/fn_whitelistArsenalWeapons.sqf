/*
    Whitelists all intended weapons for Diwako's unknown weapon system.
    - If JM_arsenalRoleRestrict = true: pulls from JM_allowedArsenalItems
    - If false: pulls from currently connected players' weapons
*/

waitUntil {
    !isNil "JM_arsenalRoleRestrict" && {
        if (JM_arsenalRoleRestrict) then {
            !isNil "JM_allowedArsenalItems"
        } else {
            count ([] call CBA_fnc_players) > 0
        }
    }
};

if (isNil "diwako_unknownwp_weapon_whitelist") then {
    diwako_unknownwp_weapon_whitelist = [];
};

if (JM_arsenalRoleRestrict) then {
    {
        private _items = _x select 1;
        {
            if (isClass (configFile >> "CfgWeapons" >> _x)) then {
                private _type = getNumber (configFile >> "CfgWeapons" >> _x >> "type");
                if (_type in [1, 2, 4]) then {
                    diwako_unknownwp_weapon_whitelist pushBackUnique (toUpper _x);
                };
            };
        } forEach _items;
    } forEach JM_allowedArsenalItems;

} else {
    {
        private _prim = primaryWeapon _x;
        private _sec  = secondaryWeapon _x;
        private _hg   = handgunWeapon _x;

        if (_prim != "") then { diwako_unknownwp_weapon_whitelist pushBackUnique (toUpper _prim); };
        if (_sec  != "") then { diwako_unknownwp_weapon_whitelist pushBackUnique (toUpper _sec); };
        if (_hg   != "") then { diwako_unknownwp_weapon_whitelist pushBackUnique (toUpper _hg); };
    } forEach ([] call CBA_fnc_players);
};

publicVariable "diwako_unknownwp_weapon_whitelist";

