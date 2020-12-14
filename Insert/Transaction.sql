insert into UserRoles (role) values('Admin');
insert into UserRoles (role) values('User');
commit;

insert into categories (category) values('Developers');
insert into categories (category) values('Designers');
insert into categories (category) values('Managers');
insert into categories (category) values('Students');
insert into categories (category) values('Others');
commit;

insert into Team (teamName, managerId, categoryId) values('FirstTeam', 1, 1);
commit;

insert into TaskStates (stateName) values('in progress');
insert into TaskStates (stateName) values('completed');
insert into TaskStates (stateName) values('cancelled');
commit;

select * from curs_db_admin.viewusers;