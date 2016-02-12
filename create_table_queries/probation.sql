create table probation(
	id int not null unique,
	studentid varchar(10),
	startdate varchar(10),
	enddate varchar(10),
	reason varchar(10),
	primary key (id)
	);