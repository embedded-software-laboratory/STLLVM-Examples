TYPE
  IntRef : REF_TO INT;
END_TYPE

PROGRAM deref
  VAR_INPUT ptr : IntRef; END_VAR
  VAR_OUTPUT out : INT; END_VAR

  out := ptr^;
END_PROGRAM