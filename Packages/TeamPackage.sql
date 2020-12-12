create or replace package TeamPackage as
  procedure CreateTeam (inUserid in number, 
                                        inTeamName in varchar2, 
                                        indescription in varchar2,
                                        incategoryid in number);
   procedure deleteteam (inteamid in number);
   procedure deleteallteams (inuserid in number);
   procedure UpdateTeam (newTeamName in varchar2, 
                                        newdescription in varchar2, 
                                        newcategoryid in number);
   procedure adduserinteam (inuserid in number, inteamid in number);
   procedure deleteuserfromteam (inuserid in number, inteamid in number);  
end TeamPackage;

create or replace package body teampackage as
  --create team
  procedure CreateTeam (inUserid in number,inTeamName in varchar2, 
                        inDescription in varchar2,inCategoryid in number)
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
  end;
  
  --delete team
  procedure DeleteTeam (inTeamid in number)
  is 
  begin
    delete from teams where id = inTeamid;
    commit;
  end;
  
  --delete all teams
  procedure DeleteAllTeams (inUserid in number)
  is 
  begin
    delete from teams where managerId = inUserid;
    commit;
  end;
  
  --update team
  procedure UpdateTeam (newTeamName in varchar2,newDescription in varchar2, 
                        newCategoryid in number)
  is 
  begin
    update teams set teamName = newTeamName, 
                     teamDescription = newDescription, 
                     categoryid = newCategoryid;
    commit;
  end;
  
  --add user in team
  procedure AddUserInTeam (inUserId in number, inTeamId in number) 
  is
      cuser number;
      cursor c1 is select u.id from UsersTeams u 
              where u.userId = inUserId and u.teamId = inTeamId;
  begin
      open c1;
      fetch c1 into cuser;
     
       if c1%found then
         raise_application_error(-20001,'An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
       end if; 
     
       insert into UsersTeams (userId, teamId) values(inUserId, inTeamId);
       commit;
     
      close c1;
  end;
  
  --delete user from team
  procedure DeleteUserFromTeam (inUserId in number, inTeamId in number) 
  is
      cuser number;
      cursor c1 is select u.id from UsersTeams u 
              where u.userId = inUserId and u.teamId = inTeamId;
  begin
      open c1;
      fetch c1 into cuser;
     
       if c1%notfound then
         raise_application_error(-20001,'An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
       end if; 
     
       delete from UsersTeams where userId = inUserId and teamId = inTeamId;
       commit;
     
      close c1;
  end;
end TeamPackage;