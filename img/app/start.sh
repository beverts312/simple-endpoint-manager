#!/bin/sh
export CONSUL_HOST=$CONSUL_HOST

if [ -z $CONSUL_HOST ]; then
  echo "CONSUL_HOST required";
  exit 1;
else
  echo "Consul Socket: $CONSUL_HOST"
fi

if [ -z $WAIT_TIME ]; then
  WAIT_TIME=10s
fi

echo "server {}" > /app/routes.conf

exec nginx -c /app/nginx.conf &
consul-template \
  -consul-addr $CONSUL_HOST \
  -template "/app/vars.ctmpl:/app/vars.json:/app/reload.sh" \
  -wait $WAIT_TIME
