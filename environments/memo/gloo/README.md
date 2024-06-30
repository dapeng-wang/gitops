# Gloo Gateway

## Installation
* Install CRD
```
kubectl apply -f https://github.com/kubernetes-sigs/gateway-api/releases/download/v1.0.0/standard-install.yaml
``` 

* Install Helm Chart
```
helm repo add gloo https://storage.googleapis.com/solo-public-helm
helm repo update


helm install -n gloo gloo-gateway gloo/gloo \
--create-namespace \
--version 1.17.0-rc9 \
--set kubeGateway.enabled=true \
--set gloo.disableLeaderElection=true \
--set discovery.enabled=false
```

* 2 pods running, one control plan -- `gloo`, one proxy -- `gateway-proxy`
* Verify that gatewayClass is installed
```
kubectl get gatewayclass gloo-gateway
```