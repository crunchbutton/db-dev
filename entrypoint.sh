#!/bin/bash

mysql=( mysql --protocol=socket -u$MYSQL_ROOT_USER -p$MYSQL_ROOT_PASSWORD $MYSQL_DATABASE )
"${mysql[@]}" < /app/db/dump.sql
start=180

for f in /app/db/migrate/*; do
	new=$(echo $f | sed -e 's/^.*\([0-9]\{6\}\).*$/\1/')
	if [ "$new" -gt "$start" ]; then
		echo "$f"; "${mysql[@]}" < "$f";
	fi
done

"${mysql[@]}" < /app/db/dummy.sql
