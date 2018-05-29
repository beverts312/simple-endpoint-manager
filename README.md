# Simple Endpoint Manager
Leverage Consul and Nginx to easily router traffic

## How to use it
Certs - Put certs `/security` named `public.pem` and `private.pem`.  
Routes - Create routes in consul KV using the pattern `domain/subdomain` : `target`.