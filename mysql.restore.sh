#!/usr/bin/env bash
source config.sh


read -s -p "Enter root password: " root_password

mysqladmin -h $db_mysql_host -p $db_mysql_port -f -u $db_mysql_username -p$root_password drop $1
mysqladmin -h $db_mysql_host -p $db_mysql_port -f -u $db_mysql_username -p$root_password create $1
mysql      -h $db_mysql_host -p $db_mysql_port    -u $db_mysql_username -p$root_password $1 < $2/$db_project_name.structure.sql
mysql      -h $db_mysql_host -p $db_mysql_port    -u $db_mysql_username -p$root_password $1 < $2/$db_project_name.data.sql