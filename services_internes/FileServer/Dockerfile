FROM ubuntu:latest


RUN apt-get update -y && apt-get upgrade -y
RUN apt-get install samba -y

RUN mkdir -p /etc/samba/partage
RUN mkdir -p /etc/samba/partage/direction
RUN mkdir -p /etc/samba/partage/commerciaux
RUN mkdir -p /etc/samba/partage/secretariat
RUN mkdir -p /etc/samba/partage/commun

RUN useradd --system --no-create-home -s /bin/false samba

RUN groupadd directiongroupe
RUN groupadd commerciauxgroupe
RUN groupadd secretariatgroupe


RUN usermod -a -G directiongroupe samba
RUN usermod -a -G commerciauxgroupe samba
RUN usermod -a -G secretariatgroupe samba


RUN chown samba:directiongroupe /partage/direction
RUN chown samba:commerciauxgroupe /partage/commerciaux
RUN chown samba:secretariatgroupe /partage/secretariat


RUN chown g+w /partage/direction
RUN chown g+w /partage/commerciaux
RUN chown g+w /partage/secretariat


RUN useradd --group commerciauxgroup directionUser1
RUN echo directionUser1:directionPassword | chpasswd

RUN useradd --group commerciauxgroup commercialUser1
RUN echo commercialUser1:commercialPassword | chpasswd

RUN useradd --group commerciauxgroup secretariatUser1
RUN echo secretariatUser1:secretariatPassword | chpasswd


RUN mv /etc/samba/smb.conf /etc/samba/smbOrignial.conf
COPY conf/smb.conf /etc/samba/smb.conf


EXPOSE 136:136
EXPOSE 445:445