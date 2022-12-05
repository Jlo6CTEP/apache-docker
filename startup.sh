#!/bin/bash
cp /vhosts/no_ssl/* /etc/apache2/sites-available
cp /vhosts/ssl/* /etc/apache2/sites-available
a2enmod proxy_http rewrite headers proxy_wstunnel
rm /etc/apache2/sites-enabled/default-ssl.conf
cd /etc/apache2/sites-available && a2ensite *
a2dissite default-ssl 000-default

for CONF_FILE in $(find /vhosts/ssl/ -type f -and -not -name "*default*" -printf "%f\n")
do
    for DOMAIN in $(grep -Po "(?<=ServerName ).+$" ./$CONF_FILE)
    do
        certbot --apache -d $DOMAIN -m 1budsmoker1@gmail.com --agree-tos --noninteractive --redirect
    done
done

service apache2 start
trap exit TERM
while : 
do 
    certbot renew 
    service apache2 reload
    sleep 12h
done;

