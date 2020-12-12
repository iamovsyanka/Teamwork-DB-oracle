insert into UserRoles (role) values('Admin');
insert into UserRoles (role) values('User');
commit;

insert into Categories (category) values('Developers');
commit;

insert into Team (teamName, managerId, categoryId) values('FirstTeam', 1, 1);
commit;

insert into TaskStates (stateName) values('in progress');
insert into TaskStates (stateName) values('completed');
insert into TaskStates (stateName) values('cancelled');
commit;

SELECT sys_context('USERENV', 'SID') FROM DUAL;