# gitops

Dapeng Gitops


## INGRESS Controller

```
helm upgrade --install ingress-nginx ingress-nginx --repo https://kubernetes.github.io/ingress-nginx --namespace ingress-nginx --create-namespace
```


## ArgoCD

### Install ArgoCD using Helm Chart

```
cd argocd
helm upgrade --install argocd charts/argo-cd/  -f values.yaml --create-namespace --namespace argocd
```

### Fetch Admin password

```
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
```


## Harbor

### Install Harbor using Helm Chart

```
helm repo add harbor https://helm.goharbor.io 
helm repo update
helm fetch harbor/harbor --untar -d charts/harbor
helm upgrade --install harbor charts/harbor/  -f values.yaml --create-namespace --namespace harbor
```

### Deploy Ingress

```
kubectl apply -f ingress.yaml
```

### Login as admin

```
https://harbor.b4a63c3.kyma.ondemand.com/
admin/SapForMe888%
```

## Push Cahrts

```
helm registry login -u admin harbor.b4a63c3.kyma.ondemand.com
helm package app-of-apps
helm push app-of-apps-0.0.1.tgz oci://harbor.b4a63c3.kyma.ondemand.com/forme
```
