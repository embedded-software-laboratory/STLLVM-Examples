PROGRAM smooth
  VAR_INPUT in_data : ARRAY[1..10] OF INT; END_VAR
  VAR_OUTPUT out_data : ARRAY[1..10] OF INT; END_VAR
  VAR_TEMP i, j : INT; val : INT; END_VAR

FOR i := 1 TO 10 DO
  val := 0;
  FOR j := i - 1 TO i + 1 DO
    IF j >= 1 AND j <= 10 THEN
      val := val + in_data[i] / ABS(i - j);
    END_IF;
  END_FOR
  out_data[i] := val / 2;
END_FOR

END_PROGRAM