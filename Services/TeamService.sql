--create team
create or replace procedure CreateTeam (userid in number, teamName in varchar2, description in varchar2,categoryid in number)
is 
begin
  insert into teams(managerid,teamName,teamDescription,categoryid) values(userid,teamName, description,categoryid);
  commit;
end;

--drop team
create or replace procedure DeleteTeam (teamid in number)
is 
begin
  delete from teams where and id = teamid;
  commit;
end;

--drop all teams
create or replace procedure DeleteAllTeams (userid in number)
is 
begin
  delete from teams where managerId = userid;
  commit;
end;

--alter team