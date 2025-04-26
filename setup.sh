#!/bin/bash

install_docker(){
  echo "Installing docker..."
  sudo apt-get update
  sudo apt-get install ca-certificates curl
  sudo install -m 0755 -d /etc/apt/keyrings
  sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
  sudo chmod a+r /etc/apt/keyrings/docker.asc
  echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
    $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
    sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
  sudo apt-get update
  sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
  echo "Installed docker."
}

install_k3S(){
  echo "Installing k3s..."
  curl -sfL https://get.k3s.io | sh -
  mkdir -p ~/.kube
  sudo k3s kubectl config view --raw | tee ~/.kube/config
  chmod 600 ~/.kube/config
  kubectl get nodes
  echo "Installed k3s."
}

install_kubectl(){
  echo "Installing kubectl..."
  curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
  curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"
  echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check
  status="$(sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl)"
  if [[ $status == "kubectl: OK" ]];
    then
      echo "$status"
      kubectl version --client
    else
      echo "Kubectl had an error while installing. "
      echo "$status"
  fi
  echo "Installed kubectl."
}

create_mc_namespace(){
  echo "Creating minecraft namespace in cluster..."
  kubectl create namespace minecraft
  kubectl config set-context minecraft --namespace=minecraft --user=default --cluster=default
  kubectl config use-context minecraft
  echo "Created minecraft namespace in cluster."
}

install_helm_and_charts(){
  echo "Installing Helm..."
  curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3
  bash get_helm.sh
  helm repo add minecraft-server-charts https://itzg.github.io/minecraft-server-charts/
  echo "Installed Helm."
}

main(){
  install_docker
  install_k3S
  install_kubectl
  install_helm_and_charts
  create_mc_namespace
}

main