# Kong Ingress 

* helm repo add kong https://charts.konghq.com
* helm repo update
* helm install kong kong/ingress -n kong --create-namespace

```
➜  argocd git:(main) ✗ k get all         
NAME                                  READY   STATUS    RESTARTS   AGE
pod/kong-controller-7b7ff45bd-4r8f6   0/1     Running   0          19s
pod/kong-gateway-786f574665-j4tst     0/1     Running   0          19s

NAME                                         TYPE           CLUSTER-IP      EXTERNAL-IP   PORT(S)                         AGE
service/kong-controller-validation-webhook   ClusterIP      10.101.96.238   <none>        443/TCP                         19s
service/kong-gateway-admin                   ClusterIP      None            <none>        8444/TCP                        19s
service/kong-gateway-manager                 NodePort       10.96.169.74    <none>        8002:31785/TCP,8445:32192/TCP   19s
service/kong-gateway-proxy                   LoadBalancer   10.99.162.13    <pending>     80:30690/TCP,443:32283/TCP      19s

NAME                              READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/kong-controller   0/1     1            0           19s
deployment.apps/kong-gateway      0/1     1            0           19s

NAME                                        DESIRED   CURRENT   READY   AGE
replicaset.apps/kong-controller-7b7ff45bd   1         1         0       19s
replicaset.apps/kong-gateway-786f574665     1         1         0       19s
```

* Port-Forward
```
kubectl port-forward deploy/kong-gateway -n kong 30801:8000
Forwarding from 127.0.0.1:30801 -> 8000
Forwarding from [::1]:30801 -> 8000
Handling connection for 30801
```

* Test
```
curl -i http://localhost:30801
HTTP/1.1 404 Not Found
Date: Wed, 26 Jun 2024 15:41:09 GMT
Content-Type: application/json; charset=utf-8
Connection: keep-alive
Content-Length: 103
X-Kong-Response-Latency: 0
Server: kong/3.6.1
X-Kong-Request-Id: 6c3dca327fb6f27d0061e6316c9ddf7b

{
  "message":"no Route matched with those values",
  "request_id":"6c3dca327fb6f27d0061e6316c9ddf7b"
}%
```

* Create a Kong Ingress
```
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  annotations:
    konghq.com/strip-path: ''
  labels:
    app: tiny-api
    argocd.argoproj.io/instance: tiny-api
    type: backend
  name: tiny-api-kong-ingress
  namespace: memo
spec:
  ingressClassName: kong
  rules:
    - host: local.me
      http:
        paths:
          - backend:
              service:
                name: tiny-api-service
                port:
                  number: 6666
            path: /tiny
            pathType: Prefix
  tls:
    - hosts:
        - local.me
```
* Run test
```
curl -v --location 'http://local.me:30801/tiny/hello'
* Host local.me:30801 was resolved.
* IPv6: (none)
* IPv4: 127.0.0.1
*   Trying 127.0.0.1:30801...
* Connected to local.me (127.0.0.1) port 30801
> GET /tiny/hello HTTP/1.1
> Host: local.me:30801
> User-Agent: curl/8.6.0
> Accept: */*
> 
< HTTP/1.1 200 OK
< Content-Type: application/json;charset=UTF-8
< Content-Length: 11
< Connection: keep-alive
< X-Kong-Upstream-Latency: 9
< X-Kong-Proxy-Latency: 0
< Via: kong/3.6.1
< X-Kong-Request-Id: 26dddc4115418d256eb13215eaa42560
< 
* Connection #0 to host local.me left intact
Hello World%                                    
```
