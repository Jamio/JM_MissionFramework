////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT START (by SPC. Jamio, v1.063, #Hexisy)
////////////////////////////////////////////////////////

class JM_RedeployDialog {
    idd = 9010; // Unique ID for this dialog
    movingEnable = false;
    enableSimulation = true;

	class controlsBackground {

		class JM_BackgroundBox: RscText
		{
			idc = 1000;
			x = 0.2 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X;
			y = 0.2 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y;
			w = 16.7 * GUI_GRID_CENTER_W;
			h = 24.6 * GUI_GRID_CENTER_H;
			colorBackground[] = {0.2,0.2,0.2,1};
		};

	};

	class controls {
		class JM_pltRallyButton: RscButton
		{
			idc = 1600;
			colorBackgroundActive[] = {1,0.86,0.2,1};
			colorFocused[] = {1,0.86,0.2,1};
			shadow = 0;
			font = "PuristaBold";
			default = "true";
			action = "[] call JM_RallyPoint_fnc_teleportToSelectedRally;";

			text = "Deploy To Rally"; //--- ToDo: Localize;
			x = 0.9 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X;
			y = 12 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y;
			w = 15.4 * GUI_GRID_CENTER_W;
			h = 2 * GUI_GRID_CENTER_H;
			colorText[] = {0,0,0,1};
			colorBackground[] = {1,1,1,1};
		};
		class JM_toTeam: RscButton
		{
			idc = 1605;
			colorBackgroundActive[] = {1,0.86,0.2,1};
			colorFocused[] = {1,0.86,0.2,1};
			shadow = 0;
			font = "PuristaBold";
			action = "[] call JM_RallyPoint_fnc_teleportToSquad;";

			text = "Deploy to Player"; //--- ToDo: Localize;
			x = 0.9 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X;
			y = 20.1 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y;
			w = 15.4 * GUI_GRID_CENTER_W;
			h = 2 * GUI_GRID_CENTER_H;
			colorText[] = {0,0,0,1};
			colorBackground[] = {1,1,1,1};
		};
		class JM_reinsertRequest: RscButton
		{
			idc = 1606;
			colorBackgroundActive[] = {1,0.86,0.2,1};
			colorFocused[] = {1,0.86,0.2,1};
			shadow = 0;
			font = "PuristaBold";
			action = "closeDialog 0; [] execVM 'JM_Framework\RallyPoint\reinsertRequest.sqf';";

			text = "Request Reinsertion"; //--- ToDo: Localize;
			x = 0.9 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X;
			y = 22.4 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y;
			w = 15.4 * GUI_GRID_CENTER_W;
			h = 2 * GUI_GRID_CENTER_H;
			colorText[] = {0,0,0,1};
			colorBackground[] = {1,1,1,1};
		};
		class JM_choose: RscText
		{
			idc = 1001;
			style = "ST_CENTER";
			font = "PuristaBold";

			text = "REDEPLOYMENT"; //--- ToDo: Localize;
			x = 3.5 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X;
			y = 1 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y;
			w = 12 * GUI_GRID_CENTER_W;
			h = 2 * GUI_GRID_CENTER_H;
			colorText[] = {1,0.86,0.2,1};
			colorBackground[] = {1,1,1,0};
			sizeEx = 2 * GUI_GRID_CENTER_H;
		};
		class JM_MapPreview: RscMapControl
		{
			idc = 1200;

			x = 17.5 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X;
			y = 0.3 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y;
			w = 22 * GUI_GRID_CENTER_W;
			h = 24.4 * GUI_GRID_CENTER_H;
		};
		class JM_rallyList: RscListbox
		{
			idc = 1500;
			x = 0.9 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X;
			y = 4.7 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y;
			w = 15.4333 * GUI_GRID_CENTER_W;
			h = 7.1 * GUI_GRID_CENTER_H;
		};
		class JM_playerList: RscListbox
		{
			idc = 1501;
			x = 0.9 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X;
			y = 14.5 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y;
			w = 15.4333 * GUI_GRID_CENTER_W;
			h = 5.3 * GUI_GRID_CENTER_H;
		};
	};

};
////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT END
////////////////////////////////////////////////////////