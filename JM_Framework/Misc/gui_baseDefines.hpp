#define GUI_GRID_X (safezoneX)
#define GUI_GRID_Y (safezoneY)
#define GUI_GRID_W (safezoneW / 40)
#define GUI_GRID_H (safezoneH / 25)

// GUI_GRID_CENTER macro for centered grid layout (matches in-game GUI Editor "centered grid" setup)
#define GUI_GRID_CENTER_X (safeZoneX + (safeZoneW - ((safeZoneW / safeZoneH) min 1.2)) / 2)
#define GUI_GRID_CENTER_Y (safeZoneY + (safeZoneH - (((safeZoneW / safeZoneH) min 1.2) / 1.2)) / 2)
#define GUI_GRID_CENTER_W (((safeZoneW / safeZoneH) min 1.2) / 40)
#define GUI_GRID_CENTER_H ((((safeZoneW / safeZoneH) min 1.2) / 1.2) / 25)



// GUI Base Classes (RscText, RscButton, etc.)
class RscText {
    access = 0;
    type = 0;
    idc = -1;
    style = 0; 
    colorBackground[] = {0, 0, 0, 0};
    colorText[] = {1, 1, 1, 1};
    text = "";
    fixedWidth = 0;
    shadow = 1;
    font = "RobotoCondensed";
    sizeEx = "0.04";
};

class RscStructuredText {
    access = 0;
    idc = -1;
    type = 13;
    style = 0;
    colorText[] = {1, 1, 1, 1};
    class Attributes {
        font = "RobotoCondensed";
        color = "#ffffff";
        align = "left";
        shadow = 1;
    };
    font = "RobotoCondensed";
    size = "0.035";
    text = "";
    shadow = 1;
};

class RscPicture
{
	deletable = 0;
	fade = 0;
	access = 0;
	type = 0;
	idc = -1;
	style = 48;
	colorBackground[] = {0,0,0,0};
	colorText[] = {1,1,1,1};
	font = "TahomaB";
	sizeEx = 0;
	lineSpacing = 0;
	text = "";
	fixedWidth = 0;
	shadow = 0;
	x = 0;
	y = 0;
	w = 0.2;
	h = 0.15;
	tooltipColorText[] = {1,1,1,1};
	tooltipColorBox[] = {1,1,1,1};
	tooltipColorShade[] = {0,0,0,0.65};
};

class RscButton {
    access = 0;
    type = 1;
    text = "";
    colorText[] = {1, 1, 1, 1};
    colorDisabled[] = {0.4, 0.4, 0.4, 1};
    colorBackground[] = {0, 0, 0, 0.8};
    colorBackgroundDisabled[] = {};
    colorBackgroundActive[] = {0.2, 0.2, 0.2, 1};
    colorFocused[] = {0.2, 0.2, 0.2, 1};
    colorShadow[] = {0, 0, 0, 0};
    colorBorder[] = {0, 0, 0, 1};
    soundEnter[] = {"", 0.09, 1};
    soundPush[] = {"", 0.0, 0};
    soundClick[] = {"", 0.07, 1};
    soundEscape[] = {"", 0.09, 1};
    style = 2;
    x = 0;
    y = 0;
    w = 0.055589;
    h = 0.039216;
    shadow = 2;
    font = "RobotoCondensed";
    sizeEx = "0.04";
    offsetX = 0.003;
    offsetY = 0.003;
    offsetPressedX = 0.002;
    offsetPressedY = 0.002;
    borderSize = 0;
};

class RscFrame {
    type = 0;
    idc = -1;
    style = 64;
    shadow = 2;
    colorBackground[] = {0, 0, 0, 0}; // transparent background
    colorText[] = {1, 1, 1, 1};       // white frame border
    font = "PuristaMedium";
    sizeEx = 0.03;
    text = "";
    x = 0;
    y = 0;
    w = 0.1;
    h = 0.1;
};

