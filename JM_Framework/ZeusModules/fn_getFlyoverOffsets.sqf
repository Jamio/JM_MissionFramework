/*
    Returns local-space offsets for a formation.

    Params:
        0: STRING - formation type ("wedge", "line", "column", "scatter")
        1: NUMBER - aircraft count
        2: NUMBER - spacing
        3: NUMBER - random horizontal offset
        4: NUMBER - random depth offset
        5: NUMBER - random height offset

    Returns:
        ARRAY of offsets [[x,y,z], ...]
*/

params [
    ["_formation", "wedge", [""]],
    ["_count", 5, [0]],
    ["_spacing", 60, [0]],
    ["_randX", 0, [0]],
    ["_randY", 0, [0]],
    ["_randZ", 0, [0]]
];

private _offsets = [];
private _formationLower = toLower _formation;

switch (_formationLower) do {
    case "line": {
        private _center = (_count - 1) / 2;

        for "_i" from 0 to (_count - 1) do {
            private _x = (_i - _center) * _spacing;
            private _y = 0;
            private _z = 0;

            if (_i isEqualTo 0) then {
                _offsets pushBack [_x, _y, _z];
            } else {
                _offsets pushBack [
                    _x + (random (_randX * 2) - _randX),
                    _y + (random (_randY * 2) - _randY),
                    _z + (random (_randZ * 2) - _randZ)
                ];
            };
        };
    };

    case "column": {
        for "_i" from 0 to (_count - 1) do {
            private _x = 0;
            private _y = -(_i * _spacing);
            private _z = 0;

            if (_i isEqualTo 0) then {
                _offsets pushBack [_x, _y, _z];
            } else {
                _offsets pushBack [
                    _x + (random (_randX * 2) - _randX),
                    _y + (random (_randY * 2) - _randY),
                    _z + (random (_randZ * 2) - _randZ)
                ];
            };
        };
    };

    case "scatter": {
        // Keep one loose "lead" near the center
        _offsets pushBack [0, 0, 0];

        for "_i" from 1 to (_count - 1) do {
            private _angle = random 360;

            // Spread radius out from about 35% to 100% of spacing * rank scale
            private _maxRadius = _spacing * (0.75 + ((_count max 2) / 6));
            private _minRadius = _spacing * 0.35;
            private _radius = _minRadius + random (_maxRadius - _minRadius);

            private _x = (sin _angle) * _radius;
            private _y = (cos _angle) * _radius;
            private _z = 0;

            _offsets pushBack [
                _x + (random (_randX * 2) - _randX),
                _y + (random (_randY * 2) - _randY),
                _z + (random (_randZ * 2) - _randZ)
            ];
        };
    };

    case "wedge";
    default {
        _offsets pushBack [0, 0, 0];

        for "_i" from 1 to (_count - 1) do {
            private _rank = ceil (_i / 2);
            private _side = if ((_i mod 2) isEqualTo 1) then {-1} else {1};

            private _x = _side * _spacing * _rank;
            private _y = -_spacing * _rank;
            private _z = 0;

            _offsets pushBack [
                _x + (random (_randX * 2) - _randX),
                _y + (random (_randY * 2) - _randY),
                _z + (random (_randZ * 2) - _randZ)
            ];
        };
    };
};

_offsets