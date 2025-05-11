/*
HOW TO USE:

1. Drop script into scripts folder

2. Create and name JM_engineerVehicleClass and JM_refillObject in mission - CC1 is the moveable container for building around, RC1 is the static refill point

3. Check JM_maxBudget and refillBudget are suitable for mission. Check distance from CC1 is ok.

4. Alter each preset and array for each preset to your liking.

5. Compile script in init.sqf with: [compileScript ["JM_Framework\Fortify\init_fortify.sqf"]] call CBA_fnc_directCall;

6. Check that script location matches - by default this goes in a folder called cvo/logistics

*/

if !(JM_Fortify) exitWith {systemChat "[JM FORTIFY] is  not active";};



// Default Fortify Budget, Objects and Prices

if (isServer) then {
[west, JM_maxBudget, [
				["SandbagBarricade_02_decal", 10]
]] call ace_fortify_fnc_registerObjects;
};



// ################################################
// 2. Additional Conditions to use Fortify


[{
	params ["_unit", "_object", "_cost"];

	private _condition2 = (_unit) distance JM_engineerVehicleClass <150; 	// Checks if player is near to the Construction Crate

	private _case2 = if (_condition2) then {true}
		else {"You are too far away from supplies" remoteExec ["hint", _unit];false};

	_case2;
}] call ace_fortify_fnc_addDeployHandler;


// ################################################
// 3. Replenish building supplies when fortify_vehicle is close enough to JM_refillObject, current maximum loaded: JM_maxBudget

private _code = {
	[{
		[
			"Replenishing Fortify Budget",	// Title of progressBar
			10,								// Duration of progressBar in secounds
			{true},							// Condition, will check every frame
			{
				_currentBudget = [west] call ace_fortify_fnc_getBudget;
				if (_currentBudget > (JM_maxBudget - JM_refillBudget)) then {							// if current Fortify Budget is more then MAX - refillQuantity, top off until max.
					[west,(JM_maxBudget - _currentBudget), true] call ace_fortify_fnc_updateBudget;
				} else { [west, JM_refillBudget, true] call ace_fortify_fnc_updateBudget; }			// if current Fortify Budget is less then MAX - RefillQuantity, add refillQuantity.
			}								// codeblock to be executed on completion
		] call CBA_fnc_progressBar;			// Executing a CBA progressBar from an Ace Interaction results in crash. Delay execution by 1 frame!!!
	}] call CBA_fnc_execNextFrame;			// <- this will delay the execution by 1 Frame.
}; 											// This is the code you want the interaction to execute.


// Here we create the action which we later attach to something
_cvo_Fort_refillVehicle = [
	"CVO_Fort_refillVehicle",				// Action Name
	"Replenish Building Supplies",		// Name for the ACE Interaction Menu
	"\A3\ui_f\data\igui\cfg\simpleTasks\types\refuel_ca.paa",
	_code,									// the code you're executing
	{
	(110 > JM_engineerVehicleClass distance JM_refillObject) && ([west] call ace_fortify_fnc_getBudget < JM_maxBudget);
	}										// Condition for action to be shown:
] call ace_interact_menu_fnc_createAction;

// Here we define where we want this action that we created to be attached to
[
	JM_refillObject,						// Object the action should be assigned to
	0,										// Type of action, 0 for action, 1 for self-actionIDs
	["ACE_MainActions"],					// Parent path of the new action <Array>
	_cvo_Fort_refillVehicle							// The Ace_action to be attached
] call ace_interact_menu_fnc_addActionToObject;		// Alternative: ace_interact_menu_fnc_addActionToObject




// ################################################
// 4. Change Presets to have several short lists instead of 1 long.

// Initial Node

_action = ["CVO_Fort_Node","Change Fortify Blueprints","\A3\ui_f\data\igui\cfg\simpleTasks\types\box_ca.paa",{""},{true}] call ace_interact_menu_fnc_createAction;
[JM_engineerVehicleClass, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject;


// -> Sandbag Preset
private _code_p1 = {
	[{
		[
			"Switching Fortify Blueprints",	// Title of progressBar
			3,								// Duration of progressBar in secounds
			{true},							// Condition, will check every frame
			{
				_currentBudget = [west] call ace_fortify_fnc_getBudget;

				[west, _currentBudget, 
                JM_fortList1
				] remoteExec  ["ace_fortify_fnc_registerObjects", 2];
			}								// codeblock to be executed on completion
		] call CBA_fnc_progressBar;			// Executing a CBA progressBar from an Ace Interaction results in crash. Delay execution by 1 frame!!!
	}] call CBA_fnc_execNextFrame;			// <- this will delay the execution by 1 Frame.
}; 											// This is the code you want the interaction to execute.


_cvo_Fort_preset1 = [
	"CVO_Fort_preset1",						// Action Name
	JM_fortName1,				// Name for the ACE Interaction Menu
	"\A3\ui_f\data\igui\cfg\simpleTasks\types\documents_ca.paa",										// Statement - i have no fucking clue what that is supposed to mean
	_code_p1,									// the code you're executing
	{true}										// Condition for action to be shown:
] call ace_interact_menu_fnc_createAction;


// -> Sandbag Preset
private _code_p2 = {
	[{
		[
			"Switching Fortify Blueprints",	// Title of progressBar
			3,								// Duration of progressBar in secounds
			{true},							// Condition, will check every frame
			{
				_currentBudget = [west] call ace_fortify_fnc_getBudget;

				[west, _currentBudget,
                JM_fortList2
				] remoteExec ["ace_fortify_fnc_registerObjects", 2];
			}								// codeblock to be executed on completion
		] call CBA_fnc_progressBar;			// Executing a CBA progressBar from an Ace Interaction results in crash. Delay execution by 1 frame!!!
	}] call CBA_fnc_execNextFrame;			// <- this will delay the execution by 1 Frame.
}; 											// This is the code you want the interaction to execute.


// Here we create the action which we later attach to something
_cvo_Fort_preset2 = [
	"CVO_Fort_preset2",						// Action Name
	JM_fortName2,				// Name for the ACE Interaction Menu
	"\A3\ui_f\data\igui\cfg\simpleTasks\types\documents_ca.paa",										// Statement - i have no fucking clue what that is supposed to mean
	_code_p2,									// the code you're executing
	{true}										// Condition for action to be shown:
] call ace_interact_menu_fnc_createAction;




// Here we define where we want this action that we created to be attached to
{[
	JM_engineerVehicleClass,						// Object the action should be assigned to
	0,												// Type of action, 0 for action, 1 for self-actionIDs
	["ACE_MainActions","CVO_Fort_Node"],			// Parent path of the new action <Array>
	_x												// The Ace_action to be attached
] call ace_interact_menu_fnc_addActionToObject;		// Alternative: ace_interact_menu_fnc_addActionToObject
} forEach [_cvo_Fort_preset1,_cvo_Fort_preset2];

systemChat "[JM FORTIFY] is active";
