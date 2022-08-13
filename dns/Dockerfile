FROM ubuntu:latest

RUN apt-get -y update
RUN apt-get install -y bind9

RUN mkdir -p /etc/bind/zones
COPY zones_dns/db.mes-b2 /etc/bind/zones
COPY conf/named.conf /etc/bind
COPY conf/named.conf.options /etc/bind/named.conf.options
COPY conf/named.conf.default-zones /etc/bind/named.conf.default-zones
COPY conf/named.conf.local /etc/bind/named.conf.local

EXPOSE 53/udp
EXPOSE 53/tcp

CMD ["/usr/sbin/named", "-g", "-c", "/etc/bind/named.conf", "-u", "bind"]