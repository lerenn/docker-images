FROM debian:jessie

# Installation de NGINX
RUN apt-get update
RUN apt-get install nginx -y

# Installation de dnsmasq
RUN apt-get install dnsmasq -y

# Création du dossier contenant les certificats
RUN mkdir /etc/nginx/certificates

# Volumes
VOLUME /etc/nginx/sites-enabled
VOLUME /etc/nginx/certificates

# Copie des fichiers de configuration
COPY confs/nginx.conf /etc/nginx/
COPY confs/proxy.conf /etc/nginx/conf.d/

# Exposition du port
EXPOSE 80 443
CMD ["nginx", "-g", "daemon off;"]
