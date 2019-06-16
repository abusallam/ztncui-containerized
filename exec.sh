#!/bin/bash

HTTP_ALL_INTERFACES=${HTTP_ALL_INTERFACES}
HTTP_PORT=${HTTP_PORT:-3000}
if [ ! -z $HTTP_ALL_INTERFACES ]; then
  HTTPS_PORT=${HTTPS_PORT:-3443}
 fi

/usr/sbin/zerotier-one &

while [ ! -f /var/lib/zerotier-one/authtoken.secret ]; do
  sleep 1
done
chmod g+r /var/lib/zerotier-one/authtoken.secret

cd /opt/key-networks/ztncui

echo "HTTP_PORT=$HTTP_PORT" >> /opt/key-networks/ztncui/.env
[ ! -z $HTTPS_PORT ] echo "HTTPS_PORT=$HTTPS_PORT" > /opt/key-networks/ztncui/.env
[ ! -z $HTTP_ALL_INTERFACES ] && echo "HTTP_ALL_INTERFACES=$HTTP_ALL_INTERFACES" >> /opt/key-networks/ztncui/.env

exec sudo -u ztncui /opt/key-networks/ztncui/ztncui
