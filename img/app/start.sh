#!/bin/sh
export CONSUL_HOST=$CONSUL_HOST
export CONSUL_ACL=$CONSUL_ACL

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

if [ -z $CONSUL_ACL ]; then
  exec nginx -c /app/nginx.conf &
  consul-template \
    -consul-addr $CONSUL_HOST \
    -template "/app/vars.ctmpl:/app/vars.json:/app/reload.sh" \
    -wait $WAIT_TIME
else
  exec nginx -c /app/nginx.conf &
  consul-template \
    -consul-addr $CONSUL_HOST \
    -consul-token $CONSUL_ACL \
    -template "/app/vars.ctmpl:/app/vars.json:/app/reload.sh" \
    -wait $WAIT_TIME
fi