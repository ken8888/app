drop table weeklymeeting;
drop table undergraduate;
drop table thesiscommittee;
drop table studentEnrollment;
drop table graduate;
drop table singleMeeting;
drop table probation;
drop table pastclass;
drop table degreeCategory;
drop table degree;
drop table concentration;
drop table classMeeting;
drop table class;
drop table faculty;
drop table courseprerequisite;
drop table course;
drop table department;
drop table student;

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

create table department(
name varchar(50),
abbrev varchar(50),
primary key(name)
);

create table course(
title varchar(50),
department varchar(50),
coursenumber varchar(50),
units varchar(50),
gradetype varchar(50),
division varchar(50),
consent varchar(50),
lab varchar(50),
primary key(coursenumber),
foreign key(department) references department(name)
);


create table courseprerequisite(
coursenumber varchar(50),
pre_course_number varchar(50),
foreign key(coursenumber) references course(coursenumber),
foreign key(pre_course_number) references course(coursenumber)
);

create table faculty(
name varchar(50),
title varchar(50),
deptname varchar(50)
primary key(name),
foreign key(deptname) references department(name)
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
foreign key(course_title) references course(coursenumber),
foreign key(instructor) references faculty(name)
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
mingpa varchar(50),
minunits int,
);

create table degree(
id varchar(50),
title varchar(50),
deptname varchar(50),
unitsreq int,
primary key(id),
foreign key(deptname) references department(name)
);

create table degreeCategory(
degreeid varchar(50),
category varchar(50),
lowerdivunits int,
upperdivunits int,
gpareq varchar(50),
techunits int,
graduateunits int,
foreign key(degreeid) references degree(id)
);

create table pastclass(
student_id varchar(50),
course_number varchar(50),
section_id int,
term varchar(50),
grade_type varchar(50),
units varchar(50),
grade_received varchar(50),
foreign key(student_id) references student(id),
foreign key(course_number) references course(coursenumber),
foreign key(section_id) references class(section_id)
);

create table probation(
id int not null unique,
studentid varchar(50),
startdate date,
enddate date,
reason varchar(50),
primary key (id),
foreign key(studentid) references student(id),
);

create table singleMeeting(
meetingid int,
meeting_type varchar(50),
building_name varchar(50),
room_number varchar(50),
start_time time,
end_time time,
attendance varchar(50),
_date date,
day varchar(50),
primary key(meetingid),
foreign key(meetingid) references classMeeting(meetingid)
);

create table graduate(
studentid varchar(50),
deptname varchar(50),
classification varchar(50),
is_precandidate varchar(50),
is_candidate varchar(50),
candidate_advisor varchar(50),
committeeid varchar(50),
degree varchar(50),
primary key(studentid),
foreign key (studentid) references student(id),
foreign key(deptname) references department(name),
foreign key(candidate_advisor) references faculty(name)
);

create table studentEnrollment(
studentid varchar(50),
COURSENUMBER VARCHAR(50),
SECTIONID int,
term varchar(50),
UNITS VARCHAR(50),
gradetype varchar(50),
foreign key(studentid) references student(id),
foreign key(coursenumber) references course(coursenumber),
foreign key(sectionid) references class(section_id)
);

create table thesiscommittee(
id varchar(50),
facultyname varchar(50),
facultydept varchar(50),
foreign key(facultyname) references faculty(name),
foreign key(facultydept) references department(name)
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
start_date date,
end_date date,
day varchar(50),
start_time time,
end_time time,
foreign key(meetingid) references classMeeting(meetingid),
);