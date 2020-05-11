#!/bin/bash


if [ -z "$URI_SECRETS" ] || [ "$URI_SECRETS" == 'URI_SECRETS' ]
then
      echo "\$URI_SECRETS is not set. You can set with hash generate by this command 'date +%s | sha256sum | base64 | head -c 32 ; echo''"
      exit 1
fi

REMOTE_IP_FROM="remote_addr"

if [ ! -z "$USE_HTTP_X_FORWARDED_FOR" ]
then
    REMOTE_IP_FROM="http_x_forwarded_for"
else
fi

cat /assets/video_server.conf.dist | sed  "s/##URI_SECRETS##/${URI_SECRETS}/g" | sed  "s/##REMOTE_IP_FROM##/${REMOTE_IP_FROM}/g" > /etc/nginx/conf.d/video_server.conf

echo '## ==== Start Nginx ==== ##'
echo 'Able to server file in <host>://videos/* files'

echo ''

nginx -g "daemon off;"