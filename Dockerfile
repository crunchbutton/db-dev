FROM mariadb:latest

COPY entrypoint.sh /docker-entrypoint-initdb.d/
COPY dbmigrate.php /
COPY setup.sql /
