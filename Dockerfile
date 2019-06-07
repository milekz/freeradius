FROM alpine:3.8

ENV FREERADIUS_VERSION=2.2.10

RUN apk update && apk upgrade && \
apk add --update build-base sqlite postgresql-dev openssl python2-dev perl-dev mariadb-connector-c-dev unixodbc-dev krb5-dev wxgtk2.8-dev openldap-dev gdbm-dev && \
wget ftp://ftp.freeradius.org/pub/freeradius/freeradius-server-$FREERADIUS_VERSION.tar.gz -O /tmp/freeradius.tar.gz && \
tar -C /tmp -xvf /tmp/freeradius.tar.gz && \
cd /tmp/freeradius-server-$FREERADIUS_VERSION && \
./configure --sysconfdir=/etc && \
make && \
make install && \
apk del build-base postgresql-dev python2-dev perl-dev mariadb-connector-c-dev unixodbc-dev krb5-dev wxgtk2.8-dev openldap-dev gdbm-dev && \
rm -rf /var/cache/apk/* && \
cd /tmp && \
rm -rf *


EXPOSE \
    1812/udp \
    1813/udp 

CMD ["radiusd","-X","-f"]


