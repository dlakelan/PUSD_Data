library(RSQLite)
library(readr)

unlink("CAASPP.db")
pdb <- dbConnect(RSQLite::SQLite(),"CAASPP.db")

## read in the entities data by year, and aggregate it into a single
## table


for (i in list.files(".",pattern="*entities*")){
    dat = read_csv(i)
    dbWriteTable(pdb,"tempdat",dat)
    dbGetQuery(pdb,"create table if not exists entities as select * from tempdat limit 0;")
    dbGetQuery(pdb,"insert into entities select * from tempdat");
    dbRemoveTable(pdb,"tempdat");
}

## read in the group data file:
dat=read_csv("Subgroups.txt")
dbWriteTable(pdb,"subgroups",dat,overwrite=TRUE)

## read in the test data file:
dat=read_csv("Tests.txt")
dbWriteTable(pdb,"tests",dat,overwrite=TRUE)


## read in the all groups test results data by year, split it out, as
## it's a joined table. In particular, keep only the entity,date,
## group, score info

## first, read in each file and put it in its own table... we'll
## manipulate things in SQL

for (i in list.files(".",pattern=".*_all_csv.*txt")){
    dat = read_csv(i,na=c("","NA","*"))
    yr=gsub(".*(20[1-2][0-9]).*","\\1",i)
    dbWriteTable(pdb, paste("alldat_tempdat",yr,sep=""),dat,overwrite=TRUE)
}

system("echo '.read combine_scores.sql' | sqlite3 CAASPP.db ")
