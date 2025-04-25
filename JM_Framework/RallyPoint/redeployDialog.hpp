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
			colorBackground[] = {-1,-1,-1,0.85};
		};

	};

	class controls {
		class JM_pltRallyButton: RscButton
		{
			idc = 1600;
			text = "Platoon Rally"; //--- ToDo: Localize;
			x = 0.9 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X;
			y = 4 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y;
			w = 15.4 * GUI_GRID_CENTER_W;
			h = 2 * GUI_GRID_CENTER_H;
			colorBackground[] = {1,1,1,1};           // Default (white)
			colorBackgroundActive[] = {1,0.86,0.2,1};      // Hover (yellow)
			colorFocused[] = {1,0.86,0.2,1};              // Focus (also yellow)
			colorDisabled[] = {0.4,0.4,0.4,1};       // Optional: disabled button state
			colorText[] = {0,0,0,1};                 // Text color (black)
			shadow = 0;
			font = "PuristaBold";
			default = true;
			action = "closeDialog 0; [MF_Prp] execVM 'JM_Framework\RallyPoint\teleport.sqf';";

		};
		class JM_sqdRally1: RscButton
		{
			idc = 1601;
			text = "Squad Rally 1"; //--- ToDo: Localize;
			x = 0.9 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X;
			y = 6.5 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y;
			w = 15.4 * GUI_GRID_CENTER_W;
			h = 2 * GUI_GRID_CENTER_H;
			colorBackground[] = {1,1,1,1};
			colorBackgroundActive[] = {1,0.86,0.2,1};
			colorFocused[] = {1,0.86,0.2,1};
			colorDisabled[] = {0.4,0.4,0.4,1};
			colorText[] = {0,0,0,1};
			shadow = 0;
			font = "PuristaBold";
			action = "closeDialog 0; [MF_Srp1] execVM 'JM_Framework\RallyPoint\teleport.sqf';";
		};
		class JM_sqdRally2: RscButton
		{
			idc = 1602;
			text = "Squad Rally 2"; //--- ToDo: Localize;
			x = 0.9 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X;
			y = 9 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y;
			w = 15.4 * GUI_GRID_CENTER_W;
			h = 2 * GUI_GRID_CENTER_H;
			colorBackground[] = {1,1,1,1};
			colorBackgroundActive[] = {1,0.86,0.2,1};
			colorFocused[] = {1,0.86,0.2,1};
			colorDisabled[] = {0.4,0.4,0.4,1};
			colorText[] = {0,0,0,1};
			shadow = 0;
			font = "PuristaBold";
			action = "closeDialog 0; [MF_Srp2] execVM 'JM_Framework\RallyPoint\teleport.sqf';";
		};
		class JM_sqdRally3: RscButton
		{
			idc = 1603;
			text = "Squad Rally 3"; //--- ToDo: Localize;
			x = 0.9 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X;
			y = 11.5 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y;
			w = 15.4 * GUI_GRID_CENTER_W;
			h = 2 * GUI_GRID_CENTER_H;
			colorBackground[] = {1,1,1,1};
			colorBackgroundActive[] = {1,0.86,0.2,1};
			colorFocused[] = {1,0.86,0.2,1};
			colorDisabled[] = {0.4,0.4,0.4,1};
			colorText[] = {0,0,0,1};
			shadow = 0;
			font = "PuristaBold";
			action = "closeDialog 0; [MF_Srp3] execVM 'JM_Framework\RallyPoint\teleport.sqf';";
		};
		class JM_sqdRally4: RscButton
		{
			idc = 1604;
			text = "Squad Rally 4"; //--- ToDo: Localize;
			x = 0.9 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X;
			y = 14 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y;
			w = 15.4 * GUI_GRID_CENTER_W;
			h = 2 * GUI_GRID_CENTER_H;
			colorBackground[] = {1,1,1,1};
			colorBackgroundActive[] = {1,0.86,0.2,1};
			colorFocused[] = {1,0.86,0.2,1};
			colorDisabled[] = {0.4,0.4,0.4,1};
			colorText[] = {0,0,0,1};
			shadow = 0;
			font = "PuristaBold";
			action = "closeDialog 0; [MF_Srp4] execVM 'JM_Framework\RallyPoint\teleport.sqf';";
		};
		class JM_toTeam: RscButton
		{
			idc = 1605;
			text = "To Teammate"; //--- ToDo: Localize;
			x = 0.9 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X;
			y = 16.5 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y;
			w = 15.4 * GUI_GRID_CENTER_W;
			h = 2 * GUI_GRID_CENTER_H;
			colorBackground[] = {1,1,1,1};
			colorBackgroundActive[] = {1,0.86,0.2,1};
			colorFocused[] = {1,0.86,0.2,1};
			colorDisabled[] = {0.4,0.4,0.4,1};
			colorText[] = {0,0,0,1};
			shadow = 0;
			font = "PuristaBold";
			action = "closeDialog 0; [] execVM 'JM_Framework\RallyPoint\teleportToSquad.sqf';";

		};
		class JM_reinsertRequest: RscButton
		{
			idc = 1606;
			text = "Request Reinsertion"; //--- ToDo: Localize;
			x = 0.9 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X;
			y = 19 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y;
			w = 15.4 * GUI_GRID_CENTER_W;
			h = 2 * GUI_GRID_CENTER_H;
			colorBackground[] = {1,1,1,1};
			colorBackgroundActive[] = {1,0.86,0.2,1};
			colorFocused[] = {1,0.86,0.2,1};
			colorDisabled[] = {0.4,0.4,0.4,1};
			colorText[] = {0,0,0,1};
			shadow = 0;
			font = "PuristaBold";
			action = "closeDialog 0; [] execVM 'JM_Framework\RallyPoint\reinsertRequest.sqf';";
		};
		class JM_choose: RscText
		{
			idc = 1001;
			text = "REDEPLOYMENT"; // Fixed typo
			x = 2.5 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X;
			y = 1 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y;
			w = 12 * GUI_GRID_CENTER_W;
			h = 2 * GUI_GRID_CENTER_H;

			style = ST_CENTER; // Center the text
			font = "PuristaBold";
			sizeEx = 2 * GUI_GRID_CENTER_H;
			colorText[] = {1,0.86,0.2,1}; // Yellow
			colorBackground[] = {1,1,1,0}; // Transparent background
		};
		class JM_MapPreview: RscMapControl
		{
			idc = 1200;
			x = 17.5 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X;
			y = 0.3 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y;
			w = 22 * GUI_GRID_CENTER_W;
			h = 24.4 * GUI_GRID_CENTER_H;

		};
	};

};
////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT END
////////////////////////////////////////////////////////