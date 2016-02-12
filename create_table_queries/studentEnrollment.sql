create table studentEnrollment(
studentid varchar(50),
term varchar(50),
foreign key(studentid) references student(id)
);