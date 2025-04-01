if (hasInterface) then {
    private _category = "Mission Framework";
    private _title = "Framework Status";
    private _text = "<br/>";

    // Define framework features and their variables
    private _frameworkFeatures = [
        ["Unconscious Spectator", JM_unconSpectator],
        ["Grass Cutter", JM_GrassCutter],
        ["Safe Zone", JM_Safezone],
        ["Punish Weapon", JM_puinishWep],
        ["Marker Scaling", JM_MrkScaling],
        ["Earplugs", JM_Earplugs],
        ["Fortify System", JM_Fortify],
        ["Rally System", JM_Rally],
        ["Teleport to Squad", JM_tpToSL]
    ];

    {
        private _featureName = _x select 0;
        private _isEnabled = _x select 1;
        private _statusColor = if (_isEnabled) then {"#00FF00"} else {"#FF0000"}; // Green for Enabled, Red for Disabled
        private _statusText = if (_isEnabled) then {"Enabled"} else {"Disabled"};

        _text = _text + format ["%1: <font color='%2'>%3</font><br/>", _featureName, _statusColor, _statusText];
    } forEach _frameworkFeatures;

    // Create a new category for the framework
    player createDiarySubject [_category, _category];

    // Add the briefing entry under the new category
    player createDiaryRecord [_category, [_title, _text]];
};





