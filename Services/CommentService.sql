--add comment
create or replace procedure AddComment
                              (userid in number,                              
                              commentContent in varchar2,
                              taskId in number) 
is 
begin
  insert into Comments(creatorId, dateOfCreation, commentContent, taskId) 
    values(userId, Sysdate, commentContent, taskId);
  commit;
end;

--delete comment 
create or replace procedure DeleteComment
                              (commentId in number,
                              userid in number, 
                              taskId in number) 
is 
begin
  delete from Comments where creatorid = userId and taskid = taskid and id = commentId;
  commit;
end;

--delete all comments in all tasks
create or replace procedure DeleteAllComments(userid in number) 
is 
begin
  delete from Comments where creatorid = userId;
  commit;
end;

--delete all comments in task
create or replace procedure DeleteCommentsInTask
                              (userid in number, 
                              taskId in number) 
is 
begin
  delete from Comments where creatorid = userId and taskid = taskid;
  commit;
end;