create table weeklymeeting(
meetingid int,
meeting_type varchar(10),
building_name varchar(10),
room_number varchar(10),
attendance varchar(10),
start_date varchar(10),
end_date varchar(10),
day varchar(10),
start_time int,
end_time int,
foreign key(meetingid) references classMeeting(meetingid)
);