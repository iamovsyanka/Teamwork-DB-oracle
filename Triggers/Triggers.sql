--users triggers
create or replace trigger AfterUserInsert
after insert on users
begin
  Dbms_Output.Put_Line('USER INSERTED');
end;

Create Or Replace Trigger AfterUserUpdate
after update on users
Begin
  Dbms_Output.Put_Line('USER UPDATED');
end;

Create Or Replace Trigger AfterUserDelete
after delete on users
Begin
  Dbms_Output.Put_Line('USER DELETED');
end;

--tasks triggers
Create Or Replace Trigger AfterTaskinsert
after insert on tasks
Begin
  Dbms_Output.Put_Line('TASK INSERTED');
end;

Create Or Replace Trigger AfterTaskUpdate
after update on tasks
Begin
  Dbms_Output.Put_Line('TASK UPDATED');
end;

Create Or Replace Trigger AfterTaskDelete
after delete on tasks
Begin
  Dbms_Output.Put_Line('TASK DELETED');
End;

--teams triggers
Create Or Replace Trigger Afterteaminsert
after insert on teams
Begin
  Dbms_Output.Put_Line('TEAM INSERTED');
end;

Create Or Replace Trigger Afterteamupdate
after update on teams
Begin
  Dbms_Output.Put_Line('TEAM UPDATED');
end;

Create Or Replace Trigger Afterteamdelete
after delete on teams
Begin
  Dbms_Output.Put_Line('TEAM DELETED');
End;

--comments triggers
Create Or Replace Trigger Aftercommentinsert
after insert on comments
Begin
  Dbms_Output.Put_Line('COMMENT INSERTED');
end;

Create Or Replace Trigger Aftercommentupdate
after update on comments
Begin
  Dbms_Output.Put_Line('COMMENT UPDATED');
end;

Create Or Replace Trigger Aftercommentdelete
after delete on comments
Begin
  Dbms_Output.Put_Line('COMMENT DELETED');
End;

--usertasks triggers
Create Or Replace Trigger Afterusersteamsinsert
after insert on usersteams
Begin
  Dbms_Output.Put_Line('ADD USER TO TEAM');
end;

Create Or Replace Trigger Afteruersteamsdelete
after delete on usersteams
Begin
  Dbms_Output.Put_Line('DELETE USER FROM TEAM');
End;

--userstasks triggers
Create Or Replace Trigger Afteruserstasksinsert
after insert on userstasks
Begin
  Dbms_Output.Put_Line('ADD USER TO TASK');
end;

Create Or Replace Trigger Afteruserstasksdelete
after delete on userstasks
Begin
  Dbms_Output.Put_Line('DELETE USER FROM TASK');
End;

