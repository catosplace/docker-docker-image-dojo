#!/usr/bin/env bats

load '/opt/bats-support/load.bash'
load '/opt/bats-assert/load.bash'

@test "hadolint" {
  run /bin/bash -c "dojo -c Dojofile \"hadolint ./image/Dockerfile\""
  echo "output: $output"
  assert_equal "$status" 1
}