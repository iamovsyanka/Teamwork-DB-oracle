BEGIN
DBMS_REDACT.ADD_POLICY(
     object_schema        => 'SYSTEM',
     object_name          => 'USERS',
     column_name          => 'PASSWORD',
     policy_name          => 'redact_password',
     regexp_pattern	   => '^\w+$', 
     regexp_replace_string => '',
     regexp_position       => DBMS_REDACT.RE_BEGINNING,
     regexp_occurrence     => DBMS_REDACT.RE_ALL,
     expression           => '1=1');
END;

BEGIN
DBMS_REDACT.DROP_POLICY (
     object_schema        => 'SYSTEM',
     object_name          => 'USERS',
      policy_name          => 'redact_client_info');
END;
