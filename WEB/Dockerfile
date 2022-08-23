# A partir d'une imagem ubuntu.
FROM debian:latest

# Installation de nginx sur l'image + des installation de packages utiles au bon fonctionnement du site
RUN apt update

# NGINX
RUN apt-get install -y nginx
RUN apt-get install -y nano

ARG DEBIAN_FRONTEND=noninteractive

# PHP et MySQL
# RUN apt-get install -y php7.4 php7.4-fpm
RUN apt-get install -y default-mysql-client

# Crée les dossiers où vont se trouver les sites html et php (index.html et index.php)
RUN mkdir -p /var/www/statique/
RUN mkdir -p /var/www/b2b/

# Copie les codes sources des pages WEB dans les dossiers correspondants
COPY sites/www/index.html /var/www/statique/
COPY sites/b2b/index.php  /var/www/b2b/

# Copie les configurations serveur dans les dossiers correspondants
COPY conf/www.conf /etc/nginx/sites-available/
COPY conf/b2b.conf /etc/nginx/sites-available/

# Ajout d'un lien entre sites-enabled et site-available
RUN ln -s /etc/nginx/sites-available/www.conf /etc/nginx/sites-enabled/
RUN ln -s /etc/nginx/sites-available/b2b.conf /etc/nginx/sites-enabled/

# Ecoute sur le port 80
EXPOSE 80

# Cette directive va lancer le service nginx en foreground
CMD nginx -g 'daemon off;'
