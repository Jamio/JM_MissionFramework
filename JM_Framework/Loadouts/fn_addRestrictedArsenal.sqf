/*
    Registers an object as a restricted arsenal box.
    Should be called on the client with [this] call JM_fnc_addRestrictedArsenal;
*/

if (!hasInterface) exitWith {};

params [
    ["_object", objNull, [objNull]]
];

if (isNull _object) exitWith {
    systemChat "[JM_Arsenal] ERROR: Arsenal object is null.";
};

if (isNil "JM_arsenalObjects") then {
    JM_arsenalObjects = [];
};

JM_arsenalObjects pushBackUnique _object;
