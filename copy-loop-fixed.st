PROGRAM pcopy
VAR_INPUT i : INT; END_VAR
VAR_OUTPUT o : INT; END_VAR

o := 0;
IF i > 0 THEN
  WHILE i > 0 DO
    i := i - 1;
    o := o + 1;
  END_WHILE
ELSE
  WHILE i < 0 DO
    i := i + 1;
    o := o - 1;
  END_WHILE
END_IF

END_PROGRAM