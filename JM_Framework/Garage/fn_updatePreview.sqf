// JM_Garage_fnc_updatePreview.sqf
params ["_listControl", "_selectedIndex"];

if (_selectedIndex < 0) exitWith {};

// Get the selected vehicle classname
private _className = _listControl lbData _selectedIndex;

// Get the editorPreview path
private _previewPath = getText (configFile >> "CfgVehicles" >> _className >> "editorPreview");

// Update the preview picture
private _display = ctrlParent _listControl;
private _picControl = _display displayCtrl 1200;

if (_previewPath != "") then {
    _picControl ctrlSetText _previewPath;
} else {
    // Fallback if no preview exists
    _picControl ctrlSetText "";
};