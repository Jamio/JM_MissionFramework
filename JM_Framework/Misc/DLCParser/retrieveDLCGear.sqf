// *****************************************************************************
//
// This bit of code goes through every bit of gear loaded in your game, and checks if it requires a DLC.
// The output is then copied to your clipboard, which you can use to save in a text file.
// You will then need to drag and drop that text file onto the convert_dlc_output.bat included in the JM_Framework\Misc\DLCParser folder.
// The resulting output will be a nested array
//
// *****************************************************************************

// use unicode to prevent export error 
forceUnicode 0; 
 
// 0: personal equipments 1: vehicles 
private _mode = 0; 
 
// create hashmap to check looked models 
private _lookedModels = createHashMap; 
 
// get classes 
private "_classes"; 
if (_mode == 0) then { 
    // get weapons, equipments, glasses, bags (in CfgVehicles) 
    _classes = ( 
        toString { 
            getNumber (_x >> 'scope') == 2 && 
            (([configName _x] call BIS_fnc_baseWeapon) == configName _x) && 
            getNumber (_x >> 'type') != 65536 && 
            !('UnknownEquipment' in (configName _x call BIS_fnc_itemType)) 
        } configClasses (configFile >> "CfgWeapons") 
    ) + 
    ("getNumber (_x >> 'scope') == 2" configClasses (configFile >> "CfgGlasses")) + 
    ("getNumber (_x >> 'scope') == 2 && configName _x isKindOf 'Bag_Base'" configClasses (configFile >> "CfgVehicles")); 
}; 
if (_mode == 1) then { 
    // get vehicles, except Men 
    _classes = ("getNumber (_x >> 'scope') == 2 && 
    (configName _x isKindOf 'AllVehicles' && 
    !(configName _x isKindOf 'Man'))" 
    configClasses (configFile >> "CfgVehicles")); 
}; 
private _data = _classes apply { 
    private _class = configName _x; 
    private _model = toLower (call { 
        // check if the thing is a uniform 
        if ((getNumber (_x >> "itemInfo" >> "type")) == 801) exitWith { 
            getText (_x >> "itemInfo" >> "uniformClass") 
        }; 
        // normalize model path to prevent errors 
        private _split = (getText (_x >> "model") splitString "\"); 
        if ((count _split >= 2) && { !(".p3d" in toLower (_split # (count _split-1))) }) then { 
            _split set [count _split -1, (_split # (count _split-1)) + ".p3d"]; 
        }; 
        (_split joinString "\") 
    }); 
 
    // get DLC info per items 
    if (isNil { _lookedModels get _model }) then { 
        systemChat _class; 
 
        // create a simple object and check the DLC via getObjectDLC 
        private _obj = createSimpleObject [_model, [0, 0, 0]]; 
        private _dlc = getObjectDLC _obj; 
 
        // and remove the object. bye-bye 
        deleteVehicle _obj; 
 
        // if it is a part of the base game, -1, otherwise DLC id 
        if (isNil "_dlc") then { 
            _lookedModels set [_model, -1]; 
            [_x, -1] 
        } else { 
            _lookedModels set [_model, _dlc]; 
            [_x, _dlc] 
        }; 
    } else { 
        // Skip the generation if the model is already checked 
        systemChat ("simple object generate skipped: " + _class); 
        [_x, _lookedModels get _model] 
    }; 
}; 
 
// return value preparation 
private _return = [ 
    '{| class="wikitable sortable"', 
    '|-' 
]; 
if (_mode == 0) then { 
    _return pushBack '! Type' 
} else { 
    _return pushBack '! Faction' 
}; 
_return append [ 
    '! classname', 
    '! displayName', 
    '! Icon', 
    '! Restricted?' 
]; 
 
// code to convert things to things 
private _IDtoDLC = { 
    switch _this do { 
        case 275700: { "arma3zeus" }; 
        case 288520: { "arma3karts" }; 
        case 304380: { "arma3helicopters" }; 
        case 332350: { "arma3marksmen" }; 
        case 395180: { "arma3apex" }; 
        case 571710: { "arma3lawsofwar" }; 
        case 601670: { "arma3jets" }; 
        case 612480: { "arma3malden" }; 
        case 744950: { "arma3tacops" }; 
        case 798390: { "arma3tanks" }; 
        case 1021790: { "arma3contact" }; 
        case 1325500: { "arma3artofwar" }; 
        case 1227700: { "sogprairiefire" }; 
        case 1175380: { "globalmobilization" }; 
        case 1294440: { "ironcurtain" }; 
        case 1681170: { "westernsahara" }; 
        case 1175380: { "spearhead1944" }; 
        case 2647760: { "reactionforces" }; 
        case 2647830: { "expeditionaryforces" }; 
        default { "" }; 
    }; 
}; 
private _DLCToName = { 
    switch _this do { 
        case "arma3zeus": { "Zeus" }; 
        case "arma3karts": { "Karts" }; 
        case "arma3helicopters": { "Helicopters" }; 
        case "arma3marksmen": { "Marksmen" }; 
        case "arma3apex": { "Apex" }; 
        case "arma3lawsofwar": { "Laws of War" }; 
        case "arma3jets": { "Jets" }; 
        case "arma3malden": { "Malden" }; 
        case "arma3tacops": { "Tac-Ops" }; 
        case "arma3tanks": { "Tanks" }; 
        case "arma3contact": { "Contact" }; 
        case "arma3artofwar": { "Art of War" }; 
        case "sogprairiefire": { "S.O.G. Prairie Fire" }; 
        case "globalmobilization": { "Global Mobilization" }; 
        case "ironcurtain": { "CSLA Iron Curtain" }; 
        case "westernsahara": { "Western Sahara" }; 
        case "spearhead1944": { "Spearhead 1944" }; 
        case "reactionforces": { "Reaction Forces" }; 
        case "expeditionaryforces": { "Expeditionary Forces" }; 
        default { "" }; 
    }; 
}; 
private _MODtoDLC = { 
    switch toLower _this do { 
        case "curator": { "arma3zeus" }; 
        case "kart": { "arma3karts" }; 
        case "heli": { "arma3helicopters" }; 
        case "mark": { "arma3marksmen" }; 
        case "expansion": { "arma3apex" }; 
        case "orange": { "arma3lawsofwar" }; 
        case "jets": { "arma3jets" }; 
        case "argo": { "arma3malden" }; 
        case "tacops": { "arma3tacops" }; 
        case "tank": { "arma3tanks" }; 
        case "enoch": { "arma3contact" }; 
        case "aow": { "arma3artofwar" }; 
        default { "" }; 
    }; 
}; 
 
{ 
    _x params ["_class", "_dlc"]; 
    private _dlcName = _dlc call _IDtoDLC; 
 
    _return pushBack ("|-" + (["", " style=""background: #EDD; color: #333"""] select (_dlcName != ""))); 
 
    if (_mode == 0) then { 
        _return pushBack ("| " + call { 
            if ((configHierarchy (_x # 0)) # 1 == (configFile >> "CfgWeapons")) exitWith { 
                _type = (configName (_x # 0)) call BIS_fnc_itemType; 
                if (configName (_x select 0) isKindOf ["Rifle", configFile >> "CfgWeapons"]) exitWith { "Rifle" }; 
                if (configName (_x select 0) isKindOf ["Pistol", configFile >> "CfgWeapons"]) exitWith { "Pistol" }; 
                if (configName (_x select 0) isKindOf ["Launcher", configFile >> "CfgWeapons"]) exitWith { "Launcher" }; 
                if (_type # 1 == "GPS") exitWith { "Terminal" }; 
                if (_type # 1 == "UAVTerminal") exitWith { "Terminal" }; 
                if (_type # 1 == "AccessoryMuzzle") exitWith { "Muzzle Attachment" }; 
                if (_type # 1 == "AccessorySights") exitWith { "Sight" }; 
                if (_type # 1 == "AccessoryPointer") exitWith { "Rail Attachment" }; 
                if (_type # 1 == "AccessoryBipod") exitWith { "Bipod" }; 
                if (_type # 1 == "LaserDesignator") exitWith { "Binocular" }; 
                if (_type # 1 == "NVGoggles") exitWith { "NVGs" }; 
                if (_type # 1 in ["FirstAidKit", "Medikit", "Toolkit", "MineDetector"]) exitWith { "Item" }; 
                if (_type # 1 == "Radio") exitWith { "Communication" }; 
                _type # 1 
            }; 
            if ((configHierarchy (_x # 0)) # 1 == (configFile >> "CfgGlasses")) exitWith { 
                "Facewear" 
            }; 
            if ((configHierarchy (_x # 0)) # 1 == (configFile >> "CfgVehicles") && configName (_x # 0) isKindOf "Bag_Base") exitWith { 
                "Backpack" 
            }; 
        }); 
    } else { 
        _return pushBack ("| " + getText (configfile >> "CfgFactionClasses" >> (getText (_class >> "faction")) >> "displayName")); 
    }; 
 
    _return append [ 
        ("| " + configName _class), 
        ("| " + getText (_class >> "displayName")) 
    ]; 
 
    private _MOD = call { 
        private _return = ""; 
        if (_mode == 0) then { 
            private _addon = configSourceAddonList (_x # 0); 
            private _modList = configSourceMODList (configFile >> "CfgPatches" >> _addon # 0); 
            _return = if (count _modList > 0) then {_modList # 0} else {""}; 
        }; 
        if (_mode == 1) then { 
            private _modList = configSourceMODList (_x # 0); 
            _return = if (count _modList > 0) then {_modList # 0} else {""}; 
        }; 
        _return; 
    }; 
 
    _return pushBack ("| " + (["", format ["{{Icon|%1|25}}", _MOD call _MODtoDLC]] select (_MOD != ""))); 
 
    if (_dlcName == "") then { 
        _return pushBack ("| No"); 
    } else { 
        _return pushBack ("| " + (_dlcName call _DLCToName)); 
    }; 
} forEach _data; 
 
_return pushBack "|}"; 
 
// final export 
copyToClipboard (_return joinString endl); 
