helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
helm upgrade --install kube-prometheus-stack prometheus-community/kube-prometheus-stack -f prometheus-values.yaml --create-namespace --namespace monitoring
kubectl apply -f volume.yaml --namespace monitoring

kubectl --namespace monitoring get pods -l "release=kube-prometheus-stack"