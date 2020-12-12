create or replace package UserPackage as
  procedure checkuser (inusername in varchar2, inpassword in varchar2, outuserid out number);
  procedure encryptPassword (casualPassword in out varchar2);
  procedure authorizeuser (inusername in varchar2, inpassword in varchar2);
  procedure RegistrationUser (inUsername in varchar2, inEmail in varchar2, inPassword in varchar2);
  procedure ChangeUserName (inUserId in number, inUsername in varchar2);
  procedure ChangePassword (inUserId in number, inPassword in varchar2);
  procedure ChangeEmail (inUserId in number, inEmail in varchar2);
  procedure DeleteUser (inUserId in number);
  procedure searchuserbyname (inusername in varchar2, outuserid out number);
  procedure GetUserInformation (inUserId in number, cursor in out sys_refcursor);
end UserPackage;

create or replace package body UserPackage as
  procedure CheckUser (inUsername in varchar2, inPassword in varchar2, outUserId out number)
  is 
    cuser number;
    cursor c1 is select u.id from Users u where u.username = inUsername and u.password = inPassword;
  begin
     open c1;
     fetch c1 into cuser;
     
     if c1%notfound then
       raise_application_error(-20001,'User not found');
     end if; 
     
     outUserId := cuser;
     close c1;
     
     exception when others
        then dbms_output.put_line(sqlcode||' '||sqlerrm);
  end;
  
    --encrypt password
  procedure encryptPassword (casualPassword in out varchar2) is
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
    casualpassword := newpassword;
  end;
  
  --authorization users
  procedure AuthorizeUser (inUsername in varchar2, inPassword in varchar2)
  is 
   cpassw varchar2(2000);
   cuserid number;
  begin
    cpassw := inPassword;
    encryptpassword(cpassw);
    checkuser(inusername,cpassw, cuserid);
    dbms_output.put_line(cuserid);
  end;
  
  --registration user
  procedure RegistrationUser (inUsername in varchar2, inEmail in varchar2, inPassword in varchar2)
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
       raise_application_error(-20001,'User already exists');
     end if; 
     
     insert into Users (username, email, password, roleId) values(inUsername, inEmail, newPassword, 2);
     commit;
     
     close c1;
     
      exception when others
        then dbms_output.put_line(sqlcode||' '||sqlerrm);
  end;
  
  --change username
  procedure ChangeUserName (inUserId in number, inUsername in varchar2)
  is 
    cuser number;
    cursor c1 is select u.id from Users u where u.username = inUsername;
  begin
     open c1;
     fetch c1 into cuser;
     
     if c1%found then
       raise_application_error(-20001,'Username already exists');
     end if; 
     
     update Users set userName = inUserName where id = inUserId;
     close c1;
     
     exception when others
        then dbms_output.put_line(sqlcode||' '||sqlerrm);
  end;
  
  --change password 
  procedure ChangePassword (inUserId in number, inPassword in varchar2)
  is 
    passw varchar2(2000);
  begin 
     passw := inPassword;
     encryptPassword(cpassw);
     update Users set password = passw where id = inUserId;
  end;
  
  --change email
  procedure ChangeEmail (inUserId in number, inEmail in varchar2)
  is 
  begin
     update Users set email = inEmail where id = inUserId;
     close c1;
  end;
  
  --delete user
  procedure DeleteUser (inUserId in number)
  is
  begin  
     delete from Users where id = inUserId;
  end;
  
  --search user by username
  procedure SearchUserByName (inUserName in varchar2, outUserId out number)
  is
    cuser number;
    cursor c1 is select u.id from Users u where u.username = inUsername;
  begin
     open c1;
     fetch c1 into cuser;
     
     if c1%notfound then
       raise_application_error(-20001,'User not found');
     end if; 
     
     outUserId := cuser;
     close c1;
     
      exception when others
        then dbms_output.put_line(sqlcode||' '||sqlerrm);
  end;
  
  --get user information
  procedure GetUserInformation (inUserId in number, cursor in out sys_refcursor) is
  begin
    open cursor for 
    select u.id, u.userName, u.email, u.roleId from Users u where u.id = inUserId;
  end;

end UserPackage;