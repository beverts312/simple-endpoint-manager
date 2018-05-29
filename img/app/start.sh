#!/bin/sh
export CONSUL_SOCKET=$CONSUL_SOCKET

if [ -z $CONSUL_SOCKET ]; then
  echo "CONSUL_SOCKET required";
  exit 1;
else
  echo "Consul Socket: $CONSUL_SOCKET"
fi

if [ -z $WAIT_TIME ]; then
  WAIT_TIME=10s
fi

echo "server {}" > /app/routes.conf

exec nginx -c /app/nginx.conf &
consul-template \
  -consul $CONSUL_SOCKET \
  -template "/app/vars.ctmpl:/app/vars.json:/app/reload.sh" \
  -wait $WAIT_TIME
