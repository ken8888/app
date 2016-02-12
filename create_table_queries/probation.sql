create table probation(
	id int not null unique,
	studentid varchar(50),
	startdate varchar(50),
	enddate varchar(50),
	reason varchar(50),
	primary key (id)
	);