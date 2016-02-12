create table course(
title varchar(50),
department varchar(50),
coursenumber varchar(50),
units varchar(50),
gradetype varchar(50),
division varchar(50),
consent varchar(50),
lab varchar(50),
primary key(coursenumber)
);


create table courseprerequisite(
coursenumber varchar(50),
pre_course_number varchar(50),
foreign key(coursenumber) references course(coursenumber),
foreign key(pre_course_number) references course(coursenumber)
);


create table class(
section_id int,
course_title varchar(50),
term varchar(50),
instructor varchar(50),
enrolled int,
seats int,
waitlist int,
primary key(section_id),
foreign key(course_title) references course(coursenumber)
);


create table classMeeting(
sectionid int,
meetingid int,
foreign key(sectionid) references class(section_id),
primary key(meetingid)
);

create table concentration(
	name varchar(50),
	reqcourse varchar(50),
	);

	create table degree(
    	id varchar(50),
    	title varchar(50),
    	deptname varchar(50),
    	unitsreq int,
    	primary key(id)
    	);

    	create table degreeCategory(
        degreeid varchar(50),
        category varchar(50),
        lowerdivunits int,
        upperdivunits int,
        gpareq varchar(50),
        foreign key(degreeid) references degree(id)
        );

        create table department(
        	name varchar(50),
        	abbrev varchar(50),
        	primary key(name)
        	);

        	create table faculty(
            lastname varchar(50),
            firstname varchar(50),
            middlename varchar(50),
            title varchar(50),
            deptname varchar(50)
            primary key(lastname)
            );


create table pastclass(

	student_id varchar(50),
	course_number varchar(50),
	section_id int,
	term varchar(50),
	grade_type varchar(50),
	units varchar(50),
	grade_received varchar(50)
	);

	create table probation(
    	id int not null unique,
    	studentid varchar(50),
    	startdate varchar(50),
    	enddate varchar(50),
    	reason varchar(50),
    	primary key (id)
    	);

    	drop table singleMeeting;
        create table singleMeeting(
        meetingid int,
        meeting_type varchar(50),
        building_name varchar(50),
        room_number varchar(50),
        start_time varchar(50),
        end_time varchar(50),
        attendance varchar(50),
        _date varchar(50),
        foreign key(meetingid) references classMeeting(meetingid)
        );


create table student(
	ssn int not null unique,
	id varchar(50) not null unique,
	firstname varchar(50),
	middlename varchar(50),
	lastname varchar(50),
	residency varchar(50),
	enrollment varchar(50),
	primary key(id)
	);

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

    	create table studentEnrollment(
        studentid varchar(50),
        COURSENUMBER VARCHAR(50),
        SECTIONID VARCHAR(50),
        term varchar(50),
        UNITS VARCHAR(50)
        foreign key(studentid) references student(id)
        );

        create table thesiscommittee(
        id varchar(50),
        facultyname varchar(50),
        facultydept varchar(50),
        );


        create table undergraduate(
        studentid varchar(50),
        major varchar(50),
        minor varchar(50),
        college varchar(50),
        degree varchar(50),
        foreign key(studentid) references student(id)
        );

        create table weeklymeeting(
        meetingid int,
        meeting_type varchar(50),
        building_name varchar(50),
        room_number varchar(50),
        attendance varchar(50),
        start_date varchar(50),
        end_date varchar(50),
        day varchar(50),
        start_time int,
        end_time int,
        foreign key(meetingid) references classMeeting(meetingid)
        );