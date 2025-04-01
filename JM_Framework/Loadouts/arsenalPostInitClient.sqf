if (JM_arsenalRoleRestrict) then {
    [] spawn {
        waitUntil { !isNil "JM_arsenalObjects" && {count JM_arsenalObjects > 0} };
        [] execVM "JM_Framework\Loadouts\fn_initRestrictedArsenalObjects.sqf";
    };
};
