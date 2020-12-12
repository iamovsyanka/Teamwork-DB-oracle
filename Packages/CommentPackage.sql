create or replace package commentpackage as
  procedure AddComment(inUserid in number,                              
                                       incommentcontent in varchar2,
                                       intaskid in number);
  procedure deletecomment(incommentid in number);
  procedure deleteallcomments(inuserid in number);
  procedure deletecommentsintask(intaskid in number);
  procedure UpdateComment (inCommentContent in varchar2);
end CommentPackage;

create or replace package body commentpackage as
  --add comment
  procedure AddComment(inUserid in number,                              
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
  procedure DeleteComment(inCommentId in number) 
  is 
  begin
    delete from Comments where id = inCommentId;
    commit;
    
       exception when others
        then dbms_output.put_line(sqlcode||' '||sqlerrm);
  end;
  
  --delete all comments in all tasks
  procedure DeleteAllComments(inUserid in number) 
  is 
  begin
    delete from Comments where creatorId = inUserId;
    commit;
    
       exception when others
        then dbms_output.put_line(sqlcode||' '||sqlerrm);
  end;
  
  --delete all comments in task
  procedure DeleteCommentsInTask(inTaskId in number) 
  is 
  begin
    delete from Comments where taskId = inTaskId;
    commit;
    
       exception when others
        then dbms_output.put_line(sqlcode||' '||sqlerrm);
  end;
  
  --alter comment
  procedure UpdateComment (inCommentContent in varchar2)
  is 
  begin
    update Comments set commentContent = inCommentContent;
    commit;
    
       exception when others
        then dbms_output.put_line(sqlcode||' '||sqlerrm);
  end;
end commentpackage;