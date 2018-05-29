#!/usr/bin/python 
import json, sys, re

jsonFile = sys.argv[1]
with file(jsonFile) as f: jsonText = f.read()

jsonText = re.sub(",(\s*)}", r"\1}", jsonText)

domains = json.loads(jsonText)

for sourceUrl, targetUrl in domains.iteritems():
  print """
    server {
      listen 443 ssl;
      server_name %s; 

      location / {
        proxy_set_header      X-Real-IP $remote_addr;
        proxy_ssl_server_name on;
        proxy_ssl_name        $proxy_host;
        proxy_pass            %s;
      }
    }
  """ % (sourceUrl, targetUrl)