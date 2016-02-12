drop table singleMeeting;
create table singleMeeting(
meetingid int,
meeting_type varchar(10),
building_name varchar(10),
room_number varchar(10),
start_time varchar(10),
end_time varchar(10),
attendance varchar(10),
_date varchar(10),
foreign key(meetingid) references classMeeting(meetingid)
);