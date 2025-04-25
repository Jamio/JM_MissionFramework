class JM_DebriefDialog {
    idd = 9000;
    movingEnable = false;
    enableSimulation = true;

    class controlsBackground {
        class JM_CardBackground: RscText
        {
            idc = 1000;

            x = 0.1 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X;
            y = -0.9 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y;
            w = 42.1 * GUI_GRID_CENTER_W;
            h = 27.4 * GUI_GRID_CENTER_H;
            colorBackground[] = {0,0,0,0.8};
        };
        class JM_CardBackground2: RscText
        {
            idc = 1002;
            x = 0.08 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X;
            y = 27 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y;
            w = 15.9167 * GUI_GRID_CENTER_W;
            h = 2.5 * GUI_GRID_CENTER_H;
            colorBackground[] = {-1,-1,-1,0.8};
        };
    };

    class controls {
        class JM_Image: RscPicture
        {
            idc = 9001;

            text = "#(argb,8,8,3)color(1,1,1,1)";
            x = 0.5 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X;
            y = -0.5 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y;
            w = 15.3 * GUI_GRID_CENTER_W;
            h = 8 * GUI_GRID_CENTER_H;
        };
        class JM_MissionTitle: RscStructuredText
        {
            idc = 9002;
            style = 2;

            text = "OPERATION MISSION TEMP"; //--- ToDo: Localize;
            x = 0.5 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X;
            y = 8 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y;
            w = 15.3 * GUI_GRID_CENTER_W;
            h = 2.5 * GUI_GRID_CENTER_H;
        };
        class JM_DebriefText: RscStructuredText
        {
            idc = 9003;
            size = 0.03;

            text = "Debrief goes here..."; //--- ToDo: Localize;
            x = 0.5 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X;
            y = 11.5 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y;
            w = 15.2 * GUI_GRID_CENTER_W;
            h = 14.5 * GUI_GRID_CENTER_H;
        };
        class JM_PersonalStatsBox: RscStructuredText
        {
            idc = 9005;
            size = 0.03;

            text = "Personal Stats appear here..."; //--- ToDo: Localize;
            x = 17.17 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X;
            y = -0.5 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y;
            w = 24.5 * GUI_GRID_CENTER_W;
            h = 11 * GUI_GRID_CENTER_H;
        };
        class JM_MissionStatsBox: RscStructuredText
        {
            idc = 9006;
            size = 0.03;

            text = "Mission Stats appear here..."; //--- ToDo: Localize;
            x = 17.18 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X;
            y = 11.5 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y;
            w = 24.4833 * GUI_GRID_CENTER_W;
            h = 14.5 * GUI_GRID_CENTER_H;
        };
        class JM_CloseButton: RscButton
        {
            idc = 9004;
            action = "closeDialog 0";

            text = "Close"; //--- ToDo: Localize;
            x = 37 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X;
            y = 26.6 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y;
            w = 5 * GUI_GRID_CENTER_W;
            h = 0.7 * GUI_GRID_CENTER_H;
        };
        class JM_MissionCompleteHeader: RscStructuredText
        {
            idc = 9007;

            text = "<t size='1.4' align='center'>MISSION COMPLETED</t>"; //--- ToDo: Localize;
            x = 0.3 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X;
            y = -5 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y;
            w = 41.8 * GUI_GRID_CENTER_W;
            h = 3.5 * GUI_GRID_CENTER_H;
        };
        class JM_Frame1: RscFrame
        {
            idc = 1800;
            x = 17 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X;
            y = 11.2 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y;
            w = 25 * GUI_GRID_CENTER_W;
            h = 15 * GUI_GRID_CENTER_H;
        };
        class JM_Frame2: RscFrame
        {
            idc = 1801;
            x = 17 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X;
            y = -0.7 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y;
            w = 24.9333 * GUI_GRID_CENTER_W;
            h = 11.5 * GUI_GRID_CENTER_H;
        };
        class JM_Frame3: RscFrame
        {
            idc = 1802;
            x = 0.3 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X;
            y = 11.2 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y;
            w = 15.7333 * GUI_GRID_CENTER_W;
            h = 15.1 * GUI_GRID_CENTER_H;
        };
        class JM_VerticalDivider: RscText
        {
            idc = 1001;
            x = 16.3 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X;
            y = -0.5 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y;
            w = 0.333333 * GUI_GRID_CENTER_W;
            h = 26.7 * GUI_GRID_CENTER_H;
            colorBackground[] = {1,0.8,0.2,1};
            colorActive[] = {1,0.8,0.2,1};
        };
        class JM_MissionTime: RscStructuredText
        {
            idc = 1105;
            x = 0.33 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X;
            y = 27.3 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y;
            w = 15.4167 * GUI_GRID_CENTER_W;
            h = 1.8 * GUI_GRID_CENTER_H;
        };
    };
};
