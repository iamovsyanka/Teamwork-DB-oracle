--create team
create or replace procedure CreateTeam (inUserid in number, 
                                        inTeamName in varchar2, 
                                        inDescription in varchar2,
                                        inCategoryid in number)
is 
  cid number;
begin
    insert into teams(managerid,  
                      teamName,
                      teamDescription,
                      categoryid) 
    values (inUserid,
            inTeamName, 
            inDescription,
            inCategoryid) returning id into cid;
            
    insert into UsersTeams (userId, teamid) values(inUserId, cid);
  commit;
  
   exception when others
      then dbms_output.put_line(sqlcode||' '||sqlerrm);
end;

--delete team
create or replace procedure DeleteTeam (inTeamid in number)
is 
begin
  delete from teams where id = inTeamid;
  commit;
  
   exception when others
      then dbms_output.put_line(sqlcode||' '||sqlerrm);
end;

--delete all teams
create or replace procedure DeleteAllTeams (inUserid in number)
is 
begin
  delete from teams where managerId = inUserid;
  commit;
  
   exception when others
      then dbms_output.put_line(sqlcode||' '||sqlerrm);  
end;

--update team
create or replace procedure UpdateTeam (newTeamName in varchar2, 
                                        newDescription in varchar2, 
                                        newCategoryid in number)
is 
begin
  update teams set teamName = newTeamName, 
                   teamDescription = newDescription, 
                   categoryid = newCategoryid;
  commit;
  
  exception when others
      then dbms_output.put_line(sqlcode||' '||sqlerrm);
end;  

--add user in team
create or replace procedure AddUserInTeam (inUserId in number, inTeamId in number) 
is
    cuser number;
    cursor c1 is select u.id from UsersTeams u 
            where u.userId = inUserId and u.teamId = inTeamId;
begin
    open c1;
    fetch c1 into cuser;
   
     if c1%found then
       raise_application_error(-20001,'User already in team');
     end if; 
   
     insert into UsersTeams (userId, teamId) values(inUserId, inTeamId);
     commit;
   
    close c1;
    
    exception when others
      then dbms_output.put_line(sqlcode||' '||sqlerrm);
end;

--delete user from team
create or replace procedure DeleteUserFromTeam (inUserId in number, inTeamId in number) 
is
    cuser number;
    cursor c1 is select u.id from UsersTeams u 
            where u.userId = inUserId and u.teamId = inTeamId;
begin
    open c1;
    fetch c1 into cuser;
   
     if c1%notfound then
       raise_application_error(-20001,'User not found');
     end if; 
   
     delete from UsersTeams where userId = inUserId and teamId = inTeamId;
     commit;
   
    close c1;
    
    exception when others
      then dbms_output.put_line(sqlcode||' '||sqlerrm);
end;