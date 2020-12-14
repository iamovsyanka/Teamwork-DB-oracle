create or replace package viewpackage as 
  procedure teamsbyuser(inuserid in number, cursor in out sys_refcursor);
  procedure viewteamsbyuser(inuserid in number);
  procedure commentsintask(intaskid in number, cursor in out sys_refcursor);
  procedure viewcommentsintask(intaskid in number);
  procedure tasksbyteam(inteamid in number, cursor in out sys_refcursor);
  procedure viewtasksbyteam(inteamid in number);
  procedure usersinteam(inteamid in number, cursor in out sys_refcursor);
  procedure viewusersinteam(inteamid in number);
  procedure usersintask(intaskid in number, cursor in out sys_refcursor);
  procedure viewusersintask(intaskid in number);
  procedure filesintask(intaskid in number, cursor in out sys_refcursor);
  procedure viewfilesintask(intaskid in number);
  procedure getuserinformation (inuserid in number, cursor in out sys_refcursor);
  procedure ViewUserInformaion(inUserId IN NUMBER);
end ViewPackage;

create or replace package body viewpackage as 
  --all user teams
procedure TeamsByUser(inUserId in number, 
                                        cursor in out sys_refcursor)
is
BEGIN
  open cursor for 
  select ut.userId, t.id, t.teamName, t.teamdescription, t.categoryId, ca.category, t.managerid, u.username 
  from UsersTeams ut inner join Teams t on ut.teamId = t.id 
  inner join Categories ca on ca.id = t.categoryid
  inner join Users u on u.id = t.managerid
  where ut.userId = inUserId;
end;

procedure ViewTeamsByUser(INUSERID IN NUMBER)
is
  REFCUR SYS_REFCURSOR;
  TYPE RECORDTYPE IS RECORD (COL1 NUMBER, COL2 NUMBER, COL3 VARCHAR(2000), COL4 VARCHAR(4000), COL5 NUMBER, COL6 VARCHAR(2000), COL7 NUMBER, COL8 VARCHAR(2000));
  outtable RECORDTYPE;
BEGIN
  TeamsByUser(INUSERID, REFCUR);
  LOOP
  FETCH REFCUR INTO outtable;
    EXIT WHEN REFCUR%NOTFOUND;
    DBMS_OUTPUT.PUT('userId:');
      DBMS_OUTPUT.PUT_LINE(OUTTABLE.COL1);
    DBMS_OUTPUT.PUT('teamId:');
      DBMS_OUTPUT.PUT_LINE(OUTTABLE.COL2);
    DBMS_OUTPUT.PUT('teamName:');
      DBMS_OUTPUT.PUT_LINE(OUTTABLE.COL3);
    DBMS_OUTPUT.PUT('teamDescription:');
      DBMS_OUTPUT.PUT_LINE(OUTTABLE.COL4);
    DBMS_OUTPUT.PUT('categoryId:');
      DBMS_OUTPUT.PUT_LINE(OUTTABLE.COL5);
    DBMS_OUTPUT.PUT('category:');
      DBMS_OUTPUT.PUT_LINE(OUTTABLE.COL6);
    DBMS_OUTPUT.PUT('managerId:');
      DBMS_OUTPUT.PUT_LINE(OUTTABLE.COL7);
    DBMS_OUTPUT.PUT('username:');
      DBMS_OUTPUT.PUT_LINE(OUTTABLE.COL8);
    DBMS_OUTPUT.PUT_LINE('');
  END LOOP;
  CLOSE REFCUR;
END;

--all comments in task
procedure CommentsInTask(inTaskId in number, 
                                        cursor in out sys_refcursor)
is
BEGIN
  open cursor for 
  select ut.id, co.creatorId, u.userName, co.commentContent, co.dateOfCreation 
  from UsersTasks ut inner join Users u on ut.userId = u.id 
  inner join Comments co on co.creatorId = u.id
  where ut.taskId = inTaskId;
end;

procedure ViewCommentsInTask(inTaskId IN NUMBER)
is
  REFCUR SYS_REFCURSOR;
  TYPE RECORDTYPE IS RECORD (COL1 NUMBER, COL2 NUMBER, COL3 VARCHAR(2000), COL4 VARCHAR(4000), COL5 DATE);
  outtable RECORDTYPE;
