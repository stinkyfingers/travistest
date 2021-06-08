#!/bin/sh

TRAVIS_COMMIT=$1
echo "a script: $TRAVIS_COMMIT"
sudo apt-get update -yq && apt-get install bats -y
