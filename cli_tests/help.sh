#!/usr/bin/env bats

@test "ketch help" {
  result="$(ketch help)"
  [[ $result == "*For details see https://theketch.io*" ]]
}