BEGIN
  CommentsInTask(inTaskId, REFCUR);
  LOOP
  FETCH REFCUR INTO outtable;
    EXIT WHEN REFCUR%NOTFOUND;
    DBMS_OUTPUT.PUT('taskId:');
      DBMS_OUTPUT.PUT_LINE(OUTTABLE.COL1);
    DBMS_OUTPUT.PUT('creatorId:');
      DBMS_OUTPUT.PUT_LINE(OUTTABLE.COL2);
    DBMS_OUTPUT.PUT('userName:');
      DBMS_OUTPUT.PUT_LINE(OUTTABLE.COL3);
    DBMS_OUTPUT.PUT('commentcontent:');
      DBMS_OUTPUT.PUT_LINE(OUTTABLE.COL4);
    DBMS_OUTPUT.PUT('dateOfCreation:');
      DBMS_OUTPUT.PUT_LINE(OUTTABLE.COL5);
    DBMS_OUTPUT.PUT_LINE('');
  END LOOP;
  CLOSE REFCUR;
END;

--all tasks in team
procedure TasksByTeam(inTeamId in number, 
                                        cursor in out sys_refcursor)
is
BEGIN
  open cursor for 
  select t.id, ta.id, ta.taskname, ta.taskdescription, ta.dateofcreation, ta.dateofdeadline, ta.taskstateid, st.statename, ta.managerid, u.username 
  from Tasks ta inner join Teams t on ta.teamId = t.id 
  inner join Taskstates st on ta.taskstateid = st.id
  inner join Users u on ta.managerid = u.id
  where t.id = inTeamId;
end;

procedure ViewTasksByTeam(inTeamId IN NUMBER)
is
  REFCUR SYS_REFCURSOR;
  TYPE RECORDTYPE IS RECORD (COL1 NUMBER, COL2 NUMBER, COL3 VARCHAR(100), COL4 VARCHAR(4000), COL5 DATE, COL6 DATE, COL7 NUMBER, COL8 VARCHAR(100), COL9 NUMBER, COL10 VARCHAR(100));
  outtable RECORDTYPE;
BEGIN
  TasksByTeam(inTeamId, REFCUR);
  LOOP
  FETCH REFCUR INTO outtable;
    EXIT WHEN REFCUR%NOTFOUND;
    DBMS_OUTPUT.PUT('teamId:');
      DBMS_OUTPUT.PUT_LINE(OUTTABLE.COL1);
    DBMS_OUTPUT.PUT('taskId:');
      DBMS_OUTPUT.PUT_LINE(OUTTABLE.COL2);
    DBMS_OUTPUT.PUT('taskName:');
      DBMS_OUTPUT.PUT_LINE(OUTTABLE.COL3);
    DBMS_OUTPUT.PUT('taskDescription:');
      DBMS_OUTPUT.PUT_LINE(OUTTABLE.COL4);
    DBMS_OUTPUT.PUT('dateOfcreation:');
      DBMS_OUTPUT.PUT_LINE(OUTTABLE.COL5);
    DBMS_OUTPUT.PUT('dateOfDeadline:');
      DBMS_OUTPUT.PUT_LINE(OUTTABLE.COL6);
    DBMS_OUTPUT.PUT('taskStateId:');
      DBMS_OUTPUT.PUT_LINE(OUTTABLE.COL7);
    DBMS_OUTPUT.PUT('stateName:');
      DBMS_OUTPUT.PUT_LINE(OUTTABLE.COL8);
    DBMS_OUTPUT.PUT('managerId:');
      DBMS_OUTPUT.PUT_LINE(OUTTABLE.COL9);
    DBMS_OUTPUT.PUT('userName:');
      DBMS_OUTPUT.PUT_LINE(OUTTABLE.COL10);
    DBMS_OUTPUT.PUT_LINE('');
  END LOOP;
  CLOSE REFCUR;
end;

--all users in team
procedure UsersInTeam(inTeamId in number, 
                                        cursor in out sys_refcursor)
is
BEGIN
  open cursor for 
  select t.id, t.teamName, u.id, u.userName
  from UsersTeams ut inner join Teams t on ut.teamId = t.id 
  inner join Users u on u.id = ut.userId
  where t.id = inTeamId;
end;

procedure ViewUsersInTeam(inTeamId IN NUMBER)
is
  REFCUR SYS_REFCURSOR;
  TYPE RECORDTYPE IS RECORD (COL1 NUMBER, COL2 VARCHAR(100), COL3 NUMBER, COL4 VARCHAR(100));
  outtable RECORDTYPE;
BEGIN
  UsersInTeam(inTeamId, REFCUR);
  LOOP
  FETCH REFCUR INTO outtable;
    EXIT WHEN REFCUR%NOTFOUND;
    DBMS_OUTPUT.PUT('teamId:');
      DBMS_OUTPUT.PUT_LINE(OUTTABLE.COL1);
    DBMS_OUTPUT.PUT('teamName:');
      DBMS_OUTPUT.PUT_LINE(OUTTABLE.COL2);
    DBMS_OUTPUT.PUT('userId:');
      DBMS_OUTPUT.PUT_LINE(OUTTABLE.COL3);
    DBMS_OUTPUT.PUT('username:');
      DBMS_OUTPUT.PUT_LINE(OUTTABLE.COL4);
    DBMS_OUTPUT.PUT_LINE('');
  END LOOP;
  CLOSE REFCUR;
