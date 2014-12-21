#!/usr/bin/env bash
source config.sh

read -s -p "Enter root password: " root_password

mysqldump -h $db_mysql_host -p $db_mysql_port -u $db_mysql_username -p$root_password --single-transaction --no-create-db --no-data --routines --quick $1 > $2/$db_project_name.structure.sql
mysqldump -h $db_mysql_host -p $db_mysql_port -u $db_mysql_username -p$root_password --single-transaction --no-create-db --no-create-info  --quick $1 > $2/$db_project_name.data.sql
