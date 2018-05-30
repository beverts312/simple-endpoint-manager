# Simple Endpoint Manager
Leverage Consul and Nginx to easily router traffic

## How to use it
Configure DNS for all the domains you want to the place where the nginx container is running

Tip: Use wildcard subdomains if you plan on using a bunch

#### Certs  
Put certs `/security` named `public.pem` and `private.pem`.
All traffic on `80` will be redirected to `443`.

You can get free certificates from [ZeroSSL](https://zerossl.com/).

#### Routes  
Create routes in consul with the source being the key and target being the value.