drop table student;
create table student(
	ssn int not null unique,
	id varchar(50) not null,
	firstname varchar(50),
	middlename varchar(50),
	lastname varchar(50),
	residency varchar(50),
	enrollment varchar(50),
	primary key(ssn)
	);