# Gloo

## Install
### Install Gateway API
```
kubectl apply -f https://github.com/kubernetes-sigs/gateway-api/releases/download/v1.0.0/standard-install.yaml
kubectl get gateways
kubectl get gatewayclass 
```

```
helm repo add gloo https://storage.googleapis.com/solo-public-helm
helm repo update
helm search repo gloo
helm install -n gloo-system gloo-gateway gloo/gloo --create-namespace --version 1.17.0 --set kubeGateway.enabled=true --set gloo.disableLeaderElection=true --set discovery.enabled=false --set gatewayProxies.gatewayProxy.disabled=true
kubectl get pods -n gloo-system | grep gloo
kubectl get gatewayclass gloo-gateway
```