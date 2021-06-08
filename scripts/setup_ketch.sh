#!/bin/sh

TRAVIS_COMMIT=$1

# ketch
export KUBECONFIG="$(kind get kubeconfig-path)"
kubectl cluster-info
# make install
# make ketch
sudo curl -s https://raw.githubusercontent.com/shipa-corp/ketch/main/install.sh | sudo bash # TODO
ketch -v

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
kubectl wait --for=condition=Ready=true pod -n istio-system --all
kubectl get pods -A

# deploy
# make deploy IMG=shipasoftware/ketch:$TRAVIS_COMMIT
kubectl apply -f https://github.com/shipa-corp/ketch/releases/download/v0.2.1/ketch-controller.yaml # TODO
