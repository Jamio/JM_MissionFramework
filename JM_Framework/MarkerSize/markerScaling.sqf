// Code to keep the scaling and size of all markers on the map consistent

sleep 5;

if !(JM_MrkScaling) exitWith {systemChat "[JM MARKERSCALE] is not active";};

0 = 0 spawn {
    // Wait until the map display (ID 12) is available
    waitUntil {!isNull findDisplay 12};

    // Add event handler for adjusting map marker sizes
    findDisplay 12 displayCtrl 51 ctrlAddEventHandler ["Draw", {
        if (visibleMap) then {
            // Get the current zoom scale
            _scale = 0.05 / ctrlMapScale (_this select 0);

            {
                // Only apply scaling if the marker is in JM_scaleMrkrs
                if (_x in JM_scaleMrkrs) then {
                    _m = "#markerSize_" + _x;
                    if (markerShape _x == "ICON") then {
                        // Store the original marker size if not already saved
                        if (isNil {missionNamespace getVariable _m}) then {
                            missionNamespace setVariable [_m, markerSize _x];
                        };

                        // Retrieve the original size of the marker
                        private _originalSize = missionNamespace getVariable _m;

                        // Apply the scale but ensure it respects the original size
                        _x setMarkerSizeLocal [
                            (_originalSize select 0) * _scale max (_originalSize select 0),  // Keep size at least as large as originally set
                            (_originalSize select 1) * _scale max (_originalSize select 1)   // Same for Y axis
                        ];
                    };
                };
            } forEach allMapMarkers;  // Apply only to selected markers
        };
    }];
};



systemChat "[JM MARKERSCALE] is active";
