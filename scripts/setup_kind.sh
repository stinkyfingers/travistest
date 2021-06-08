#!/bin/sh

KUBERNETES_IMAGE=kindest/node:v1.21.1

# Download and install kubectl (optional)
curl -Lo kubectl https://storage.googleapis.com/kubernetes-release/release/v1.12.0/bin/linux/amd64/kubectl && chmod +x kubectl && sudo mv kubectl /usr/local/bin/
# Download and install kind using Go toolchain
# go get sigs.k8s.io/kind
# Download and install kind using cURL
curl -Lo kind https://github.com/kubernetes-sigs/kind/releases/download/0.0.1/kind-linux-amd64 && chmod +x kind && sudo mv kind /usr/local/bin/
# Create a new Kubernetes cluster using kind
kind create cluster --image=$KUBERNETES_IMAGE
# Set KUBECONFIG environment variable
# export KUBECONFIG="$(kind get kubeconfig-path)"


# Kubebuiler & Kustomize
make install-kubebuilder KUBEBUILDER_INSTALL_DIR=/tmp/kubebuilder
make install-kustomize KUSTOMIZE_INSTALL_DIR=/tmp
export PATH=$PATH:/tmp

# Helm
curl https://baltocdn.com/helm/signing.asc | sudo apt-key add -
sudo apt-get install apt-transport-https --yes
echo "deb https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list
sudo apt-get update
sudo apt-get install helm

# BATS
sudo apt-get update -yq && sudo apt-get install bats -y
