FROM debian:jessie

ENV DEBIAN_FRONTEND noninteractive

RUN echo deb http://ftp.debian.org/debian experimental main >> /etc/apt/sources.list \
 && apt-get update                                                                   \
 && apt-get -y --no-install-recommends install mysql-server-5.6                      \
 && rm -fr /var/lib/apt/lists/*                                                      \
 && service mysql start                                                              \
 && mysql -e 'GRANT ALL PRIVILEGES ON *.* TO root@"%" WITH GRANT OPTION'

EXPOSE 3306

ENTRYPOINT [                                \
    "mysqld",                               \
    "--no-defaults",                        \
    "--bind-address",            "0.0.0.0", \
    "--innodb-buffer-pool-size", "5M",      \
    "--user",                    "mysql"    \
]
