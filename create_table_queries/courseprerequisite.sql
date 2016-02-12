drop table courseprerequisite;
create table courseprerequisite(
coursenumber varchar(10),
pre_course_number varchar(10),
foreign key(coursenumber) references course(coursenumber),
foreign key(pre_course_number) references course(coursenumber)
);