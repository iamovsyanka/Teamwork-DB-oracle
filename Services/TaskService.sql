--add task
create or replace procedure CreateTask (teamId in number,
                                        taskName in varchar2, 
                                        description in varchar2,
                                        dateOfDeadline in date)
is 
  ctask number;
  cursor c1 is select t.id from Tasks t where t.taskName = taskname and t.teamid = teamId;
begin
   open c1;
   fetch c1 into ctask;
   
   if c1%found then
     raise_application_error(-20001,'An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
   end if; 
   
  insert into tasks(taskName,
                    taskDescription,
                    dateOfCreation,
                    dateOfDeadline,
                    taskStateId,
                    teamid) 
              values(taskName,
                     description, 
                     Sysdate,
                     dateOfDeadline,
                     1, teamId);
  commit;
  
  close c1;
end;

--completed task
create or replace procedure CompletedTask(taskId in number)
is 
begin
  update Tasks set taskstateid = 2 where id = taskId;
  commit;
end;

--cancelled task
create or replace procedure CancelledTask(taskId in number)
is 
begin
  update Tasks set taskstateid = 3 where id = taskId;
  commit;
end;

--delete task
create or replace procedure DeleteTask (taskId in number)
is 
begin
  delete from Tasks where id = taskId;
  commit;
end;

--delete all tasks in team
create or replace procedure DeleteTasksInTeam (teamId in number)
is 
begin
  delete from Tasks where teamId = teamId;
  commit;
end;
