#!/bin/bash

init() {
    DIR="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
    DB_NAME="$1"
    BACKUP_NAME="$2"
}

restore_mysql() {
    echo "mysql restoring ${DB_NAME} from ${BACKUP_NAME} > ";
    cd ${DIR}; ./mysql.restore.sh ${DB_NAME} ${BACKUP_NAME}
    echo "mysql restoring finished.";
}

restore_mongo() {
    echo "mongo restoring ${DB_NAME} from ${BACKUP_NAME} > ";
    cd ${DIR}; ./mongodb.restore.sh ${DB_NAME} ${BACKUP_NAME}
    echo "mongo restoring finished.";
}

main() {
    init $1 $2
    restore_mysql
    case $3 in
        --no-mongo)
        ;;
        *)
        restore_mongo
        ;;
    esac

}
main $*
