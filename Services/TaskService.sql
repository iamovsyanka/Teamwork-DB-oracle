--add task
create or replace procedure CreateTask (inTeamId in number,
                                        inTaskName in varchar2, 
                                        inDescription in varchar2,
                                        inDateOfDeadline in date,
                                        inManagerId in number)
is 
  ctask number;
  cursor c1 is select t.id from Tasks t 
        where t.taskname = inTaskName and t.id = inTeamId;
begin
   open c1;
   fetch c1 into ctask;
   
   if c1%found then
     raise_application_error(-20001,'Task already exists');
   end if; 
   
  insert into tasks(taskName,
                    taskDescription,
                    dateOfCreation,
                    dateOfDeadline,
                    taskStateId,
                    teamid,
                    managerid) 
              values(inTaskName,
                     inDescription, 
                     Sysdate,
                     inDateOfDeadline,
                     1, 
                     inTeamId,
                     inManagerid);
  commit;
  
  close c1;
  
   exception when others
      then dbms_output.put_line(sqlcode||' '||sqlerrm);
end;

--completed task
create or replace procedure CompletedTask(inTaskId in number)
is 
begin
  update Tasks set taskstateid = 2 where id = inTaskId;
  commit;
  
     exception when others
      then dbms_output.put_line(sqlcode||' '||sqlerrm);
end;

--cancelled task
create or replace procedure CancelledTask(inTaskId in number)
is 
begin
  update Tasks set taskstateid = 3 where id = inTaskId;
  commit;
  
     exception when others
      then dbms_output.put_line(sqlcode||' '||sqlerrm);
end;

--inProgress task
create or replace procedure InProgressTask(inTaskId in number)
is 
begin
  update Tasks set taskstateid = 1 where id = inTaskId;
  commit;
  
     exception when others
      then dbms_output.put_line(sqlcode||' '||sqlerrm);
end;

--delete task
create or replace procedure DeleteTask (inTaskId in number)
is 
begin
  delete from Tasks where id = inTaskId;
  commit;
  
     exception when others
      then dbms_output.put_line(sqlcode||' '||sqlerrm);
end;

--delete all tasks in team
create or replace procedure DeleteTasksInTeam (inTeamId in number)
is 
begin
  delete from Tasks where teamId = inTeamId;
  commit;
  
     exception when others
      then dbms_output.put_line(sqlcode||' '||sqlerrm);
end;

--add user in task
create or replace procedure AddUserInTask (inUserId in number, inTaskId in number) 
is
  cuser number;
  cursor c1 is select u.id from UsersTasks u 
      where u.userId = inUserId and u.taskId = inTaskId;
begin
    open c1;
    fetch c1 into cuser;
   
     if c1%found then
       raise_application_error(-20001,'User already in task');
     end if; 
     
     insert into UsersTasks (userId, taskId) values(inUserId, inTaskId);
     commit;
   
    close c1;
    
    exception when others
      then dbms_output.put_line(sqlcode||' '||sqlerrm);
end;

--update task
create or replace procedure UpdateTask (inTaskId in number,
                                        inTaskName in varchar2, 
                                        inDescription in varchar2,
                                        inDateOfDeadline in date, 
                                        inTeamId in number)
is 
  ctask number;
  cursor c1 is select t.id from Tasks t 
        where t.taskname = inTaskName and t.id = inTeamId;
begin
   open c1;
   fetch c1 into ctask;
   
   if c1%found then
     raise_application_error(-20001,'Task already exists');
   end if; 
   
  update tasks set taskName = inTaskName,
                   taskDescription = InDescription,
                    dateOfDeadline = inDateOfDeadline
                where id = inTaskId;
  commit;
  
  close c1;
  
     exception when others
      then dbms_output.put_line(sqlcode||' '||sqlerrm);
end;

--add pic or video to task
create or replace procedure AddFilesToTask(inTaskId in number, inFileUrl in varchar2)
is
begin
  insert into TaskFiles (fileUrl, taskId) values (inFileUrl, inTaskId);
  commit;
  
     exception when others
      then dbms_output.put_line(sqlcode||' '||sqlerrm);
end;

--delete doc from task
create or replace procedure DeleteFilesFromTask(inTaskId in number, inFileUrl in varchar2)
is
begin
  delete from TaskFiles where fileUrl = inFileUrl and taskId = inTaskId;
  commit;
  
     exception when others
      then dbms_output.put_line(sqlcode||' '||sqlerrm);
end;

--delete user from task
create or replace procedure DeleteUserFromTask (inUserId in number, inTaskId in number) 
is
  cuser number;
  cursor c1 is select u.id from UsersTasks u 
      where u.userId = inUserId and u.taskId = inTaskId;
begin
    open c1;
    fetch c1 into cuser;
   
     if c1%notfound then
       raise_application_error(-20001,'User not found');
     end if; 
     
     delete from UsersTasks where userId = inUserId and taskId = inTaskId;
     commit;
   
    close c1;
    
       exception when others
      then dbms_output.put_line(sqlcode||' '||sqlerrm);
end;