````
cd kong-ingress
helm upgrade --install kong .  -f values.yaml --namespace kong --create-namespace
curl -i http://kong.me
````