params ["_choice"];
switch (toUpper _choice) do {
  case "N": {0};
  case "NE": {45};
  case "E": {90};
  case "SE": {135};
  case "S": {180};
  case "SW": {225};
  case "W": {270};
  case "NW": {315};
  default { random 360 };
};
