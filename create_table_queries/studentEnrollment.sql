create table studentenrollment(
studentid varchar(10),
term varchar(10),
foreign key(studentid) references student(id)
);