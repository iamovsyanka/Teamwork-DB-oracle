create or replace procedure CheckUser (inUsername in varchar2, inPassword in varchar2)
is 
  cuser number;
  cursor c1 is select u.id from Users u where u.username = inUsername and u.password = inPassword;
begin
   open c1;
   fetch c1 into cuser;
   
   if c1%notfound then
     raise_application_error(-20001,'An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
   end if; 
   
   close c1;
end;

create or replace procedure AuthorizeUser (inUsername in varchar2, inPassword in varchar2)
is 
 cpassw varchar2(2000);
begin
  cpassw := inPassword;
  encryptPassword(cpassw);
  CheckUser(inUserName,cpassw);
end;

begin
   open c1;
   fetch c1 into cuser;
   
   if c1%notfound then
     raise_application_error(-20001,'An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
   end if; 
   
   close c1;
end;


create or replace procedure encryptPassword (casualPassword in out varchar2) is
   l_key varchar2(2000) := '1234567890123456';
   l_mod NUMBER  :=DBMS_CRYPTO.encrypt_aes128
                  + DBMS_CRYPTO.chain_cbc
                  + DBMS_CRYPTO.pad_pkcs5;
   newPassword RAW(2000);
begin
  newPassword:= DBMS_CRYPTO.encrypt (utl_i18n.string_to_raw (casualPassword, 'AL32UTF8'),
                                    l_mod,
                                    utl_i18n.string_to_raw (l_key, 'AL32UTF8')
    );
    casualPassword := newPassword;
end;


create or replace procedure RegistrationUser (inUsername in varchar2, inPassword in varchar2)
is 
   cuser number;
   cursor c1 is select u.id from Users u where u.username = inUsername;
   newPassword varchar(2000);
begin
   newPassword :=inPassword;
   encryptpassword(newPassword);
   open c1;
   fetch c1 into cuser;
   
   if c1%found then
     raise_application_error(-20001,'An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
   end if; 
   
   insert into Users (username, password, roleId) values(inUsername, newPassword, 2);
   commit;
   
   close c1;
end;

begin
  RegistrationUser('Hanna', 'svn');
end;

begin
  AuthorizeUser('Testing','testing'); 
end;

select * from Users;

create or replace procedure CreateTeam (userid in number, teamName in varchar2, description in varchar2,categoryid in number)
is 
begin
  insert into teams(managerid,teamName,teamDescription,categoryid) values(userid,teamName, description,categoryid);
  commit;
end;

begin
  createteam(21,'gbljhh','hgsddak',1);
end;
select * from teams;
insert into categories(category) values('Developers');