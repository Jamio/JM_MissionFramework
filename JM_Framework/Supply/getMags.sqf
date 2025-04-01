 /*
    Use this script in the editor (before playing the mission)
    to extract gear from all editor-placed playable units.

	You can then paste the results below.
*/
 
 /*
 
private _units = playableUnits + switchableUnits; 
 
private _prim = []; 
private _sec = []; 
private _hg = []; 
private _gr = []; 
 
{ 
    private _pMags = primaryWeaponMagazine _x; 
    private _sMags = secondaryWeaponMagazine _x; 
    private _hMags = handgunMagazine _x; 
 
    { _prim pushBackUnique _x } forEach _pMags; 
    { _sec pushBackUnique _x } forEach _sMags; 
    { _hg pushBackUnique _x } forEach _hMags; 
 
	private _thrown = throwables _x apply { _x select 0 };
	{ _gr pushBackUnique _x } forEach _thrown;
 
} forEach _units; 
  
private _output = [ 
    "// Auto-generated resupply config", 
    format ["JM_PrimMags = %1;", _prim], 
    format ["JM_SecMags = %1;", _sec], 
    format ["JM_HGmags  = %1;", _hg], 
    format ["JM_Grenades = %1;", _gr] 
] joinString endl; 
 
copyToClipboard _output; 
hint "Resupply arrays copied to clipboard!"; 


*/

// Auto-generated resupply config
JM_PrimMags = ["30rnd_762x39_AK12_Arid_Mag_F","30Rnd_556x45_Stanag_red","1Rnd_HE_Grenade_shell","200Rnd_556x45_Box_Red_F"];
JM_SecMags = ["MRAWS_HEAT55_F"];
JM_HGmags  = ["17Rnd_9x21_Mag"];
JM_Grenades = ["HandGrenade","SmokeShell","SmokeShellGreen","SmokeShellOrange","SmokeShellBlue"];