FROM mariadb:latest

COPY entrypoint.sh /docker-entrypoint-initdb.d/
