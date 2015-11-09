#!/bin/bash
source config.sh

error() {
    ERR="$@"
    printf 'ERROR:%s\n' "$@" >&2
}

debug() {
    if [[ "$DEBUG" != "no" ]]; then
        printf 'DEBUG:%s\n' "$@" >&2
    fi
}

download_backup() {
	API_URL="$1" 
	API_TOKEN="$2"
	BACKUP_FILE="$3" 
	LOCAL_FILE="$4"

	cmd="curl ${API_URL}${storage_container}/${BACKUP_FILE} -H \"X-Auth-Token: ${API_TOKEN}\" -o ${LOCAL_FILE}"
	eval $cmd
	
}

main() {
	BACKUP_DATE="$1"
	#BACKUP_MONTH=`date --date=${BACKUP_DATE} +%Y-%m`;
	BACKUP_MONTH="2015-11"

	mysqlFileName="${BACKUP_DATE}.mysql.tar.gz"
	mongodbFileName="${BACKUP_DATE}.mongodb.tar.gz"
	
	AUTH_URL="https://auth.selcdn.ru/"
	AUTH_DAT="$(curl -i ${AUTH_URL} -H "X-Auth-User:${storage_user}" -H "X-Auth-Key:${storage_password}"  2>&1)"

	API_URL=`echo "$AUTH_DAT" | grep 'X-Storage-Url:'|sed 's/X-Storage-Url: //'`
	API_URL=`echo "$API_URL" | sed 's/.$//'`
	API_TOKEN=`echo "$AUTH_DAT" | grep 'X-Auth-Token:'|sed 's/X-Auth-Token: //'`
	API_TOKEN=`echo "$API_TOKEN" | sed 's/.$//'`

	download_backup $API_URL $API_TOKEN "${BACKUP_MONTH}/${mysqlFileName}" "dumps/${mysqlFileName}"
	download_backup $API_URL $API_TOKEN "${BACKUP_MONTH}/${mongodbFileName}" "dumps/${mongodbFileName}"

	cd dumps; tar -zxf ${mysqlFileName}; tar -zxf ${mongodbFileName}	
}

main $*