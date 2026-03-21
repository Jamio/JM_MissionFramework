/*
    Returns arrays for a ZEN LIST control:
    [
        _values,      // classnames
        _prettyNames  // [displayName, tooltip, picture]
    ]
*/

private _values = [];
private _prettyNames = [];

{
    private _cfg = _x;
    private _class = configName _cfg;

    if (!isClass _cfg) then { continue };
    if (getNumber (_cfg >> "scope") < 2) then { continue };
    if !(_class isKindOf ["Air", configFile >> "CfgVehicles"]) then { continue };

    private _displayName = getText (_cfg >> "displayName");
    if (_displayName isEqualTo "") then { continue };

    private _faction = getText (_cfg >> "faction");
    private _editorSubcategory = getText (_cfg >> "editorSubcategory");

    private _picture = getText (_cfg >> "editorPreview");
    if (_picture isEqualTo "") then {
        _picture = getText (_cfg >> "picture");
    };

    private _tooltip = format [
        "%1\nClass: %2\nFaction: %3\nSubcategory: %4",
        _displayName,
        _class,
        _faction,
        _editorSubcategory
    ];

    _values pushBack _class;
    _prettyNames pushBack [_displayName, _tooltip, _picture];
} forEach ("true" configClasses (configFile >> "CfgVehicles"));