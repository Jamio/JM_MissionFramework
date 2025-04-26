////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT START (by SPC. Jamio, v1.063, #Gisose)
////////////////////////////////////////////////////////

class JM_SupplyDialog {
    idd = 9011; // Unique ID for this dialog
    movingEnable = false;
    enableSimulation = true;

	class controlsBackground {
        class JM_BoxBackground: RscText
        {
            idc = 1000;

            x = 3.17 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X;
            y = 0 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y;
            w = 13 * GUI_GRID_CENTER_W;
            h = 25 * GUI_GRID_CENTER_H;
            colorBackground[] = {0.2,0.2,0.2,1};
        };
    };

    class controls {
        class JM_Button2: RscButton
        {
            idc = 1600;
            x = 4.17 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X;
            y = 4.1 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y;
            w = 11.0833 * GUI_GRID_CENTER_W;
            h = 2.7 * GUI_GRID_CENTER_H;
			colorBackground[] = {1,1,1,1};
			colorBackgroundActive[] = {1,0.86,0.2,1};
			colorFocused[] = {1,0.86,0.2,1};
			colorDisabled[] = {0.4,0.4,0.4,1};
			colorText[] = {0,0,0,1};
            text = "AMMO CRATE";
			shadow = 0;
			font = "PuristaBold";
			default = true;
			action = "closeDialog 0; [['ammo', player], 'JM_Framework\Supply\spawnSupplyCrate.sqf'] remoteExec ['execVM', 0, false];";

        };
        class JM_DialogHeader: RscText
        {
            idc = 1001;
            style = "ST_CENTER";
            font = "PuristaBold";

            text = "SUPPLY MENU"; //--- ToDo: Localize;
            x = 5 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X;
            y = 0.5 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y;
            w = 29.6667 * GUI_GRID_CENTER_W;
            h = 3.5 * GUI_GRID_CENTER_H;
            colorText[] = {1,0.86,0.2,1};
            colorBackground[] = {1,1,1,0};
            sizeEx = 1.5 * GUI_GRID_CENTER_H;
        };
        class JM_Button3: RscButton
        {
            idc = 1600;
            x = 4.17 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X;
            y = 7.3 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y;
            w = 11.0833 * GUI_GRID_CENTER_W;
            h = 2.7 * GUI_GRID_CENTER_H;
			colorBackground[] = {1,1,1,1};
			colorBackgroundActive[] = {1,0.86,0.2,1};
			colorFocused[] = {1,0.86,0.2,1};
			colorDisabled[] = {0.4,0.4,0.4,1};
			colorText[] = {0,0,0,1};
            text = "MEDICAL CRATE";
			shadow = 0;
			font = "PuristaBold";
			action = "closeDialog 0; [['medical', player], 'JM_Framework\Supply\spawnSupplyCrate.sqf'] remoteExec ['execVM', 0, false];";
        };
        class JM_Button4: RscButton
        {
            idc = 1600;
            x = 4.17 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X;
            y = 10.5 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y;
            w = 11.0833 * GUI_GRID_CENTER_W;
            h = 2.7 * GUI_GRID_CENTER_H;
			colorBackground[] = {1,1,1,1};
			colorBackgroundActive[] = {1,0.86,0.2,1};
			colorFocused[] = {1,0.86,0.2,1};
			colorDisabled[] = {0.4,0.4,0.4,1};
			colorText[] = {0,0,0,1};
            text = "CSW CRATE";
			shadow = 0;
			font = "PuristaBold";
			action = "closeDialog 0; [['csw', player], 'JM_Framework\Supply\spawnSupplyCrate.sqf'] remoteExec ['execVM', 0, false];";
        };
        class JM_Button5: RscButton
        {
            idc = 1600;
            x = 4.17 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X;
            y = 13.7 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y;
            w = 11.0833 * GUI_GRID_CENTER_W;
            h = 2.7 * GUI_GRID_CENTER_H;
			colorBackground[] = {1,1,1,1};
			colorBackgroundActive[] = {1,0.86,0.2,1};
			colorFocused[] = {1,0.86,0.2,1};
			colorDisabled[] = {0.4,0.4,0.4,1};
			colorText[] = {0,0,0,1};
            text = "ENGINEER CRATE";
			shadow = 0;
			font = "PuristaBold";
			action = "closeDialog 0; [['repair', player], 'JM_Framework\Supply\spawnSupplyCrate.sqf'] remoteExec ['execVM', 0, false];";
        };
        class JM_Button6: RscButton
        {
            idc = 1600;
            x = 4.17 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X;
            y = 16.9 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y;
            w = 11.0833 * GUI_GRID_CENTER_W;
            h = 2.7 * GUI_GRID_CENTER_H;
			colorBackground[] = {1,1,1,1};
			colorBackgroundActive[] = {1,0.86,0.2,1};
			colorFocused[] = {1,0.86,0.2,1};
			colorDisabled[] = {0.4,0.4,0.4,1};
			colorText[] = {0,0,0,1};
            text = "EMPTY CRATE";
			shadow = 0;
			font = "PuristaBold";
			action = "closeDialog 0; [['empty', player], 'JM_Framework\Supply\spawnSupplyCrate.sqf'] remoteExec ['execVM', 0, false];";
        };
        class JM_Button1: RscButton
        {
            idc = 1600;
            x = 4.17 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X;
            y = 20.1 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y;
            w = 11.0833 * GUI_GRID_CENTER_W;
            h = 2.7 * GUI_GRID_CENTER_H;
			colorBackground[] = {1,1,1,1};
			colorBackgroundActive[] = {1,0.86,0.2,1};
			colorFocused[] = {1,0.86,0.2,1};
			colorDisabled[] = {0.4,0.4,0.4,1};
			colorText[] = {0,0,0,1};
            text = "CUSTOM CRATE";
			shadow = 0;
			font = "PuristaBold";
			action = "closeDialog 0; [['custom', player], 'JM_Framework\Supply\spawnSupplyCrate.sqf'] remoteExec ['execVM', 0, false];";
        };
    };
};
////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT END
////////////////////////////////////////////////////////

