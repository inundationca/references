# change [DATABASE] to the name of the database you'd like to modify.

use information_schema;
SELECT concat("ALTER DATABASE `",table_schema,"` CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin;") as _sql
FROM `TABLES` where table_schema like "[DATABASE]" and TABLE_TYPE='BASE TABLE' group by table_schema;
SELECT concat("ALTER TABLE `",table_schema,"`.`",table_name,"` CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_bin;") as _sql  
FROM `TABLES` where table_schema like "[DATABASE]" and TABLE_TYPE='BASE TABLE' group by table_schema, table_name;
SELECT concat("ALTER TABLE `",table_schema,"`.`",table_name, "` CHANGE `",column_name,"` `",column_name,"` ",data_type,"(",character_maximum_length,") CHARACTER SET utf8mb4 COLLATE utf8mb4_bin",IF(is_nullable="YES"," NULL"," NOT NULL"),";") as _sql
FROM `COLUMNS` where table_schema like "[DATABASE]" and data_type in ('varchar','char');
SELECT concat("ALTER TABLE `",table_schema,"`.`",table_name, "` CHANGE `",column_name,"` `",column_name,"` ",data_type," CHARACTER SET utf8mb4 COLLATE utf8mb4_bin",IF(is_nullable="YES"," NULL"," NOT NULL"),";") as _sql
FROM `COLUMNS` where table_schema like "[DATABASE]" and data_type in ('text','tinytext','mediumtext','longtext');