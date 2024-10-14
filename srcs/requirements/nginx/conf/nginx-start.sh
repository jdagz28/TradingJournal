#!/bin/bash

UID_VAR="test"

# Generate the SSL certificate using the global UID variable
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -out /etc/nginx/ssl/tradingjournal.crt -keyout /etc/nginx/ssl/tradingjournal.key -subj "/C=MO/ST=KH/L=KH/O=MyOrganization/OU=MyDepartment/CN=tradingjournal.app/UID=$UID_VAR"

# Keep Nginx running in the foreground
nginx -g 'daemon off;'