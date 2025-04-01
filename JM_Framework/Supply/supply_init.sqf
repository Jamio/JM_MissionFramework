if (isServer) then {
    call compile preprocessFileLineNumbers "JM_Framework\Supply\resupplyConfig.sqf";
    publicVariable "JM_PrimMags";
    publicVariable "JM_SecMags";
    publicVariable "JM_HGmags";
    publicVariable "JM_Grenades";
};


