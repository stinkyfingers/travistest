#!/bin/sh

set -e

KETCH=$HOME/code/ketch/bin/ketch
INGRESS=$(kubectl get svc traefik -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
FRAMEWORK="myframework"
APP_IMAGE="docker.io/shipasoftware/bulletinboard:1.0"

help () {
  result="$($KETCH help)"
  [[ $result =~ "For details see https://theketch.io" ]]
  [[ $result =~ "Available Commands" ]]
  [[ ! $result =~ "Flags" ]]

  result=$($KETCH framework add FUNK $FRAMEWORK --ingress-service-endpoint $INGRESS --ingress-type traefik)
  [[ $result =~ "Successfully added!" ]]

  # result=$(echo ketch-$FRAMEWORK | $KETCH framework remove $FRAMEWORK)
  # [[ $result =~ "Framework successfully removed!" ]]
}

snafu () {
  echo "HER"
  result=$($KETCH foobar)
  [[ $result =~ "Framework successfully removed!" ]]
  echo $result
}

help
# add_framework
# remove_framework
# snafu
