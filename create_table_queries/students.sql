drop table student;
create table student(
	ssn int not null unique,
	id varchar(10) not null,
	firstname varchar(10),
	middlename varchar(10),
	lastname varchar(10),
	residency varchar(10),
	enrollment varchar(10),
	primary key(id)
	);