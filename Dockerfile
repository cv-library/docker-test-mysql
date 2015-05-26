FROM debian:jessie

RUN apt-get update

RUN apt-get install -y mysql-common

RUN DEBIAN_FRONTEND=noninteractive apt-get install -q -y mysql-server

RUN sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/mysql/my.cnf

RUN /etc/init.d/mysql restart && mysql -u root -h localhost --port 3306 -e "GRANT ALL PRIVILEGES ON *.* TO root@'%' WITH GRANT OPTION;"

EXPOSE 3306

CMD ["/usr/bin/mysqld_safe"]

