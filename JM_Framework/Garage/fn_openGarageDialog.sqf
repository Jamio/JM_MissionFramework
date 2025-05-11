// JM_Garage_fnc_openGarageDialog.sqf

// Open the Motor Pool dialog
createDialog "JM_Garage_Dialog";

// Fill the vehicle list
private _list = findDisplay 9100 displayCtrl 1500;
lbClear _list;

{
    private _className = _x select 0;
    private _displayName = _x select 1;
    private _limit = _x select 2;

    if (_limit != 0) then { // Accept positive or infinite
        private _displayText = _displayName;

        if (_limit > 0) then {
            _displayText = format ["%1 (%2 left)", _displayName, _limit];
        } else {
            _displayText = format ["%1 (∞ left)", _displayName]; // <-- Clean for infinite
        };

        private _index = _list lbAdd _displayText;
        _list lbSetData [_index, _className];
    };
} forEach JM_Garage;