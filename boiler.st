PROGRAM boiler
VAR_INPUT
  temperature : INT;
END_VAR
VAR_OUTPUT
  heater_on : BOOL;
END_VAR
VAR
  last_temperature : INT;
END_VAR
VAR_TEMP CONSTANT
  target_temperature : INT := 100;
  hysteresis : INT := 5;
END_VAR

IF temperature > last_temperature THEN
  // Rising temperature.
  IF temperature > target_temperature + hysteresis THEN
    heater_on := FALSE;
  ELSE
    heater_on := TRUE;
  END_IF
ELSE
  // Falling temperature.
  IF temperature < target_temperature THEN
    heater_on := TRUE;
  ELSE
    heater_on := FALSE;
  END_IF
END_IF

last_temperature := temperature;
IF temperature > target_temperature + hysteresis AND heater_on THEN
__UNREACHABLE;
END_IF

END_PROGRAM