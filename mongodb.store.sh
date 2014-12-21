#!/usr/bin/env bash
source config.sh

mkdir -p $2
mongodump --host=$db_mongodb_host --port=$db_mongodb_port --db $1 -o $2