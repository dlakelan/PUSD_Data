drop table if exists scores;
create table scores as select * from alldat_tempdat2019;
insert into scores select * from alldat_tempdat2018;
insert into scores select * from alldat_tempdat2017;


insert into scores select
`County Code`,
  `District Code` ,
  `School Code` ,
  `Filler` ,
  `Test Year` ,
  `Subgroup ID` ,
  `Test Type` ,
  `Total Tested At Entity Level` ,
  NULL as `Total Tested with Scores` ,
  `Grade` ,
  `Test Id` ,
  `CAASPP Reported Enrollment` ,
  `Students Tested` ,
  `Mean Scale Score` ,
  `Percentage Standard Exceeded` ,
  `Percentage Standard Met` ,
  `Percentage Standard Met and Above` ,
  `Percentage Standard Nearly Met` ,
  `Percentage Standard Not Met` ,
  `Students with Scores` ,
  `Area 1 Percentage Above Standard` ,
  `Area 1 Percentage At or Near Standard` as  `Area 1 Percentage Near Standard` ,
  `Area 1 Percentage Below Standard` ,
  `Area 2 Percentage Above Standard` ,
  `Area 2 Percentage At or Near Standard` as  `Area 2 Percentage Near Standard` ,
  `Area 2 Percentage Below Standard` ,
  `Area 3 Percentage Above Standard` ,
  `Area 3 Percentage At or Near Standard` as  `Area 3 Percentage Near Standard` ,
  `Area 3 Percentage Below Standard` ,
  `Area 4 Percentage Above Standard` ,
  `Area 4 Percentage At or Near Standard`  as  `Area 4 Percentage Near Standard` ,
  `Area 4 Percentage Below Standard`  from `alldat_tempdat2015`;

insert into scores select
`County Code`,
  `District Code` ,
  `School Code` ,
  `Filler` ,
  `Test Year` ,
  `Subgroup ID` ,
  `Test Type` ,
  `Total Tested At Entity Level` ,
  NULL as `Total Tested with Scores` ,
  `Grade` ,
  `Test Id` ,
  `CAASPP Reported Enrollment` ,
  `Students Tested` ,
  `Mean Scale Score` ,
  `Percentage Standard Exceeded` ,
  `Percentage Standard Met` ,
  `Percentage Standard Met and Above` ,
  `Percentage Standard Nearly Met` ,
  `Percentage Standard Not Met` ,
  `Students with Scores` ,
  `Area 1 Percentage Above Standard` ,
  `Area 1 Percentage Near Standard` ,
  `Area 1 Percentage Below Standard` ,
  `Area 2 Percentage Above Standard` ,
  `Area 2 Percentage Near Standard` ,
  `Area 2 Percentage Below Standard` ,
  `Area 3 Percentage Above Standard` ,
  `Area 3 Percentage Near Standard` ,
  `Area 3 Percentage Below Standard` ,
  `Area 4 Percentage Above Standard` ,
  `Area 4 Percentage Near Standard` ,
  `Area 4 Percentage Below Standard`  from `alldat_tempdat2016`;
  
  
select count(*) from scores;

drop table alldat_tempdat2015;
drop table alldat_tempdat2016;
drop table alldat_tempdat2017;
drop table alldat_tempdat2018;
drop table alldat_tempdat2019;

create unique index schooldata on scores (`County Code`,`District Code`,`School Code`,`Test Year`,`Subgroup ID`,`Grade`,`Test Id`);

create unique index entityID on entities (`County Code`,`District Code`,`School Code`,`Test Year`);
create unique index subgID on subgroups (`Demographic ID Num`);
create unique index testID on tests (`Test ID Num`);

create view uniqueentity as select `County Code`,`District Code`,`School Code`,`Type Id`,`County Name`,`District Name`,`School Name`,`Zip Code` from entities group by `County Code`,`District Code`,`School Code`;

create view pusdscores as select * from scores where `District Code`=64881;
create view lacountyscores as select * from scores where `County Code` = 19;


vacuum;

.schema