class RscMapControl {
    access = 0;
    type = 101;
    idc = -1;
    style = 48;
    font = "TahomaB";
    sizeEx = 0.04;
    colorBackground[] = {0.969, 0.957, 0.949, 1};
    colorText[] = {0, 0, 0, 1};
    colorSea[] = {0.467, 0.630, 0.851, 0.5};
    colorForest[] = {0.624, 0.78, 0.388, 0.5};
    colorRocks[] = {0, 0, 0, 0.3};
    colorForestBorder[] = {0, 0, 0, 0};
    colorRocksBorder[] = {0, 0, 0, 0};
    colorCountlines[] = {0.572, 0.354, 0.188, 0.25};
    colorCountlinesWater[] = {0.491, 0.577, 0.702, 0.3};
    colorMainCountlines[] = {0.572, 0.354, 0.188, 0.5};
    colorMainCountlinesWater[] = {0.491, 0.577, 0.702, 0.6};
    colorLevels[] = {0.286, 0.177, 0.094, 0.5};
    colorTracks[] = {0.84, 0.76, 0.65, 0.15};
    colorTracksFill[] = {0.84, 0.76, 0.65, 1};
    colorRoads[] = {0.7, 0.7, 0.7, 1};
    colorRoadsFill[] = {1, 1, 1, 1};
    colorMainRoads[] = {0.9, 0.5, 0.3, 1};
    colorMainRoadsFill[] = {1, 0.6, 0.4, 1};
    colorGrid[] = {0.1, 0.1, 0.1, 0.6};
    colorGridMap[] = {0.1, 0.1, 0.1, 0.6};
    colorOutside[] = {0, 0, 0, 1};
    colorPowerLines[] = {0.1, 0.1, 0.1, 1};
    colorNames[] = {0.1, 0.1, 0.1, 0.9};
    colorInactive[] = {1, 1, 1, 0.5};
    colorTextLegend[] = {0, 0, 0, 1};
    colorRailWay[] = {0.8, 0.2, 0, 1};

    widthRailWay = 1;

    maxSatelliteAlpha = 0.85;
    alphaFadeStartScale = 2;
    alphaFadeEndScale = 2;
    moveOnEdges = 1;
    stickX[] = {0.2, ["Gamma", 1, 1]};
    stickY[] = {0.2, ["Gamma", 1, 1]};

    fontLabel = "PuristaMedium";
    sizeExLabel = 0.1;
    fontGrid = "PuristaMedium";
    sizeExGrid = 0.028;
    fontUnits = "PuristaMedium";
    sizeExUnits = 0.1;
    fontNames = "PuristaMedium";
    sizeExNames = 0.028;
    fontInfo = "PuristaMedium";
    sizeExInfo = 0.028;
    fontLevel = "PuristaMedium";
    sizeExLevel = 0.02;

    showCountourInterval = 0;
    scaleMin = 0.001;
    scaleMax = 1;
    scaleDefault = 0.16;

    ptsPerSquareSea = 5;
    ptsPerSquareTxt = 20;
    ptsPerSquareCLn = 10;
    ptsPerSquareExp = 10;
    ptsPerSquareCost = 10;
    ptsPerSquareFor = 9;
    ptsPerSquareForEdge = 9;
    ptsPerSquareRoad = 6;
    ptsPerSquareObj = 9;

    text = "#(argb,8,8,3)color(1,1,1,1)";
    showMarkers = 1;

    class Legend {
        x = 0;
        y = 0;
        w = 0.4;
        h = 0.1;
        font = "RobotoCondensed";
        sizeEx = 0.028;
        colorBackground[] = {1, 1, 1, 0.5};
        color[] = {0, 0, 0, 1};
    };

