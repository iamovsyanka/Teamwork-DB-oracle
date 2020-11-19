begin
  RegistrationUser('Hanna', 'svn');
end;

begin
  AuthorizeUser('Testing','testing'); 
end;

select * from Users;

begin
  createteam(21,'gbljhh','hgsddak',1);
end;

begin
  deleteteam(21, 1);
end;


select * from teams;