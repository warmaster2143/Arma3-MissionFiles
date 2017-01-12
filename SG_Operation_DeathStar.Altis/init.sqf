//////////////Scripts//////////////////////////////
execVM "scripts\NRE_earplugs.sqf";
execVM "JTS_SQUAD\Functions.sqf";
call compile preprocessFile "scripts\=BTC=_revive\=BTC=_revive_init.sqf";		// revive

//////////////Mission System/////////////////////////
waitUntil {time > 20};
VehicleSMUnits = ["O_G_Offroad_01_armed_F","O_APC_Tracked_02_cannon_F","O_MBT_02_arty_F","O_MRAP_02_F","O_APC_Wheeled_02_rcws_F"];
StaticSMweps = ["O_GMG_01_F","O_HMG_01_F"];

God_fnc_Skill ={
_grp = _this select 0;	
_leader = leader _grp;
_leader setskill random 1;
	{
	_x setskill ["aimingAccuracy",random 1];
	_x setskill ["spotDistance",random 1];
	_x setskill ["spotTime",random 1];
	_x setskill ["courage",random 1];
	_x setskill ["commanding",random 1];
	_x setskill ["aimingShake",random 1];
	_x setskill ["aimingSpeed",random 1];
	} foreach units _grp;
};

fnc_CreateStatic =
{	
	_amount = _this select 0;
	for "_i" from 0 to _amount do
	{
		_StaticWep = StaticSMweps call BIS_fnc_selectRandom;
		 _positionStatic = [_position,random 10,800, 1, 0, 60 * (pi / 180), 0, []] call BIS_fnc_findSafePos;
		_Static = _staticWep createVehicle _positionStatic;
		_CrewMan = "O_Soldier_F" createVehicle (position _Static);
		_CrewMan assignAsGunner _Static;
		[_CrewMan] orderGetIn true;
	};
};
	

sidemissionup = false;
publicVariable "sidemissionup";

while {true} do
{
	mission = floor(random 3);
	publicVariable "mission";

	sideMissionUp = true;
	publicVariable "sidemissionup";

	switch (mission) do
	{
		case 0: { execVM "missions\Objectives\AUSMD_killOfficer.sqf"; };
		case 1: { execVM "missions\Objectives\AUSMD_killAmmo.sqf"; };
		case 2: { execVM "missions\Objectives\AUSMD_destoryVehicle.sqf"; };
	};
	
	waitUntil {!sidemissionup};
	sleep 20;
};