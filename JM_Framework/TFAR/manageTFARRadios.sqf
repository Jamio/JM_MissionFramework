/*
    Handles saving and restoring TFAR radio settings (shortwave and longrange) 
    when players die and respawn.

*/

/*
if (isClass (configFile >> "CfgPatches" >> "task_force_radio")) then {

    // --- Save TFAR settings on player death ---
    player addEventHandler ["Killed", {
        private _swSettings = [player] call TFAR_fnc_getSwSettings;
        private _lrSettings = [player] call TFAR_fnc_getLrSettings;

        player setVariable ["JM_Respawn_SWSettings", _swSettings];
        player setVariable ["JM_Respawn_LRSettings", _lrSettings];
    }];

    // --- Restore TFAR settings on player respawn ---
    player addEventHandler ["Respawn", {
        private _swSettings = player getVariable ["JM_Respawn_SWSettings", []];
        private _lrSettings = player getVariable ["JM_Respawn_LRSettings", []];

        [player, _swSettings, _lrSettings] spawn {
            params ["_unit", "_sw", "_lr"];

            // Wait until the player has an active radio
            waitUntil {
                sleep 0.25; // Don't hammer scheduler
                private _swRadio = [_unit] call TFAR_fnc_activeSwRadio;
                private _lrRadio = [_unit] call TFAR_fnc_activeLrRadio;
                !(_swRadio isEqualTo "" && _lrRadio isEqualTo "")
            };

            // Apply saved radio settings
            if (!(_sw isEqualTo [])) then {
                [_unit, _sw] call TFAR_fnc_setSwSettings;
            };
            if (!(_lr isEqualTo [])) then {
                [_unit, _lr] call TFAR_fnc_setLrSettings;
            };
        };
    }];
};
*/

