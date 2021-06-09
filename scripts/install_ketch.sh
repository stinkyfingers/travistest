#!/bin/sh

# start cluster
sudo minikube start --profile=minikube --vm-driver=none --kubernetes-version=v1.20.1

# ketch
kubectl cluster-info
# make install
# make ketch
sudo curl -s https://raw.githubusercontent.com/shipa-corp/ketch/main/install.sh | sudo bash # TODO
ketch -v

# helm
curl https://baltocdn.com/helm/signing.asc | sudo apt-key add -
sudo apt-get install apt-transport-https --yes
echo "deb https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list
sudo apt-get update
sudo apt-get install helm

# cert-manager
kubectl apply -f https://github.com/jetstack/cert-manager/releases/download/v1.3.1/cert-manager.yaml

# istio
# curl -Ls https://istio.io/downloadIstio | ISTIO_VERSION=1.9.0 sh -
# export PATH=$PWD/istio-1.9.0/bin:$PATH
# istioctl install --set profile=demo -y

# traefik
helm repo add traefik https://helm.traefik.io/traefik
helm repo update
helm install traefik traefik/traefik

# wait for containers
kubectl wait --for=condition=Ready=true pod -n cert-manager --all
# kubectl wait --for=condition=Ready=true pod -n istio-system --all # istio only
kubectl get pods -A

# deploy
# make deploy IMG=shipasoftware/ketch:$TRAVIS_COMMIT
kubectl apply -f https://github.com/shipa-corp/ketch/releases/download/v0.2.1/ketch-controller.yaml # TODO
