/*
  Builds EPD attacks + JM meta array (same indices).
  EPD attack entry: [category, name, acquireRate, capacityUsed, methodName, params]
*/
private _out = [];
private _meta = [];

private _raw = missionNamespace getVariable ["JM_JTAC_FireMissions", []];

{
  _x params [
    "_id", "_name", "_category", "_method", "_params",
    ["_requiresIngress", false],
    ["_eta", 0],
    ["_cooldown", 0],
    ["_capacity", -1],
    ["_delay", 0],
    ["_flyoverClass", ""]
  ];

  _out pushBack [
    _category,
    _name,
    1,
    1,
    toUpper _method,
    _params
  ];

  _meta pushBack (createHashMapFromArray [
    ["id", _id],
    ["name", _name],
    ["category", _category],
    ["requiresIngress", _requiresIngress],
    ["eta", _eta max 0],
    ["cooldown", _cooldown max 0],
    ["capacity", _capacity],          // -1 unlimited
    ["delay", _delay max 0],
    ["flyoverClass", _flyoverClass]
  ]);

} forEach _raw;

missionNamespace setVariable ["JM_JTAC_AttackMeta", _meta, true];
_out

