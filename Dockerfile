FROM debian:jessie

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update                                          \
 && apt-get -y --no-install-recommends install mysql-server \
 && rm -fr /var/lib/apt/lists/*                             \
 && sed -ie s/127.0.0.1/0.0.0.0/ /etc/mysql/my.cnf          \
 && /etc/init.d/mysql restart                               \
 && mysql -e 'GRANT ALL PRIVILEGES ON *.* TO root@"%" WITH GRANT OPTION'

EXPOSE 3306

CMD ["/usr/bin/mysqld_safe"]
