

params ["_unit"];

// Array of possible selections (body parts)
 _limb = selectRandom ["rightfoot", "leftfoot", "head", "spine1", "hand", "pelvis"];

// Generate random force direction
private _randomX = random 6000 - 3000; // Random value between -3000 and 3000 for X axis (very strong horizontal force)
private _randomY = random 6000 - 3000; // Random value between -3000 and 3000 for Y axis (very strong horizontal force)
private _randomZ = random 2000 - 1000; // Random value between 1000 and 2000 for Z axis (to ensure a strong vertical fling)

// Apply the randomized force to the randomly selected body part
_unit addForce [_unit vectorModelToWorld [_randomX, _randomY, _randomZ], _unit selectionPosition _limb, false];
sleep 2;
_unit setUnconscious false;
