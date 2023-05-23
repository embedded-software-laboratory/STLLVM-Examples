PROGRAM buffer
  VAR_INPUT value : INT; END_VAR
  VAR_INPUT offset : INT; END_VAR
  VAR_GLOBAL buf : ARRAY [0..1024] OF INT; END_VAR
  VAR cur_pos : INT := 0; END_VAR

IF offset < 0 THEN RETURN; END_IF
IF cur_pos + offset > 1024 THEN RETURN; END_IF;

cur_pos := cur_pos + offset;
buf[cur_pos] := value;

END_PROGRAM