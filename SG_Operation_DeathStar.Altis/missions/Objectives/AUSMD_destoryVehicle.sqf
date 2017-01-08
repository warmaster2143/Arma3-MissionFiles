SMunits = [];
sidemissionup = true;
publicVariable "sidemissionup";
sleep 3;

_completehint = 
"<t align='center'><t size='2.2'>Side Mission</t><br/><t size='1.5' color='#00B2EE'>COMPLETE</t><br/>____________________<br/>Fantastic job, lads! The OPFOR stationed on the island won't last long if you keep that up!<br/><br/>Focus on the main objective for now; we'll relay this success to the intel team and see if there's anything else you can do for us. We'll get back to you in 15 - 30 minutes.</t>";


_SMhint = "<t align='center'><t size='2.2'>New Side Mission</t><br/><t size='1.5' color='#00B2EE'>Destory Vehicle</t><br/>____________________<br/>OPFOR units have deployed a vehicle with some special equipment to the battlefield. We have never seen this equipment used before and we must not let them keep that technology! Destory that vehicle at all costs!</t>";
hint parsetext _SMhint;

_position = [[9938,18283,131],random 1000,10000, 1, 0, 60 * (pi / 180), 0, []] call BIS_fnc_findSafePos;

_Vehicle = vehicleSMunits call BIS_fnc_selectRandom;

sideObj = _Vehicle createVehicle _position;
SMunits = SMunits + [sideObj];
sideObj setDir random 360;
_random = (round(random 3) + 1);

for "_i" from 0 to _random do 
{
	_nposition = [_position,random 50,1000, 1, 0, 60 * (pi / 180), 0, []] call BIS_fnc_findSafePos;
	_spawnGroup = [_nposition, EAST, (configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> "OIA_InfTeam")] call BIS_fnc_spawnGroup;
	[_spawnGroup, getpos sideObj,500 + random 1000] call BIS_fnc_taskPatrol;
	SMunits = SMunits + (units _spawnGroup);
	[_spawnGroup] call God_fnc_Skill;
	sleep 1;
};

[round(random 4) + 2] call fnc_CreateStatic;

_nposition = [_position,random random 10,50, 1, 0, 60 * (pi / 180), 0, []] call BIS_fnc_findSafePos;
_spawnGroup = [_nposition, EAST, (configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> "OIA_InfTeam")] call BIS_fnc_spawnGroup;
[_spawnGroup, getpos sideObj] call BIS_fnc_taskDefend;
[_spawnGroup] call God_fnc_Skill;
SMunits = SMunits + (units _spawnGroup);

"sideMarker" setMarkerPos (position sideobj);
"sideMarker" setMarkerText "Destory Vehicle";
"sideMarker" setMarkerColor "ColorBlack";
"sideMarker" setMarkerAlpha 1;
"sideMarker" setmarkerType "mil_objective";
"sideMarker" setMarkerSize [1, 1];
_txt2 = format ["OPFOR units have deployed a %1 with some special equipment to the battlefield. We have never seen this equipment used before and we must not let them keep that technology! It is suspected to be at map grid %2.",getText(configFile >> "cfgVehicles" >> (typeOf sideObj) >> "displayName"), mapGridPosition sideObj];
	
killAmmoTask = player createSimpleTask ["killAmmoTask"];
	
killAmmoTask setSimpleTaskDescription [_txt2,"Side Mission",""];
killAmmoTask setTaskState "Assigned";
	
player setCurrentTask killAmmoTask;
waitUntil {!alive sideObj};
"sideMarker" setMarkerPos [0,0,0];
"sideMarker" setmarkertext "";
"sideMarker" setmarkeralpha 0;
killAmmoTask setTaskState "Succeeded";
	
player removeSimpleTask killAmmoTask;
hint parsetext _completehint;
sidemissionup = false;
publicVariable "sidemissionup";
sleep 120;
{deletevehicle _x} foreach SMunits;
SMunits = [];
