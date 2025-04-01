// Function to populate a medical resupply crate
// Parameters:
// _crate - The medical crate object to populate
// _fieldDressingCount - Number of ACE_fieldDressing items
// _bloodIVCount - Number of ACE_bloodIV items
// _bloodIV500Count - Number of ACE_bloodIV_500 items
// _bloodIV250Count - Number of ACE_bloodIV_250 items
// _splintCount - Number of ACE_splint items
// _tourniquetCount - Number of ACE_tourniquet items
// _painkillersCount - Number of ACE_painkillers items
// _epinephrineCount - Number of ACE_epinephrine items
// _morphineCount - Number of ACE_morphine items
//
// Instructions:
// To call this function from an object's init field, use the following syntax:
// [this, FIELD_DRESSING_COUNT, BLOOD_IV_COUNT, BLOOD_IV_500_COUNT, BLOOD_IV_250_COUNT, SPLINT_COUNT, TOURNIQUET_COUNT, PAINKILLERS_COUNT, EPINEPHRINE_COUNT, MORPHINE_COUNT] call JM_fnc_createMedicalCrate;
// Replace each parameter with the desired values.
// Example:
// [this, 50, 20, 5, 10] execVM "JM_Framework\Supply\medCrate.sqf";

if !(isServer) exitWith {};

waitUntil {time > 5};

params [
    "_crate",
    "_fieldDressingCount",
    "_bloodIVCount",
    "_bloodIV500Count",
    "_bloodIV250Count",
    "_splintCount",
    "_tourniquetCount",
    "_painkillersCount",
    "_epinephrineCount",
    "_morphineCount"
];

// Clear the crate of all items
if (!isNull _crate) then {
    clearItemCargoGlobal _crate;
    clearMagazineCargoGlobal _crate;
    clearWeaponCargoGlobal _crate;
    clearBackpackCargoGlobal _crate;

    // Set ACE variables to ignore weight
    _crate setVariable ["ace_dragging_ignoreweightdrag", true];
    _crate setVariable ["ace_dragging_ignoreweightcarry", true];

    // Add medical supplies to the crate
    _crate addItemCargoGlobal ["ACE_fieldDressing", _fieldDressingCount];
    _crate addItemCargoGlobal ["ACE_bloodIV", _bloodIVCount];
    _crate addItemCargoGlobal ["ACE_bloodIV_500", _bloodIV500Count];
    _crate addItemCargoGlobal ["ACE_bloodIV_250", _bloodIV250Count];
    _crate addItemCargoGlobal ["ACE_splint", _splintCount];
    _crate addItemCargoGlobal ["ACE_tourniquet", _tourniquetCount];
    _crate addItemCargoGlobal ["ACE_painkillers", _painkillersCount];
    _crate addItemCargoGlobal ["ACE_epinephrine", _epinephrineCount];
    _crate addItemCargoGlobal ["ACE_morphine", _morphineCount];
};



