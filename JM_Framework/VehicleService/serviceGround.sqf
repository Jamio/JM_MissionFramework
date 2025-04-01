// Script to rearm, refuel and repair GROUND vehicles


/* USAGE:

1. Place trigger for targeted SIDE, PRESENT and REPEATABLE

2. Place following into Condition:

		call{{_x iskindof "landvehicle" && speed _x < 1} count thislist > 0  };

3. Place following into Activation:

		call{_handle = [(thisList select 0)] execVM "JM_Framework\VehicleService\ServiceGround.sqf";}

*/ 



private ["_veh","_vehType"];
_veh = _this select 0;
_vehType = getText(configFile>>"CfgVehicles">>typeOf _veh>>"DisplayName");

if ((_veh isKindOf "landvehicle") && (driver _veh == player)) exitWith {

	_veh sidechat format ["Servicing %1.", _vehType];
	sleep 3;

	_veh setVehicleAmmo 1;
	_veh sidechat format ["%1 Rearmed.", _vehType];
	sleep 3;

	_veh setDamage 0;
	_veh sidechat format ["%1 Repaired.", _vehType];
	sleep 3;

	_veh setFuel 1;
	_veh sidechat format ["%1 Refueled.", _vehType];
	sleep 2;


	_veh sidechat format ["Service Complete", _vehType];

};