#!/usr/bin/env bash
source config.sh


read -s -p "Enter root password: " root_password

mysqladmin --host=$db_mysql_host --port=$db_mysql_port --user=$db_mysql_username --password=$root_password --force drop $1
mysqladmin --host=$db_mysql_host --port=$db_mysql_port --user=$db_mysql_username --password=$root_password --force create $1
mysql      --host=$db_mysql_host --port=$db_mysql_port --user=$db_mysql_username --password=$root_password $1 < $2/$db_project_name.structure.sql
mysql      --host=$db_mysql_host --port=$db_mysql_port --user=$db_mysql_username --password=$root_password $1 < $2/$db_project_name.data.sql
