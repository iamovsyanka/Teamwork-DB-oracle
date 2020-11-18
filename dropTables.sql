drop table Users;
drop table Team;
drop table Task;
drop table Categories;
drop table UserRoles;
drop table Comments;
drop table TaskFiles;
drop table UsersTasks;
drop table TaskStates;

alter table Users drop constraint role_fk;
alter table Team drop constraint manager_fk;
alter table Team drop constraint category_fk;