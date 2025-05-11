// Scan player magazines if role restricted arsenal is not enabled

waitUntil {
    !isNull player && alive player && {!isNil "JM_arsenalRoleRestrict"}
};

if (!JM_arsenalRoleRestrict) then {
    sleep 2;

    systemChat format ["[SCAN] Scanning mags for: %1", name player];

    systemChat format ["[SCAN] Scanning mags for ID: %1", getPlayerUID player];

    systemChat format ["[SCAN] AllPlayers: %1", allPlayers];



    private _fn = missionNamespace getVariable "JM_Supply_fnc_scanPlayerMagsFromUID";

        if (isNil "_fn") then {
            systemChat "[SUPPLY] scanPlayerMagsFromUID function NOT found in missionNamespace!";
        } else {
            systemChat "[SUPPLY] scanPlayerMagsFromUID function IS found. Proceeding with remoteExec...";
            [getPlayerUID player] remoteExec ["JM_Supply_fnc_scanPlayerMagsFromUID", 2];
        };
};