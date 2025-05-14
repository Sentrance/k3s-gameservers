# k3s-minecraft

Very easy setup of minecraft servers managed in a lightweight Kubernetes cluster.

Thanks to https://github.com/gilesknap/k3s-minecraft as a project reference.

## Dependencies

### Through setup script

There is an installer script that installs everything for convenience.

The script is [setup.sh](setup.sh). You probably need to chmod 755 it.

### Docker

Docker is needed, obviously.

[Installation link](https://docs.docker.com/engine/install/ubuntu/).

### K3S

K3s is a lightweight kubernetes distribution, easy to install and great for homelab.

[Installation link](https://docs.k3s.io/quick-start).

### Kubectl

Kubectl is the CLI for kubernetes, allowing us to communicate with the cluster.

[Installation link](https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/).

### Helm

Helm helps to manage Kubernetes apps, here through re-using an existing minecraft server chart.

[Installation link](https://helm.sh/docs/intro/install/).

### Itzg minecraft server chart

Contains the helm chart baseline. 

[Repository link](https://github.com/itzg/minecraft-server-charts).

## Usage

Create a new ***yaml*** file based on ***kubernetes/external/minecraft/minecraft-helm-base.yaml***.
Provide it with the values you need.

Use:
```
helm upgrade --install [SERVER_NAME] -f [SERVER_NAME_PATH] --set minecraftServer.eula=true,rcon.password=[RCON_PASSWORD] minecraft-server-charts/minecraft
```

### Delete server deployment
```
helm delete [SERVER_NAME]
```

# Kube-prometheus-stack

A collection of prometheus & grafana in order to easily visualize data like ressource usage or uptime.

## Install

Go to _kubernetes/external/kube-prometheus-stack_ and use `./setup.sh`.

### Content

- Prometheus
- Grafana
- PV & PVC for consistent data
- Service to expose grafana URL

# Traefik Ingress controller / Service LoadBalancer

We use traefik, that is provided by k3s, to manage networking.

Traefik is a modern HTTP reverse proxy and load balancer made to deploy microservices with ease.
It simplifies networking complexity while designing, deploying, and running applications.

By default, K3s provides a load balancer known as ServiceLB (formerly Klipper LoadBalancer) that uses available host ports.
The ServiceLB controller watches Kubernetes Services with the `spec.type` field set to `LoadBalancer`.

In this repo services are often added under `kubernetes/internal/traefik/service.yaml` and then we define the ingress 
under its respective directory.