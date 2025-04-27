# k8s-minecraft

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

# Ingress

You might not want to expose grafana directly, you almost might want a domain name for the minecraft servers. In such 
case what you need is an Ingress.

Here are some cool ressources to check:

- [k3s networking services](https://docs.k3s.io/networking/networking-services)
- [I don't want k3s networking and prefer a traditional nginx](https://github.com/gilesknap/k3s-minecraft/blob/main/useful/deployed/ingress-nginx/README.md)