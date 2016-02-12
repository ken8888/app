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