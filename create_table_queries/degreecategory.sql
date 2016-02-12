create table degreeCategory(
degreeid varchar(50),
category varchar(50),
lowerdivunits int,
upperdivunits int,
gpareq varchar(50),
foreign key(degreeid) references degree(id)
);