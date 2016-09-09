FROM debian:jessie
MAINTAINER Louis Fradin <louis.fradin@gmail.com>

# Updating system
RUN apt-get update && apt-get upgrade -y

# Installation of nginx
RUN apt-get install nginx -y

# Add custom 404
RUN sed -i '/^\troot/aerror\_page 404 \= \/404\.html;' /etc/nginx/sites-enabled/default

VOLUME /var/www/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
