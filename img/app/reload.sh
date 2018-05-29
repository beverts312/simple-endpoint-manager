#!/bin/sh

/app/generate.py /app/vars.json > /app/routes.conf
nginx -c /app/nginx.conf -s reload 