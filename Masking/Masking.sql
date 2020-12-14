BEGIN
DBMS_REDACT.ADD_POLICY(
     object_schema        => 'CURS_DB_ADMIN',
     object_name          => 'USERS',
     COLUMN_NAME           => 'EMAIL',
     POLICY_NAME          => 'redact_email',
     FUNCTION_TYPE         => DBMS_REDACT.REGEXP,
     regexp_pattern	      => DBMS_REDACT.RE_PATTERN_EMAIL_ADDRESS,
     REGEXP_REPLACE_STRING => DBMS_REDACT.RE_REDACT_EMAIL_NAME,
     EXPRESSION           => 'SYS_CONTEXT(''USERENV'',''SESSION_USER'') = ''CURS_APP_ADMIN''');
end;

BEGIN
DBMS_REDACT.DROP_POLICY (
     object_schema        => 'CURS_DB_ADMIN',
     OBJECT_NAME          => 'USERS',
      POLICY_NAME          => 'redact_email');
END;