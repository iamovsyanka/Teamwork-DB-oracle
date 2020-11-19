insert into UserRoles (role) values('Admin');
insert into UserRoles (role) values('User');
commit;

insert into Users (username, password, roleId) values('Admin', 'Password-Admin', 1);
insert into Users (username, password, roleId) values('Andrey', '55555', 2);
commit;

insert into Categories values(1, 'Developers');
commit;

insert into Team (id, teamName, managerId, categoryId) values(1, 'FirstTeam', 1, 1);
commit;


