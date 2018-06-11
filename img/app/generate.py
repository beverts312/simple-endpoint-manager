#!/usr/bin/python 
import json, sys, re

jsonFile = sys.argv[1]
with file(jsonFile) as f: jsonText = f.read()

domains = json.loads(re.sub(",(\s*)}", r"\1}", jsonText))
oneLocationDomains = filter(lambda a: "/" not in a[0], domains.iteritems())
multiLocationDomains = filter(lambda a: "/" in a[0], domains.iteritems())

for sourceUrl, targetUrl in oneLocationDomains:
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

mappedDomains = {}
for sourceUrl, targetUrl in multiLocationDomains:
  domain = sourceUrl.split('/')[0]
  path = sourceUrl.replace(domain, '')
  if domain not in mappedDomains: mappedDomains[domain] = {}
  mappedDomains[domain][path] = targetUrl

for domain in mappedDomains:
  print """
   server {
      listen 443 ssl;
      server_name %s; 
  """ % domain
  for path in mappedDomains[domain]:
    print """
     location %s {
        proxy_set_header      X-Real-IP $remote_addr;
        proxy_ssl_server_name on;
        proxy_ssl_name        $proxy_host;
        proxy_pass            %s;
      }
  """ % (path, mappedDomains[domain][path])
  print "}"