#!/bin/sh

# Download and install kubectl (optional)
curl -Lo kubectl https://storage.googleapis.com/kubernetes-release/release/v1.12.0/bin/linux/amd64/kubectl && chmod +x kubectl && sudo mv kubectl /usr/local/bin/
# Download and install kind using Go toolchain
# go get sigs.k8s.io/kind
# Download and install kind using cURL
curl -Lo kind https://github.com/kubernetes-sigs/kind/releases/download/0.0.1/kind-linux-amd64 && chmod +x kind && sudo mv kind /usr/local/bin/
# Create a new Kubernetes cluster using kind
kind create cluster
# Set KUBECONFIG environment variable
export KUBECONFIG="$(kind get kubeconfig-path)"
