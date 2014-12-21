#!/bin/bash

init() {
    DIR="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
    DB_NAME="$1"
    BACKUP_NAME="$2"
}

store_mysql() {
    echo "mysql dumping ${DB_NAME} from ${BACKUP_NAME} > ";
    cd ${DIR}; ./mysql.store.sh ${DB_NAME} dumps/${BACKUP_NAME}
    echo "mysql dumping finished.";
}

store_mongo() {
    echo "mongo dumping ${DB_NAME} to ${BACKUP_NAME} > ";
    cd ${DIR}; ./mongodb.store.sh ${DB_NAME} dumps/${BACKUP_NAME}
    echo "mongo dumping finished.";
}

main() {
    init $1 $2

    store_mysql
    store_mongo
}
main $*
