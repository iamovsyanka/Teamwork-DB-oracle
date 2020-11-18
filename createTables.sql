create table UserRoles(id number generated always as identity, 
                       role varchar2(100) not null unique,
                       constraint role_pk primary key(id));
                       
create table Users(id number generated always as identity, 
                   username varchar2(100) not null unique,
                   password varchar2(100) not null,
                   roleId number not null,
                   constraint user_pk primary key(id),
                   constraint role_fk foreign key(roleId) references UserRoles(id)); 
                   
create table Categories(id number generated always as identity, 
                       category varchar2(100) not null unique,
                       constraint category_pk primary key(id));                   
                   
create table Teams(id number generated always as identity, 
                   teamName varchar2(100) not null unique,
                   teamDescription varchar2(1000),
                   managerId number not null,
                   categoryId number not null,
                   constraint team_pk primary key(id),
                   constraint manager_fk foreign key(managerId) references Users(id),
                   constraint category_fk foreign key(categoryId) references Categories(id));  
                   
create table TaskStates(id number generated always as identity, 
                       stateName varchar2(100) not null unique,
                       constraint state_pk primary key(id));                      
                   
create table Tasks(id number generated always as identity, 
                   taskName varchar2(100) not null unique,
                   taskDescription varchar2(1000),
                   dateOfCreation date not null, --chasovoi poyas
                   dateOfDeadline date, --chasovoi poyas
                   taskStateId number not null,
                   constraint task_pk primary key(id),
                   constraint state_fk foreign key(taskStateId) references TaskStates(id));    
               
create table Comments(id number generated always as identity, 
                   creatorId number not null,
                   dateOfCreation date not null, --chasovoi poyas
                   commentContent varchar2(4000) not null,
                   taskId number not null,
                   constraint comment_pk primary key(id),
                   constraint task_fk foreign key(taskId) references Tasks(id),
                   constraint creator_fk foreign key(creatorId) references Users(id));   
                                     
create table TaskFiles(
    id number generated always as identity,
    fileUrl varchar2(4000) not null,
    taskId number not null,
    constraint file_pk primary key(id),
    constraint fileTask_fk foreign key(taskId) references Tasks(id));
    
create table UsersTasks(
    id number generated always as identity,
    userId number not null,
    taskId number not null,
    constraint userTask_user_fk foreign key(userId) references Users(id),
    constraint userTask_task_fk foreign key(taskId) references Tasks(id));    