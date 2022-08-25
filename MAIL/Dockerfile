FROM ubuntu:latest
RUN apt update -y
RUN apt upgrade -y

RUN apt install nano mutt telnet mailutils bsd-mailx net-tools -y

#INSTALL SERVER MYSQL
RUN apt install mariadb-server -y \
    && service mariadb start

# CONFIGURE POSTFIX
RUN  apt install postfix postfix-mysql -y
COPY postfix/main.cf /etc/postfix/main.cf 
COPY postfix/virtual-users.cf /etc/postfix/virtual-users.cf 
COPY postfix/virtual-domains.cf /etc/postfix/virtual-domains.cf 
COPY postfix/virtual-email2email.cf /etc/postfix/virtual-email2email.cf

RUN  chmod -R o-rwx /etc/postfix
RUN  postmap -a mes-b2.ephec-ti.be mysql:/etc/postfix/virtual-domain.cf

RUN mkdir /var/mail/mes-b2.ephec-ti.be

# VMAIL
RUN groupadd -g 5000 vmail
RUN useradd -g vmail -u 5000 vmail -d /var/mail
RUN chown -R vmail:vmail /var/mail

# DOVECOT
RUN openssl req -newkey rsa:2048 -nodes -keyout /etc/ssl/private/dovecot.key -x509 -days 365 -out /etc/ssl/certs/dovecot.pem -subj "/C=BE/ST=Braban/L=Louvain-La-Neuve/O=EPHEC/OU=IT/CN=mail.m1-3.ephec-ti.be"
RUN  apt install dovecot-core dovecot-imapd dovecot-pop3d dovecot-lmtpd dovecot-mysql-y
COPY dovecot/dovecot.conf /etc/dovecot/dovecot.conf
COPY dovecot/dovecot-sql.conf.ext /etc/dovecot/dovecot-sql.conf.ext
COPY dovecot/conf.d/10-mail.conf /etc/dovecot/conf.d/10-mail.conf
COPY dovecot/conf.d/10-auth.conf /etc/dovecot/conf.d/10-auth.conf
COPY dovecot/conf.d/10-master.conf /etc/dovecot/conf.d/10-master.conf
COPY dovecot/conf.d/10-ssl.conf /etc/dovecot/conf.d/10-ssl.conf

# Installation de spamassassin
RUN apt install spamassassin spamc -y
RUN groupadd spamd
RUN useradd -g spamd -s /usr/sbin/nologin -d /var/log/spamassassin -m spamd
COPY spamassassin /etc/default/spamassassin

RUN chmod -R 755 /etc/postfix
# #1.INSTALL

ENTRYPOINT [ "service" ,"start" , "postfix;dovecot;msql" ]
