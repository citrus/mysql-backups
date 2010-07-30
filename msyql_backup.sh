#!/bin/sh

# 2010/7/30
# Spencer Steffen
# Citrus Media Group
# http://citrusme.com/
# http://github.com/citrus/mysql-backups

SCRIPT_NAME="MySQL Backups"
VERSION="0.0.3"

BACKUPS=/path/to/your/backups

MYSQL="$(which mysql)"
MYSQLDUMP="$(which mysqldump)"

HOST="localhost"
USER="root"
PASS="password"

NOW=$(date +"%d%H")


if [ ! -d $BACKUPS/$NOW/ ]; then
  echo "Creating $BACKUPS/$NOW"
  mkdir -p $BACKUPS/$NOW/
fi


DBS="$($MYSQL -h$HOST -u$USER -p$PASS -Bse 'show databases')"

for db in $DBS; do
  
  if [ "$db" != "information_schema" ]; then
  
    time=$(date +"%H-%M-%S")
    dump="$db-$time.sql"
        
    $MYSQLDUMP -h$HOST -u$USER -p$PASS $db > $BACKUPS/$NOW/$dump
    
    echo "$BACKUPS/$NOW/$dump saved!"
    
  fi
  
done

