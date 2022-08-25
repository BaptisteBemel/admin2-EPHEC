FROM ubuntu:latest
RUN apt-get update
RUN apt-get upgrade -y

# Installation des outils indispensables
ENV DEBIAN_FRONTEND="noninteractive"
RUN apt-get install -y mutt
RUN apt-get install sudo -y

# Génération du certificat SSL
# RUN openssl req -new -x509 -days 3650 -nodes -newkey rsa:4096 -out /etc/ssl/certs/mailserver.pem -keyout /etc/ssl/private/mailserver.pem -subj "/C=BE/ST=Braban-wallon/L=Wavre/O=Ephec/OU=IT/CN=mail.mes-b2.ephec-ti.be"

# Installation Database
RUN apt update
RUN apt-get install mariadb-server -y

COPY database_scripts/* /usr/bin/
RUN chmod +x /usr/bin/addmailusers
RUN chmod +x /usr/bin/delmailusers
RUN chmod +x /usr/bin/showmailusers
RUN chmod +x /usr/bin/readmailadmins
RUN chmod +x /usr/bin/readmailusers

# Configuration - Database

COPY config_database/create-db.sql config-sql/create-db.sql
COPY config_database/create-users.sql config-sql/create-users.sql


#####################################################
#################### POSTFIX ########################
#####################################################

# Installation de Postfix 
RUN apt-get install -y postfix postfix-mysql 

# Configuration de Postfix
RUN groupadd -g 5000 vhosts && useradd -g vhosts -u 5000 vhosts -d /var/mail/vhosts -s /bin/false -m

COPY config_postfix/main.cf /etc/postfix/main.cf
COPY config_postfix/master.cf /etc/postfix/master.cf
COPY config_postfix/generic /etc/postfix/generic
COPY config_postfix/mysql-virtual-mailbox-domains.cf /etc/postfix/mysql-virtual-mailbox-domains.cf
COPY config_postfix/mysql-virtual-mailbox-maps.cf /etc/postfix/mysql-virtual-mailbox-maps.cf
RUN postmap /etc/postfix/generic

CMD ["mysqld"]
CMD ["postfix", "start-fg"]


#####################################################
#################### DEVECOT ########################
#####################################################

RUN apt-get install -y dovecot-core dovecot-imapd dovecot-mysql
RUN apt-get install -y dovecot-sieve dovecot-managesieved

# Configuration de Dovecot 

COPY config_dovecot/dovecot.conf /etc/dovecot/dovecot.conf
COPY config_dovecot/dovecot-sql.conf.ext /etc/dovecot/dovecot-sql.conf.ext

COPY config_dovecot/10-auth.conf /etc/dovecot/conf.d/10-auth.conf
COPY config_dovecot/10-mail.conf /etc/dovecot/conf.d/10-mail.conf
COPY config_dovecot/10-master.conf /etc/dovecot/conf.d/10-master.conf

COPY config_dovecot/auth-sql.conf.ext /etc/dovecot/conf.d/auth-sql.conf.ext
COPY config_dovecot/10-ssl.conf /etc/dovecot/conf.d/10-ssl.conf

COPY config_dovecot/20-lmtp.conf /etc/dovecot/conf.d/20-lmtp.conf
COPY config_dovecot/default.sieve /var/lib/dovecot/sieve/default.sieve

RUN sievec /var/lib/dovecot/sieve/default.sieve
RUN chown -R vhosts:vhosts /var/lib/dovecot/sieve/*
RUN chmod a+x /var/lib/dovecot

### SPAM ASSASSIN
RUN apt-get install -y spamassassin spamc
RUN groupadd spamd
RUN useradd -g spamd -s /bin/false -d /var/log/spamassassin spamd
RUN mkdir /var/log/spamassassin
RUN chown spamd:spamd /var/log/spamassassin

COPY config_spam/spamassassin /etc/default/spamassassin
COPY config_spam/local.cf /etc/spamassassin/local.cf

### SPF

### DKIM / DMARC

EXPOSE 25 143 465 587 993

CMD ["sh", "-c", "service mysql start; mysql -u root < config-sql/create-db.sql; mysql -u root < config-sql/create-users.sql; service postfix start; service spamassassin start; service dovecot start; tail -F /var/log/mail.log"]
