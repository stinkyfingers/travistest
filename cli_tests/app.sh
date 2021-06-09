#!/usr/bin/env bats

framework="myframework"
appImage="docker.io/shipasoftware/bulletinboard:1.0"
# platform="go"

@test "help" {
  result="$(ketch help)"
  [[ $result =~ "For details see https://theketch.io" ]]
  [[ $result =~ "Available Commands" ]]
  [[ $result =~ "Flags" ]]
}

@test "framework create" {
  result="$(ketch framework add $framework --ingress-service-endpoint "$(kubectl get svc traefik -o jsonpath='{.status.loadBalancer.ingress[0].ip}')" --ingress-type traefik)"
  [[ $result =~ "Successfully added!" ]]
}

@test "framework list" {
  result="$(ketch framework list)"
  echo $result
  [[ $result =~ "myframework" ]] # TODO check w/ regex
}

# @test "platform add" {
#   result="$(ketch platform add $platform)"
#   [[ $result =~ "Added platform \"$platform\"" ]]
# }
#
# @test "platform list" {
#   result="$(ketch platform list)"
#   [[ $result =~ "NAME    IMAGE                    DESCRIPTION" ]] # TODO check w/ regex
#   [[ $result =~ "go      shipasoftware/go:v1.2" ]]
# }

@test "app deploy" {
  result="$(ketch app deploy bulletinboard --framework $framework -i $appImage)"
  # [[ $result =~ "Success" ]]
}

@test "app list" {
  result="$(ketch app list)"
  [[ $result =~ "bulletinboard" ]] # TODO regex
}

@test "app remove" {
  result="$(ketch app remove bulletinboard)"
  [[ $result =~ "Successfully removed!" ]]
}

# @test "platform delete" {
#   platform="go"
#   result="$(ketch platform delete $platform)"
#   [[ $result =~ "Successfully removed platform \"go\"" ]]
# }

@test "framework remove" {
  result="$(echo ketch-$framework | ketch framework remove $framework)"
  [[ $result =~ "Framework successfully removed!" ]]
}
