--all user teams
CREATE OR REPLACE procedure TeamsByUser(inUserId in number, 
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

CREATE OR REPLACE PROCEDURE ViewTeamsByUser(INUSERID IN NUMBER)
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

BEGIN
  ViewTeamsByUser(21);
END;

--all comments in task
CREATE OR REPLACE procedure CommentsInTask(inTaskId in number, 
                                        cursor in out sys_refcursor)
is
BEGIN
  open cursor for 
  select ut.id, co.creatorId, u.userName, co.commentContent, co.dateOfCreation 
  from UsersTasks ut inner join Users u on ut.userId = u.id 
  inner join Comments co on co.creatorId = u.id
  where ut.taskId = inTaskId;
end;

CREATE OR REPLACE PROCEDURE ViewCommentsInTask(inTaskId IN NUMBER)
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

BEGIN
  ViewCommentsInTask(2);
END;

--all tasks in team
CREATE OR REPLACE procedure TasksByTeam(inTeamId in number, 
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

CREATE OR REPLACE PROCEDURE ViewTasksByTeam(inTeamId IN NUMBER)
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
END;

BEGIN
  ViewTasksByTeam(1);
END;


--all users in team
CREATE OR REPLACE procedure UsersInTeam(inTeamId in number, 
                                        cursor in out sys_refcursor)
is
BEGIN
  open cursor for 
  select t.id, t.teamName, u.id, u.userName
  from UsersTeams ut inner join Teams t on ut.teamId = t.id 
  inner join Users u on u.id = ut.userId
  where t.id = inTeamId;
end;

CREATE OR REPLACE PROCEDURE ViewUsersInTeam(inTeamId IN NUMBER)
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

BEGIN
  ViewUsersInTeam(1);
END;

--all users in task
CREATE OR REPLACE procedure UsersInTask(inTaskId in number, 
                                        cursor in out sys_refcursor)
is
BEGIN
  open cursor for 
  select t.id, t.taskName, u.id, u.userName
  from UsersTasks ut inner join Tasks t on ut.taskId = t.id 
  inner join Users u on u.id = ut.userId
  where t.id = inTaskId;
end;

CREATE OR REPLACE PROCEDURE ViewUsersInTask(inTaskId IN NUMBER)
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

BEGIN
  ViewUsersInTask(2);
END;

--all files in task
CREATE OR REPLACE procedure FilesInTask(inTaskId in number, 
                                        cursor in out sys_refcursor)
is
BEGIN
  open cursor for 
  select t.id, t.taskName, f.fileUrl
  from TaskFiles f inner join Tasks t on f.taskId = t.id
  where t.id = inTaskId;
end;

CREATE OR REPLACE PROCEDURE ViewFilesInTask(inTaskId IN NUMBER)
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

BEGIN
  ViewFilesInTask(2);
END;