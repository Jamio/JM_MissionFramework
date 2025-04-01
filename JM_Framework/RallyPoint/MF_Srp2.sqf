sleep 3;

_unit = _this select 0;

_westsquadRP2 = ["westsquad_rp2","Deploy Squad RP","z\ace\addons\flags\data\icons\carry\white_carry_icon.paa",
{
_num = player nearEntities ['Man',15]; 
	if(count _num >2) then
		{
			[player] call ace_common_fnc_goKneeling; [player, "AinvPknlMstpSnonWnonDnon_medic_1",1] call ace_common_fnc_doAnimation;
			[10,[],{MF_Srp2 setVehiclePosition [(player modelToWorld[0,2,0]), [],0.5, "CAN_COLLIDE"]; hint "Rally Point Deployed"},{hint "Deploying interupted"},"Deploying Rally point"] call ace_common_fnc_progressBar
		} 
	else 
		{
			hint 'Need more allies nearby to deploy Rally Point'
		}
},{JM_Rally}] call ace_interact_menu_fnc_createAction;

[_unit, 1, ["ACE_SelfActions"], _westsquadRP2] call ace_interact_menu_fnc_addActionToObject;
