create table studentEnrollment(
studentid varchar(50),
COURSENUMBER VARCHAR(50),
SECTIONID VARCHAR(50),
term varchar(50),
UNITS VARCHAR(50)
foreign key(studentid) references student(id)
);