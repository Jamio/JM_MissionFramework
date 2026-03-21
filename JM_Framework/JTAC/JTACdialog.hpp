class JM_JTAC_Dialog {
    idd = 1234;
    movingEnable = 1;
    enableSimulation = 1;
    onLoad = "_this call JM_JTAC_fnc_onDialogLoad";


    class controls {

            class Background: RscPicture
            {
                idc = 1200;

                text = "JM_Framework\JTAC\ui\bg_ww2_ca.paa";
                x = -13 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X;
                y = -3.5 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y;
                w = 70 * GUI_GRID_CENTER_W;
                h = 33.5 * GUI_GRID_CENTER_H;
                colorBackground[] = {-1,-1,-1,0.1};
            };
            class Missions: RscListbox
            {
                idc = 1500;

                x = 5 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X;
                y = 11 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y;
                w = 11 * GUI_GRID_CENTER_W;
                h = 7 * GUI_GRID_CENTER_H;
            };
            class GridEdit: RscEdit
            {
                idc = 1502;

                x = 4.92 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X;
                y = 19.5 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y;
                w = 11.1 * GUI_GRID_CENTER_W;
                h = 1 * GUI_GRID_CENTER_H;
                colorBackground[] = {1,1,1,0.7};
                tooltip = "Enter a 6-digit grid ref or use 'Select Target'"; //--- ToDo: Localize;
            };
            class Confirm: RscButton
            {
                idc = 1503;
                action = "[] call JM_JTAC_fnc_onConfirm";

                text = "TRANSMIT"; //--- ToDo: Localize;
                x = 5 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X;
                y = 21 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y;
                w = 5 * GUI_GRID_CENTER_W;
                h = 1 * GUI_GRID_CENTER_H;
                colorBackground[] = {-1,0.5,-1,1};
                tooltip = "Transmit current fire mission for designated location"; //--- ToDo: Localize;
            };
            class Cancel: RscButton
            {
                idc = 1504;
                action = "closeDialog 0";

                text = "CANCEL"; //--- ToDo: Localize;
                x = 10.5 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X;
                y = 21 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y;
                w = 5.5 * GUI_GRID_CENTER_W;
                h = 1 * GUI_GRID_CENTER_H;
                colorBackground[] = {0.5,-1,-1,0.5};
                tooltip = "Abort fire mission"; //--- ToDo: Localize;
            };
            class Map: RscMapControl
            {
                idc = 1501;

                x = 21 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X;
                y = 10.5 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y;
                w = 14.6 * GUI_GRID_CENTER_W;
                h = 11.1 * GUI_GRID_CENTER_H;
                colorBackground[] = {-1,-1,-1,1};
            };
            class SelectPos: RscButton
            {
                idc = 1602;
                action = "systemChat 'Select position on map'; [] call JM_JTAC_fnc_selectTargetMap;";

                text = "SELECT TARGET"; //--- ToDo: Localize;
                x = 5 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X;
                y = 18.3 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y;
                w = 4 * GUI_GRID_CENTER_W;
                h = 1 * GUI_GRID_CENTER_H;
                tooltip = "Select Target via the map"; //--- ToDo: Localize;
                sizeEx = 0.8 * GUI_GRID_CENTER_H;
            };
            class Ingress: RscCombo
            {
                idc = 2100;
                x = 10.5 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X;
                y = 18.3 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y;
                w = 5.5 * GUI_GRID_CENTER_W;
                h = 1 * GUI_GRID_CENTER_H;
                tooltip = "Select ingress direction for air support"; //--- ToDo: Localize;
            };
    };
};




// ["40 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X","10.5 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y","14.6 * GUI_GRID_CENTER_W","11.1 * GUI_GRID_CENTER_H"]

