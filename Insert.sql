declare
    x number(10) := 1;
    string varchar(20);
begin

    while (x < 100000)
        loop
            x:= x + 1;
            string := concat('Name',to_char(x));
            RegistrationUser(string, 'test');
        end loop;
end;

declare
    x number(10) := 1;
    string varchar(20);
begin

    while (x < 100000)
        loop
            x:= x + 1;
            string := concat('Name',to_char(x));
            DeleteUser(x);
        end loop;
end;

select count(*) from users;