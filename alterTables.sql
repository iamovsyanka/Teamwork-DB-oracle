alter table Users add (teamId number, constraint team_fk foreign key(teamId) references Team(id)); 

alter table UserRoles modify id number generated always as identity;

alter table Task modify taskName varchar2(100) not null unique;