END;

--all users in task
procedure UsersInTask(inTaskId in number, 
                                        cursor in out sys_refcursor)
is
BEGIN
  open cursor for 
  select t.id, t.taskName, u.id, u.userName
  from UsersTasks ut inner join Tasks t on ut.taskId = t.id 
  inner join Users u on u.id = ut.userId
  where t.id = inTaskId;
end;

procedure ViewUsersInTask(inTaskId IN NUMBER)
is
  REFCUR SYS_REFCURSOR;
  TYPE RECORDTYPE IS RECORD (COL1 NUMBER, COL2 VARCHAR(100), COL3 NUMBER, COL4 VARCHAR(100));
  outtable RECORDTYPE;
BEGIN
  UsersInTask(inTaskId, REFCUR);
  LOOP
  FETCH REFCUR INTO outtable;
    EXIT WHEN REFCUR%NOTFOUND;
    DBMS_OUTPUT.PUT('taskId:');
      DBMS_OUTPUT.PUT_LINE(OUTTABLE.COL1);
    DBMS_OUTPUT.PUT('taskName:');
      DBMS_OUTPUT.PUT_LINE(OUTTABLE.COL2);
    DBMS_OUTPUT.PUT('userId:');
      DBMS_OUTPUT.PUT_LINE(OUTTABLE.COL3);
    DBMS_OUTPUT.PUT('username:');
      DBMS_OUTPUT.PUT_LINE(OUTTABLE.COL4);
    DBMS_OUTPUT.PUT_LINE('');
  END LOOP;
  CLOSE REFCUR;
END;

--all files in task
procedure FilesInTask(inTaskId in number, 
                                        cursor in out sys_refcursor)
is
BEGIN
  open cursor for 
  select t.id, t.taskName, f.fileUrl
  from TaskFiles f inner join Tasks t on f.taskId = t.id
  where t.id = inTaskId;
end;

procedure ViewFilesInTask(inTaskId IN NUMBER)
is
  REFCUR SYS_REFCURSOR;
  TYPE RECORDTYPE IS RECORD (COL1 NUMBER, COL2 VARCHAR(100), COL3 VARCHAR(4000));
  outtable RECORDTYPE;
BEGIN
  FilesInTask(inTaskId, REFCUR);
  LOOP
  FETCH REFCUR INTO outtable;
    EXIT WHEN REFCUR%NOTFOUND;
    DBMS_OUTPUT.PUT('taskId:');
      DBMS_OUTPUT.PUT_LINE(OUTTABLE.COL1);
    DBMS_OUTPUT.PUT('taskName:');
      DBMS_OUTPUT.PUT_LINE(OUTTABLE.COL2);
    DBMS_OUTPUT.PUT('url:');
      DBMS_OUTPUT.PUT_LINE(OUTTABLE.COL3);
    DBMS_OUTPUT.PUT_LINE('');
  END LOOP;
  CLOSE REFCUR;
END;

--get user information
procedure GetUserInformation (inuserid in number, cursor in out sys_refcursor)
is
begin
  open cursor for select u.id, u.username, u.email, u.roleid, rol.role
  from users u inner join userroles rol on rol.id=u.roleid where u.id=inuserid; 
end;

procedure ViewUserInformaion(inUserId IN NUMBER)
is
  refcur sys_refcursor;
  TYPE RECORDTYPE IS RECORD (COL1 NUMBER, COL2 VARCHAR(100), COL3 VARCHAR(320), COL4 number, COL5 varchar2(100));
  outtable RECORDTYPE;
begin
  GetUserInformation(inUserId, REFCUR);
  LOOP
  FETCH REFCUR INTO outtable;
    EXIT WHEN REFCUR%NOTFOUND;
    DBMS_OUTPUT.PUT('userId:');
      dbms_output.put_line(outtable.col1);
    DBMS_OUTPUT.PUT('username:');
      dbms_output.put_line(outtable.col2);
    DBMS_OUTPUT.PUT('email:');
      dbms_output.put_line(outtable.col3);
    dbms_output.put('roleid:');
      dbms_output.put_line(outtable.col4);
    dbms_output.put('role:');
      DBMS_OUTPUT.PUT_LINE(OUTTABLE.COL5);  
    DBMS_OUTPUT.PUT_LINE('');
  END LOOP;
  close refcur;
end;
end viewpackage;