--add comment
create or replace procedure AddComment(inUserid in number,                              
                                       inCommentContent in varchar2,
                                       inTaskId in number) 
is 
begin
    insert into Comments(creatorId, 
                         dateOfCreation, 
                          commentContent, 
                          taskId) 
    values(inUserId, 
          Sysdate,
          inCommentContent, 
          inTaskId);
    commit;
    
       exception when others
      then dbms_output.put_line(sqlcode||' '||sqlerrm);
end;

--delete comment 
create or replace procedure DeleteComment(inCommentId in number) 
is 
begin
  delete from Comments where id = inCommentId;
  commit;
  
     exception when others
      then dbms_output.put_line(sqlcode||' '||sqlerrm);
end;

--delete all comments in all tasks
create or replace procedure DeleteAllComments(inUserid in number) 
is 
begin
  delete from Comments where creatorId = inUserId;
  commit;
  
     exception when others
      then dbms_output.put_line(sqlcode||' '||sqlerrm);
end;

--delete all comments in task
create or replace procedure DeleteCommentsInTask(inTaskId in number) 
is 
begin
  delete from Comments where taskId = inTaskId;
  commit;
  
     exception when others
      then dbms_output.put_line(sqlcode||' '||sqlerrm);
end;

--alter comment
create or replace procedure UpdateComment (inCommentContent in varchar2)
is 
begin
  update Comments set commentContent = inCommentContent;
  commit;
  
     exception when others
      then dbms_output.put_line(sqlcode||' '||sqlerrm);
end;