    class Bush {
	icon = "\A3\ui_f\data\map\mapcontrol\bush_ca.paa";
	color[] = {0.45, 0.64, 0.33, 0.4};
	size = "14/2";
	importance = "0.2 * 14 * 0.05 * 0.05";
	coefMin = 0.25;
	coefMax = 4;
};

class Rock {
	icon = "\A3\ui_f\data\map\mapcontrol\rock_ca.paa";
	color[] = {0.1, 0.1, 0.1, 0.8};
	size = 12;
	importance = "0.5 * 12 * 0.05";
	coefMin = 0.25;
	coefMax = 4;
};

class SmallTree {
	icon = "\A3\ui_f\data\map\mapcontrol\bush_ca.paa";
	color[] = {0.45, 0.64, 0.33, 0.4};
	size = 12;
	importance = "0.6 * 12 * 0.05";
	coefMin = 0.25;
	coefMax = 4;
};

class Tree {
	icon = "\A3\ui_f\data\map\mapcontrol\bush_ca.paa";
	color[] = {0.45, 0.64, 0.33, 0.4};
	size = 12;
	importance = "0.9 * 16 * 0.05";
	coefMin = 0.25;
	coefMax = 4;
};

class Stack {
	icon = "\A3\ui_f\data\map\mapcontrol\stack_ca.paa";
	size = 16;
	importance = "2 * 16 * 0.05";
	coefMin = 0.4;
	coefMax = 2;
	color[] = {0, 0, 0, 1};
};

class Bunker {
	icon = "\A3\ui_f\data\map\mapcontrol\bunker_ca.paa";
	size = 14;
	importance = "1.5 * 14 * 0.05";
	coefMin = 0.25;
	coefMax = 4;
	color[] = {0, 0, 0, 1};
};

class ViewTower {
	icon = "\A3\ui_f\data\map\mapcontrol\viewtower_ca.paa";
	size = 16;
	importance = "2.5 * 16 * 0.05";
	coefMin = 0.5;
	coefMax = 4;
	color[] = {0, 0, 0, 1};
};

class Ruin {
	icon = "\A3\ui_f\data\map\mapcontrol\ruin_ca.paa";
	size = 16;
	importance = "1.2 * 16 * 0.05";
	coefMin = 1;
	coefMax = 4;
	color[] = {0, 0, 0, 1};
};

class Fountain {
	icon = "\A3\ui_f\data\map\mapcontrol\fountain_ca.paa";
	size = 11;
	importance = "1 * 12 * 0.05";
	coefMin = 0.25;
	coefMax = 4;
	color[] = {0, 0, 0, 1};
};

class Fortress {
	icon = "\A3\ui_f\data\map\mapcontrol\bunker_ca.paa";
	size = 16;
	importance = "2 * 16 * 0.05";
	coefMin = 0.25;
	coefMax = 4;
	color[] = {0, 0, 0, 1};
};

class Cross {
	icon = "\A3\ui_f\data\map\mapcontrol\Cross_CA.paa";
	size = 24;
	importance = 1;
	coefMin = 0.85;
	coefMax = 1;
	color[] = {0, 0, 0, 1};
};

class Lighthouse {
	icon = "\A3\ui_f\data\map\mapcontrol\lighthouse_CA.paa";
	size = 24;
	importance = 1;
	coefMin = 0.85;
	coefMax = 1;
	color[] = {1, 1, 1, 1};
};

class Quay {
	icon = "\A3\ui_f\data\map\mapcontrol\quay_CA.paa";
	size = 24;
	importance = 1;
	coefMin = 0.85;
	coefMax = 1;
	color[] = {1, 1, 1, 1};
};

class busstop {
	icon = "\A3\ui_f\data\map\mapcontrol\busstop_CA.paa";
	size = 24;
	importance = 1;
	coefMin = 0.85;
	coefMax = 1;
	color[] = {1, 1, 1, 1};
};

class transmitter {
	icon = "\A3\ui_f\data\map\mapcontrol\transmitter_CA.paa";
	size = 24;
	importance = 1;
	coefMin = 0.85;
	coefMax = 1;
	color[] = {1, 1, 1, 1};
};

class watertower {
	icon = "\A3\ui_f\data\map\mapcontrol\watertower_CA.paa";
	size = 24;
	importance = 1;
	coefMin = 0.85;
	coefMax = 1;
	color[] = {1, 1, 1, 1};
};

class church {
	icon = "\A3\ui_f\data\map\mapcontrol\church_CA.paa";
	size = 24;
	importance = 1;
	coefMin = 0.85;
	coefMax = 1;
	color[] = {1, 1, 1, 1};
};

class Chapel {
	icon = "\A3\ui_f\data\map\mapcontrol\Chapel_CA.paa";
	size = 24;
	importance = 1;
	coefMin = 0.85;
	coefMax = 1;
	color[] = {0, 0, 0, 1};
};

class Fuelstation {
	icon = "\A3\ui_f\data\map\mapcontrol\fuelstation_CA.paa";
	size = 24;
	importance = 1;
	coefMin = 0.85;
	coefMax = 1;
	color[] = {1, 1, 1, 1};
};
class Power {
	icon = "\A3\ui_f\data\map\mapcontrol\power_CA.paa";
	size = 24;
	importance = 1;
	coefMin = 0.85;
	coefMax = 1;
	color[] = {1, 1, 1, 1};
};
class PowerSolar {
	icon = "\A3\ui_f\data\map\mapcontrol\powersolar_CA.paa";
	size = 24;
	importance = 1;
	coefMin = 0.85;
	coefMax = 1;
	color[] = {1, 1, 1, 1};
};
class PowerWind {
	icon = "\A3\ui_f\data\map\mapcontrol\powerwind_CA.paa";
	size = 24;
	importance = 1;
	coefMin = 0.85;
	coefMax = 1;
	color[] = {1, 1, 1, 1};
};
class PowerWave {
	icon = "\A3\ui_f\data\map\mapcontrol\powerwave_CA.paa";
	size = 24;
	importance = 1;
	coefMin = 0.85;
	coefMax = 1;
	color[] = {1, 1, 1, 1};
};
class Tourism {
	icon = "\A3\ui_f\data\map\mapcontrol\tourism_ca.paa";
	size = 16;
	importance = "1 * 16 * 0.05";
	coefMin = 0.7;
	coefMax = 4;
	color[] = {0, 0, 0, 1};
};
class Shipwreck {
	icon = "\A3\ui_f\data\map\mapcontrol\Shipwreck_CA.paa";
	size = 24;
	importance = 1;
	coefMin = 0.85;
	coefMax = 1;
	color[] = {0, 0, 0, 1};
};
class hospital {
	icon = "\A3\ui_f\data\map\mapcontrol\hospital_CA.paa";
	size = 24;
	importance = 1;
	coefMin = 0.85;
	coefMax = 1;
	color[] = {1, 1, 1, 1};
};







