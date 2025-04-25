// endMissionSequence.sqf

if (!hasInterface) exitWith {};

[] spawn {
    // === INITIAL FADE & SETUP ===
    cutText ["", "BLACK OUT", 5, true, false, true];
    sleep 2;

    // Optional: disable DUI (if using it)
    missionNamespace setVariable ["diwako_dui_main_toggled_off", true];

    // Heal and lockdown
    [player] call ace_medical_treatment_fnc_fullHealLocal;
    player allowDamage false;
    player setCaptive true;
    5 fadeSound 0;
    5 fadeRadio 0;
    5 fadeEnvironment 0;

	sleep 3;

    // Create & activate camera
    private _cam = "camera" camCreate getPos cam1;
    _cam cameraEffect ["internal", "back"];
    _cam camSetPos getPos cam1;
    _cam camSetTarget cam_focus1;
    _cam camSetFOV 0.55;
    _cam camCommit 0;

    // Fade in to scene
    sleep 1;
    cutText ["", "BLACK IN", 2, true, false, true];
    sleep 3;

    // === DYNAMIC TITLE SEQUENCE ===
    private _titles = missionNamespace getVariable ["JM_EndTitles", []];
    {
        titleText [
            format ["<t valign='middle' align='center' size='3' color='#ffe396' font='PuristaMedium'>%1</t>", _x],
            "PLAIN", -1, true, true
        ];
        sleep 10;
    } forEach _titles;

    // === FADE OUT & SHOW DEBRIEF DIALOG ===
    cutText ["", "BLACK OUT", 3, true, false, true];
    sleep 5;

    // Camera cleanup
    camDestroy _cam;

    // Bring back sound a bit
    5 fadeSound 1;
    5 fadeRadio 1;
    5 fadeEnvironment 1;

    // Respawn/teleport players near each other
    player setPosATL (getMarkerPos "respawn_west");

    // === SHOW DEBRIEF STATS GUI ===
    [] call JM_Misc_fnc_showDebriefDialog;

    // OPTIONAL AUTO-END
    sleep 45;
    ["END1", true, true] call BIS_fnc_endMission;
};
