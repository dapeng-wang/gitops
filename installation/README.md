# Install ingress-nginx

```
helm upgrade --install ingress-nginx ingress-nginx --repo https://kubernetes.github.io/ingress-nginx --namespace ingress-nginx --create-namespace
```

# Install ArgoCD

```
helm upgrade --install argocd charts/argo-cd/  -f values.yaml --create-namespace --namespace argocd
```

# Fetch initial secret

```
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
```

# ArgoCD login

```
argocd login argocd.me --insecure --username admin --password ex4DjwKusulGtdgY
```

# Argocd Add Repo

```
argocd repo add https://github.com/dapeng-wang/gitops.git --username dapeng-wang --password AAA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AAA --insecure-skip-server-verification --upsert
```