begin
  RegistrationUser('Test', 'test');
end;

begin
  AuthorizeUser('Anna','help'); 
end;
begin
  ChangePassword(61,'help'); 
end;

declare userId number;
begin
  searchuserbyname('Hanna',userid); 
  dbms_output.put_line(userId);
end;


begin
  DeleteUser(41); 
end;
select * from Users where username = 'Test';

begin
  createteam(21,'team1',null,1);
  createteam(21,'team2',null,1);
end;

begin
  deleteallteams(21);
end;

begin
  createtask(1, 'Test', null, Sysdate, 21);
end;

begin
  completedtask(1);
end;

begin
  AddComment(21, 'I want to sleep', 2);
end;

begin
  DeleteTask(1);
end;

begin
  AddUserInTask(21, 2);
end;

begin
  DeleteUserFromTeam(21, 2);
end;

select * from usersteams;

select * from tasks;
select * from UsersTasks;
select * from Comments;
select * from system.users;
