
// Handle adding starter weapons to Diwakos punish weapon whitelist
if (JM_punishWep && !JM_arsenalRoleRestrict) then {
    [] spawn {
        waitUntil { time > 5 && player == player };  // Make sure the player is initialised

        private _prim = primaryWeapon player;
        private _sec  = secondaryWeapon player;
        private _hg   = handgunWeapon player;

        private _toAdd = [];

        if (_prim != "") then { _toAdd pushBack (toUpper _prim); };
        if (_sec  != "") then { _toAdd pushBack (toUpper _sec); };
        if (_hg   != "") then { _toAdd pushBack (toUpper _hg); };

        {
            ["diwako_unknownwp_addWeapon", [_x]] call CBA_fnc_serverEvent;
        } forEach _toAdd;
    };
};
