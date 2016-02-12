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