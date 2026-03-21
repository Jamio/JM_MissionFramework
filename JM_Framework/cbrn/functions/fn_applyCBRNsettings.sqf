/*
    File: JM_Framework\CBRN\functions\fn_applyCBRNSettings.sqf
    Runs before zones are created.
    Best on server during mission init, with public vars only where needed.
*/

if !(missionNamespace getVariable ["JM_CBRN_enabled", false]) exitWith {};

cbrn_maxDamage = missionNamespace getVariable ["JM_CBRN_maxDamage", 100];
cbrn_allowPassiveDamage = missionNamespace getVariable ["JM_CBRN_allowPassiveDamage", true];
cbrn_healingRate = missionNamespace getVariable ["JM_CBRN_healingRate", 0];
cbrn_deconWaterTime = missionNamespace getVariable ["JM_CBRN_deconWaterTime", 120];
cbrn_deconHealDamage = missionNamespace getVariable ["JM_CBRN_deconHealDamage", false];
cbrn_maxOxygenTime = missionNamespace getVariable ["JM_CBRN_maxOxygenTime", 1800];

cbrn_foggingEnabled = missionNamespace getVariable ["JM_CBRN_foggingEnabled", true];
cbrn_fogStartTime = missionNamespace getVariable ["JM_CBRN_fogStartTime", 300];
cbrn_fogMaxTime = missionNamespace getVariable ["JM_CBRN_fogMaxTime", 600];
cbrn_fogAccumulationCoef = missionNamespace getVariable ["JM_CBRN_fogAccumulationCoef", 0.5];
cbrn_fogFadeCoef = missionNamespace getVariable ["JM_CBRN_fogFadeCoef", 5];
cbrn_fogFatigueEnabled = missionNamespace getVariable ["JM_CBRN_fogFatigueEnabled", true];
cbrn_fogFatigueCoef = missionNamespace getVariable ["JM_CBRN_fogFatigueCoef", 1];
cbrn_fogMaxAlpha = missionNamespace getVariable ["JM_CBRN_fogMaxAlpha", 1];

cbrn_masks = + (missionNamespace getVariable ["JM_CBRN_masks", []]);
cbrn_backpacks = + (missionNamespace getVariable ["JM_CBRN_backpacks", []]);
cbrn_conditioning = + (missionNamespace getVariable ["JM_CBRN_conditioning", []]);
cbrn_suits = + (missionNamespace getVariable ["JM_CBRN_suits", []]);
cbrn_threatMeterItem = missionNamespace getVariable ["JM_CBRN_threatMeterItem", "ACE_microDAGR"];
cbrn_threatGeiger = missionNamespace getVariable ["JM_CBRN_threatGeiger", "ACE_microDAGR"];
cbrn_vehicles = + (missionNamespace getVariable ["JM_CBRN_vehicles", []]);
cbrn_healingItems = + (missionNamespace getVariable ["JM_CBRN_healingItems", []]);

// Optional override. Diwako auto-detects KAT by default.
if !(isNil "JM_CBRN_katEnabled") then {
    cbrn_kat_enabled = JM_CBRN_katEnabled;
};

publicVariable "cbrn_maxDamage";
publicVariable "cbrn_allowPassiveDamage";
publicVariable "cbrn_healingRate";
publicVariable "cbrn_deconWaterTime";
publicVariable "cbrn_deconHealDamage";
publicVariable "cbrn_maxOxygenTime";
publicVariable "cbrn_foggingEnabled";
publicVariable "cbrn_fogStartTime";
publicVariable "cbrn_fogMaxTime";
publicVariable "cbrn_fogAccumulationCoef";
publicVariable "cbrn_fogFadeCoef";
publicVariable "cbrn_fogFatigueEnabled";
publicVariable "cbrn_fogFatigueCoef";
publicVariable "cbrn_fogMaxAlpha";
publicVariable "cbrn_masks";
publicVariable "cbrn_backpacks";
publicVariable "cbrn_conditioning";
publicVariable "cbrn_suits";
publicVariable "cbrn_threatMeterItem";
publicVariable "cbrn_threatGeiger";
publicVariable "cbrn_vehicles";
publicVariable "cbrn_healingItems";
publicVariable "cbrn_kat_enabled";