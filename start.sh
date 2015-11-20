#!/bin/bash

/docker-entrypoint.sh mysqld

cd /app

mysqld --skip-networking &
pid="$!"
mysqlp=( mysql --protocol=socket -uroot )

for i in {5..0}; do
	if echo 'SELECT 1' | "${mysqlp[@]}" &> /dev/null; then
		break
	fi
	echo '2 MySQL init process in progress...'
	sleep 1
done
if [ "$i" = 0 ]; then
	echo >&2 '2 MySQL init process failed.'
	exit 1
fi

mysql -u$MYSQL_USER -p$MYSQL_PASSWORD $MYSQL_DATABASE < db/dump.sql
php /dbmigrate.php
mysql -u$MYSQL_USER -p$MYSQL_PASSWORD $MYSQL_DATABASE < /setup.sql

if ! kill -s TERM "$pid" || ! wait "$pid"; then
	echo >&2 '2 MySQL init process failed.'
	exit 1
fi
