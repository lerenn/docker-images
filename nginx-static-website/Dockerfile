FROM debian:stretch
MAINTAINER Louis Fradin <louis.fradin@gmail.com>

# Updating system
RUN apt-get update && apt-get upgrade -y

# Installation of nginx and curl
RUN apt-get install nginx curl -y

# Add custom 404
RUN sed -i '/^\troot/aerror\_page 404 \= \/404\.html;' /etc/nginx/sites-enabled/default

VOLUME /var/www/html
EXPOSE 80

# Command and healthcheck
CMD ["nginx", "-g", "daemon off;"]
HEALTHCHECK CMD curl --fail http://localhost || exit 1
