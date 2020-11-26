alter table Users add (teamId number, constraint team_fk foreign key(teamId) references Team(id)); 

alter table UserRoles modify id number generated always as identity;

alter table Tasks add (teamId number, constraint team_fk foreign key(teamId) references Teams(id) ON DELETE CASCADE); 
alter table Tasks modify teamId number not null;
alter table Tasks modify taskName varchar2(100) not null;
alter table Tasks drop column taskName;

