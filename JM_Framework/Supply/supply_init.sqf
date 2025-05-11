if (isServer) then {

    waitUntil {!isNil "JM_arsenalRoleRestrict"};

    if (JM_arsenalRoleRestrict) then {
        // Arsenal is in use — safe to initialize fresh and fill with allowed items
        JM_PrimMags = [];
        JM_SecMags = [];
        JM_HGmags  = [];
        JM_Grenades = [];

        call JM_Supply_fnc_extractArsenalMags;
    };
};


