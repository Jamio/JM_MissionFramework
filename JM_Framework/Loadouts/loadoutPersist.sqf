
if (JM_loadoutPersist) then {

	// Save loadout on death, restore on respawn
	player addEventHandler ["Killed", { player setVariable ["JM_DeathLoadout", getUnitLoadout player]; }];
	player addEventHandler ["Respawn", { private _loadout = player getVariable "JM_DeathLoadout"; if (!isNil "_loadout") then { player setUnitLoadout _loadout; }; }];

} else {

	// Save loadout at start, restore on respawn
	player setVariable ["JM_StartLoadout", getUnitLoadout player];
	player addEventHandler ["Respawn", { private _loadout = player getVariable "JM_StartLoadout"; if (!isNil "_loadout") then { player setUnitLoadout _loadout; }; }];

};