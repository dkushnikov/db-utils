#!/usr/bin/env bash
source config.sh


mongo --host=$db_mongodb_host --port=$db_mongodb_port $1 --eval 'db.dropDatabase();'
mongorestore --host=$db_mongodb_host --port=$db_mongodb_port --drop --db $1 $2/$db_project_name
