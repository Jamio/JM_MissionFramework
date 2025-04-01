
sleep 10;

// Adds Platoon Rally Point deployment ability to all players when they become team lead.
_WplatoonRP = ["Wplatoon_rp","Deploy Platoon RP","z\ace\addons\flags\data\icons\carry\white_carry_icon.paa",
	{
	_num = player nearEntities ['Man',15];
	if(leader player == player) then
		{
			if(count _num >2) then
				{
					[player] call ace_common_fnc_goKneeling; [player, "AinvPknlMstpSnonWnonDnon_medic_1",1] call ace_common_fnc_doAnimation;
					[20,[],{MF_Prp setVehiclePosition [(player modelToWorld[0,2,0]), [],0.5, "CAN_COLLIDE"]; MF_Srp1 setVehiclePosition [(player modelToWorld[1.5,1.5,0]), [],0.2, "CAN_COLLIDE"]; MF_Srp2 setVehiclePosition [(player modelToWorld[-1.5,3,0]), [],0.2, "CAN_COLLIDE"]; MF_Srp3 setVehiclePosition [(player modelToWorld[-1.5,1,0]), [],0.2, "CAN_COLLIDE"]; MF_Srp4 setVehiclePosition [(player modelToWorld[-1.5,4,0]), [],0.2, "CAN_COLLIDE"]; hint "Rally Point Deployed";"RPMARK_1" setmarkerpos player;},{hint "Deploying interrupted"},"Deploying Rally point"] call ace_common_fnc_progressBar
				}
			else
				{
					hint 'Need more allies nearby to deploy Rally Point'
				}
		}
	else
		{
			hint 'Become the Team leader via ACE interactions and try again'
		}
	},{JM_Rally}] call ace_interact_menu_fnc_createAction;

[player, 1, ["ACE_SelfActions"], _WplatoonRP] call ace_interact_menu_fnc_addActionToObject;