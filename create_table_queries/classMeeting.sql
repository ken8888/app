drop table classMeeting;
create table classMeeting(
sectionid int,
meetingid int,
foreign key(sectionid) references class(section_id),
primary key(meetingid)
);