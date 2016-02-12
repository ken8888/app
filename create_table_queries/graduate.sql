create table graduate(
	studentid varchar(10),
	deptname varchar(10),
	classification varchar(10),
	is_precandidate varchar(10),
	is_candidate varchar(10),
	candidate_advisor varchar(10),
	committeeid varchar(10),
	foreign key (studentid) references student(id)
	);