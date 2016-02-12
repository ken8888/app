create table degreecategory(
degreeid varchar(10),
category varchar(10),
lowerdivunits int,
upperdivunits int,
gpareq varchar(10),
foreign key(degreeid) references degree(id)
);