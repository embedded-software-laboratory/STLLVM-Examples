PROGRAM binary_search
  VAR_INPUT x : INT; END_VAR
  VAR_INPUT arr : ARRAY[0..9] OF INT; END_VAR
  VAR_OUTPUT idx : INT; END_VAR
  VAR_TEMP
    i : INT;
    first : INT := 0;
    last : INT := 9;
    mid : INT;
  END_VAR

FOR i := 0 TO 8 DO
  __ASSUME arr[i] <= arr[i + 1];
END_FOR

idx := -1;
WHILE first <= last DO
  mid := (first + last) / 2;
  IF arr[mid] = x THEN
    idx := mid;
    EXIT;
  ELSIF arr[mid] > x THEN
    last := mid - 1;
  ELSE
    first := mid + 1;
  END_IF
END_WHILE

IF idx <> -1 THEN
  IF arr[idx] <> x THEN
    __UNREACHABLE;
  END_IF
END_IF

END_PROGRAM