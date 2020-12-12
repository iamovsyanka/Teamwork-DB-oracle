alter session set "_ORACLE_SCRIPT" = true;

create profile PRFL_CURS limit
  password_life_time 180
  sessions_per_user 3
  failed_login_attempts 7
  password_lock_time 1
  password_reuse_time 10
  password_grace_time default
  connect_time 180
  idle_time 30;
  
create user CURS_DB_ADMIN identified by 123456789  
profile PRFL_CURS;
  
grant all privileges to CURS_DB_ADMIN;  

create user CURS_APP_ADMIN identified by 123456789  
profile PRFL_CURS;

create user CURS_APP_USER identified by 123456789  
profile PRFL_CURS;

grant create session to CURS_APP_ADMIN;
grant create session to CURS_APP_USER;