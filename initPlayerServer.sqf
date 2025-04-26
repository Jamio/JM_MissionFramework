

// Handle adding starter weapons to Diwakos punish weapon whitelist
[] spawn {
    // Wait for settings to initialize
    waitUntil {
        !isNil "JM_punishWep" && 
        !isNil "JM_arsenalRoleRestrict" && 
        player == player // Player is local
    };

    // Now safe to check values
    if (JM_punishWep && !JM_arsenalRoleRestrict) then {
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
