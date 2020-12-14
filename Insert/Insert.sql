declare
    x number(10) := 1;
    username varchar(20);
begin

    while (x < 100000)
        loop
            x:= x + 1;
            username := concat('Name',to_char(x));
            userpackage.RegistrationUser(username, 'gmail@gmail.com', 'test');
        end loop;
end;

select count(*) from users;
select * from curs_db_admin.viewusers;
delete from users;
commit;

declare
    x number(10) := 1;
    teamname varchar(20);
begin

    while (x < 10)
        loop
            x:= x + 1;
            teamname := concat('Team',to_char(x));
            teampackage.createTeam(156672, teamname, '', 1);
        end loop;
end;

select count(*) from teams;
select * from curs_db_admin.teams;