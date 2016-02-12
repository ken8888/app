drop table undergraduate;
create table undergraduate(
studentid varchar(10),
major varchar(10),
minor varchar(10),
college varchar(10),
degree varchar(10),
foreign key(studentid) references student(id)
);