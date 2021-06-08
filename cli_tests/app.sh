#!/usr/bin/env bats

@test "ketch app" {
  result="$(ketch help)"
  [[ $result =~ "For details see https://theketch.io" ]]
  [[ $result =~ "Available Commands" ]]
  [[ $result =~ "Flags" ]]
}
