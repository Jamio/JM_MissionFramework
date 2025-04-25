/*
Script name:	jam_earplugs.sqf
Created on:		11.03.2024
Author:			NemesisRE, edited by Jamio
Author website:	

Description:	Adds action to insert/remove Earplugs (toggles).
				Inspired by A3Wasteland132DSOv14.Altis kopfh script

License:		Copyright (C) 2015 Steven "NemesisRE" Köberich

				This program is free software: you can redistribute it and/or modify
				it under the terms of the GNU General Public License as published by
				the Free Software Foundation, either version 3 of the License, or
				(at your option) any later version.

				This program is distributed in the hope that it will be useful,
				but WITHOUT ANY WARRANTY; without even the implied warranty of
				MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
				GNU General Public License for more details.

				You should have received a copy of the GNU General Public License
				along with this program.  If not, see <http://www.gnu.org/licenses/>.


Manual:			Called from init.sqf via:
					execVM "initEarplugs.sqf";
*/

waitUntil {!isNull player}; //to prevent MP / JIP issues

NreEarplugsPath = "JM_Framework\Earplugs\";

if !(JM_Earplugs) exitWith {systemChat "Earplugs not active."};

if (isNil "NreEarplugsActive") then {
	NreEarplugsActive = 0;
	1 fadeSound 1;
	1 fadeRadio 1;
	_id = player addAction [("<t color=""#4db350"">Insert Earplugs</t>"),NreEarplugsPath+"fnc_initEarplugs.sqf","",5,false,true,"",""];
	player setVariable ["NreEarplugsAction", _id];
	// Handle respawn
	player addEventHandler ["Respawn", {
		NreEarplugsActive = 0;
		1 fadeSound 1;
		1 fadeRadio 1;
		_id = (_this select 1) getVariable "NreEarplugsAction";
		(_this select 1) removeAction _id;
		_id = (_this select 0) addAction [("<t color=""#4db350"">Insert Earplugs</t>"),NreEarplugsPath+"fnc_initEarplugs.sqf","",5,false,true,"",""];
		(_this select 0) setVariable ["NreEarplugsAction", _id];
	}];
};

if ( NreEarplugsActive == 1 ) then {
	NreEarplugsActive = 0;
	1 fadeSound 1;
	1 fadeRadio 1;
	hint "Earplugs Removed";
	_id = player getVariable "NreEarplugsAction";
	player removeAction _id;
	_id = player addAction [("<t color=""#4db350"">Insert Earplugs</t>"),NreEarplugsPath+"fnc_initEarplugs.sqf","",5,false,true,"",""];
	player setVariable ["NreEarplugsAction", _id];
} else {
	NreEarplugsActive = 1;
	1 fadeSound 0.1;
	1 fadeRadio 0.1;
	hint "Earplugs Inserted";
	_id = player getVariable "NreEarplugsAction";
	player removeAction _id;
	_id = player addAction [("<t color=""#f24141"">Remove Earplugs</t>"),NreEarplugsPath+"fnc_initEarplugs.sqf","",5,false,true,"",""];
	player setVariable ["NreEarplugsAction", _id];
};

