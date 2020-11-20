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
create or replace procedure DeleteComment(commentId in number) 
is 
begin
  delete from Comments where id = commentId;
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
create or replace procedure DeleteCommentsInTask(taskId in number) 
is 
begin
  delete from Comments where taskid = taskid;
  commit;
end;

--alter comment
create or replace procedure UpdateComment (commentContent in varchar2)
is 
begin
  update Comments set commentContent = commentContent;
  commit;
end;
