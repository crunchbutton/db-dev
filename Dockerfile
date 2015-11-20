FROM mariadb:latest

COPY start.sh /
COPY dbmigrate.php /
COPY setup.sql /

ENTRYPOINT ["/start.sh"]
