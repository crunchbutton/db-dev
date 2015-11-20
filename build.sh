#!/bin/sh

docker rm -f crunchbutton-db-dev
docker build --rm=true -t crunchbutton-db-dev .
docker run -e MYSQL_ROOT_PASSWORD=root -e MYSQL_ROOT_USER=root -e MYSQL_USER=admin -e MYSQL_PASS=pass -e MYSQL_DATABASE=crunchbutton -p 3306:3306 -v ~/Sites/crunchbutton:/app/ --name crunchbutton-db-dev crunchbutton-db-dev


# or if you are having issues building you can use a single run command
# docker run --entrypoint="" -e DEBUG=1 -e DATABASE_URL=mysql://root:root@192.168.99.1:3306/crunchbutton -p 8000:80 -v $(pwd):/var/www/app/ --name crunchbutton arzynik/crunchbutton
