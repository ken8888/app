drop table undergraduate;
create table undergraduate(
studentid varchar(50),
major varchar(50),
minor varchar(50),
college varchar(50),
degree varchar(50),
foreign key(studentid) references student(id)
);