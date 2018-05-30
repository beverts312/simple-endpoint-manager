# Simple Endpoint Manager

![docker build](https://img.shields.io/docker/build/beverts312/simple-endpoint-manager.svg)
[![](https://images.microbadger.com/badges/image/beverts312/simple-endpoint-manager.svg)](https://microbadger.com/images/beverts312/simple-endpoint-manager)
[![](https://images.microbadger.com/badges/version/beverts312/simple-endpoint-manager.svg)](https://microbadger.com/images/beverts312/simple-endpoint-manager)  

Leverage Consul and Nginx to easily router traffic

## How to use it
Configure DNS for all the domains you want to the place where the nginx container is running

Tip: Use wildcard subdomains if you plan on using a bunch

#### Consul
Connection to consul is configured with environmental variables:  
* `CONSUL_HOST`: where to find consul
* `CONSUL_ACL`: ACL to use to connect to consul

#### Certs  
Put certs `/security` named `public.pem` and `private.pem`.
All traffic on `80` will be redirected to `443`.

You can get free certificates from [ZeroSSL](https://zerossl.com/).

#### Routes  
Create routes in consul with the source being the key and target being the value.