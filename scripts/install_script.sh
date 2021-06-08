#!/bin/sh

TRAVIS_COMMIT=$1
echo "a script: $TRAVIS_COMMIT"

# Minikube
- curl -Lo kubectl https://storage.googleapis.com/kubernetes-release/release/v1.20.1/bin/linux/amd64/kubectl && chmod +x kubectl && sudo mv kubectl /usr/local/bin/

# BATS
sudo apt-get update -yq && sudo apt-get install bats -y
