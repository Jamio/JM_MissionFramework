/* ORIGINAL SCRIPT WITHOUT ARSENAL MESHING
if (JM_loadoutPersist) then {

	// Save loadout on death, restore on respawn
	player addEventHandler ["Killed", { player setVariable ["JM_DeathLoadout", getUnitLoadout player]; }];
	player addEventHandler ["Respawn", { private _loadout = player getVariable "JM_DeathLoadout"; if (!isNil "_loadout") then { player setUnitLoadout _loadout; }; }];

} else {

	// Save loadout at start, restore on respawn
	player setVariable ["JM_StartLoadout", getUnitLoadout player];
	player addEventHandler ["Respawn", { private _loadout = player getVariable "JM_StartLoadout"; if (!isNil "_loadout") then { player setUnitLoadout _loadout; }; }];

};

*/

if (JM_loadoutPersist) then {

    // Save loadout on death
    player addEventHandler ["Killed", {
        player setVariable ["JM_RespawnLoadout", getUnitLoadout player];
    }];

} else {

    if (JM_arsenalRoleRestrict) then {
        // Save loadout every time the player closes the ACE arsenal
	["ace_arsenal_displayClosed", {
		player setVariable ["JM_RespawnLoadout", getUnitLoadout player];
		hint parseText "<t size='1.4' color='#FF4444'>Role-Restricted Arsenal</t><br/><t size='1.1' color='#FFFFFF'>Your respawn loadout has been saved.</t>";
	}] call CBA_fnc_addEventHandler;


    } else {
        // Save starting loadout immediately
        player setVariable ["JM_RespawnLoadout", getUnitLoadout player];
    };
};

// Restore on respawn
player addEventHandler ["Respawn", {
    private _loadout = player getVariable "JM_RespawnLoadout";
    if (!isNil "_loadout") then {
        player setUnitLoadout _loadout;
    };
}];
