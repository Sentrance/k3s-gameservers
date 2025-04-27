# Purpose

We need an nginx server to allow grafana to be accessible outside the node.

I prefer using nginx instead of built-in k3s solution (traefik) as it is better documented and 
I'll be able to reuse my knowledge more easily.


## First step: disable traefik

Update the `ExecStart` in _/etc/systemd/system/k3s.service_ with:

```
ExecStart=/usr/local/bin/k3s \
server \
--no-deploy traefik
```

Then restart k3s `sudo systemctl restart k3s`.

## Install ingress-nginx

```
helm upgrade --install ingress-nginx ingress-nginx \
--repo https://kubernetes.github.io/ingress-nginx \
--namespace ingress-nginx --create-namespace
```

verify that it works:
```
kubectl wait --namespace ingress-nginx \
--for=condition=ready pod \
--selector=app.kubernetes.io/component=controller \
--timeout=120s
```

## Create an insecure ingress for grafana

`kubectl apply -f grafana-ingress.yaml --namespace monitoring`