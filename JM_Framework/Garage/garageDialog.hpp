class JM_Garage_Dialog {
    idd = 9100;
    movingEnable = false;
    enableSimulation = true;
    class controlsBackground {

    class RscText_1000: RscText
    {
        idc = 1000;
        x = 4 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X;
        y = 0.5 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y;
        w = 17 * GUI_GRID_CENTER_W;
        h = 24 * GUI_GRID_CENTER_H;
        colorBackground[] = {0.4,0.4,0.4,1};
    };

    };
    class controls {
        

    class VehicleListBox: RscListbox
    {
        idc = 1500;
        x = 5 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X;
        y = 5 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y;
        w = 15.1 * GUI_GRID_CENTER_W;
        h = 12 * GUI_GRID_CENTER_H;
        font = "PuristaMedium";
        onLBSelChanged = "_this call JM_Garage_fnc_updatePreview;";
    };
    class GarageTitle: RscStructuredText
    {
        idc = 1100;
        x = 6 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X;
        y = 1.5 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y;
        w = 13.1 * GUI_GRID_CENTER_W;
        h = 2.5 * GUI_GRID_CENTER_H;
        text = "GARAGE";
        class Attributes
        {
            font = "PuristaSemiBold";
            color ="#ffdb33";
            align = "center";
            shadow = 0;
            size = 3;
        };
    };
    class SpawnButton_1: RscButton
    {
        idc = 1600;
        x = 6 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X;
        y = 19 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y;
        w = 13 * GUI_GRID_CENTER_W;
        h = 2.5 * GUI_GRID_CENTER_H;
        text = "SPAWN VEHICLE";
        font = "PuristaSemiBold";
        sizeEx = 1 * GUI_GRID_CENTER_H; // Controls font size
        colorText[] = {0,0,0,1}; // White text
        colorBackground[] = {1,1,1,1};
		colorBackgroundActive[] = {1,0.86,0.2,1};
        action = "[] call JM_Garage_fnc_spawnVehicle;";
    };
    class PreviewImg: RscPicture
    {
        idc = 1200;
        text = "#(argb,8,8,3)color(1,1,1,1)";
        x = 22 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X;
        y = 5 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y;
        w = 14 * GUI_GRID_CENTER_W;
        h = 9 * GUI_GRID_CENTER_H;
    };

    };

};

