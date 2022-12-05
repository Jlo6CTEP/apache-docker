FROM debian:buster-slim

RUN apt-get update && \
DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends apache2 && \
	apt-get install -y iputils-ping certbot python3-certbot-apache libapache2-mod-php php7.3-sqlite && \
	rm -rf /var/lib/apt/lists/*

COPY ./apache2.conf /etc/apache2/apache2.conf
COPY ./vhosts  /vhosts
COPY startup.sh .

CMD /startup.sh



