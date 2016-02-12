create table graduate(
	studentid varchar(50),
	deptname varchar(50),
	classification varchar(50),
	is_precandidate varchar(50),
	is_candidate varchar(50),
	candidate_advisor varchar(50),
	committeeid varchar(50),
	foreign key (studentid) references student(id)
	);