    class Waypoint {
        icon = "\A3\ui_f\data\map\mapcontrol\waypoint_ca.paa";
        size = 18;
        importance = 1;
        coefMin = 1;
        coefMax = 1;
        color[] = {1, 1, 1, 1};
    };
    class WaypointCompleted {
        icon = "\A3\ui_f\data\map\mapcontrol\waypointcompleted_ca.paa";
        size = 18;
        importance = 1;
        coefMin = 1;
        coefMax = 1;
        color[] = {1, 1, 1, 1};
    };
	class CustomMark
	{
		icon="\a3\ui_f\data\map\mapcontrol\custommark_ca.paa";
		size=18;
		importance=1;
		coefMin=1;
		coefMax=1;
		color[]={1,1,1,1};
	};
	class Command
	{
		icon="\a3\ui_f\data\map\mapcontrol\waypoint_ca.paa";
		size=18;
		importance=1;
		coefMin=1;
		coefMax=1;
		color[]={1,1,1,1};
	};
    class ActiveMarker 
    {
        color[] = {0, 0, 0, 1};
        size = 50;
    };
    class LineMarker 
    {
        lineWidthThin = 0.008;
        lineWidthThick = 0.014;
        lineDistanceMin = 0.00003;
        lineLengthMin = 5;
    };



};





