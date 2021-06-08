#!/bin/sh

TRAVIS_COMMIT=$1
echo "a script: $TRAVIS_COMMIT"
apt update -yq && apt install bats -y
