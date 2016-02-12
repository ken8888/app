drop table class;
create table class(
section_id int,
course_title varchar(10),
term varchar(10),
instructor varchar(10),
enrolled int,
seats int,
waitlist int,
primary key(section_id),
foreign key(course_title) references course(coursenumber)
);