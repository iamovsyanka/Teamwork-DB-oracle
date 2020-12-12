create or replace package taskpackage as
  procedure CreateTask (inTeamId in number,
                                        inTaskName in varchar2, 
                                        inDescription in varchar2,
                                        indateofdeadline in date,
                                        inmanagerid in number);
   
   procedure completedtask(intaskid in number);
   procedure cancelledtask(intaskid in number);
   procedure inprogresstask(intaskid in number);
   procedure deletetask (intaskid in number);
   procedure deletetasksinteam (inteamid in number);
   procedure AddUserInTask (inUserId in number, inTaskId in number);
   procedure UpdateTask (inTaskId in number,
                                        inTaskName in varchar2, 
                                        inDescription in varchar2,
                                        indateofdeadline in date, 
                                        inteamid in number);
   procedure addfilestotask(intaskid in number, infileurl in varchar2);
   procedure deletefilesfromtask(intaskid in number, infileurl in varchar2);
   procedure DeleteUserFromTask (inUserId in number, inTaskId in number);
end TaskPackage;

create or replace package body taskpackage as
    --add task
  procedure CreateTask (inTeamId in number,
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
  procedure CompletedTask(inTaskId in number)
  is 
  begin
    update Tasks set taskstateid = 2 where id = inTaskId;
    commit;
    
       exception when others
        then dbms_output.put_line(sqlcode||' '||sqlerrm);
  end;
  
  --cancelled task
  procedure CancelledTask(inTaskId in number)
  is 
  begin
    update Tasks set taskstateid = 3 where id = inTaskId;
    commit;
    
       exception when others
        then dbms_output.put_line(sqlcode||' '||sqlerrm);
  end;
  
  --inProgress task
  procedure InProgressTask(inTaskId in number)
  is 
  begin
    update Tasks set taskstateid = 1 where id = inTaskId;
    commit;
    
       exception when others
        then dbms_output.put_line(sqlcode||' '||sqlerrm);
  end;
  
  --delete task
  procedure DeleteTask (inTaskId in number)
  is 
  begin
    delete from Tasks where id = inTaskId;
    commit;
    
       exception when others
        then dbms_output.put_line(sqlcode||' '||sqlerrm);
  end;
  
  --delete all tasks in team
  procedure DeleteTasksInTeam (inTeamId in number)
  is 
  begin
    delete from Tasks where teamId = inTeamId;
    commit;
    
       exception when others
        then dbms_output.put_line(sqlcode||' '||sqlerrm);
  end;
  
  --add user in task
  procedure AddUserInTask (inUserId in number, inTaskId in number) 
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
  procedure UpdateTask (inTaskId in number,
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
  procedure AddFilesToTask(inTaskId in number, inFileUrl in varchar2)
  is
  begin
    insert into TaskFiles (fileUrl, taskId) values (inFileUrl, inTaskId);
    commit;
    
       exception when others
        then dbms_output.put_line(sqlcode||' '||sqlerrm);
  end;
  
  --delete doc from task
  procedure DeleteFilesFromTask(inTaskId in number, inFileUrl in varchar2)
  is
  begin
    delete from TaskFiles where fileUrl = inFileUrl and taskId = inTaskId;
    commit;
    
       exception when others
        then dbms_output.put_line(sqlcode||' '||sqlerrm);
  end;
  
  --delete user from task
  procedure DeleteUserFromTask (inUserId in number, inTaskId in number) 
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
end TaskPackage;