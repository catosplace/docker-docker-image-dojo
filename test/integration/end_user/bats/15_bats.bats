#!/usr/bin/env bats

load '/opt/bats-support/load.bash'
load '/opt/bats-assert/load.bash'

@test "bats is installed" {
  run /bin/bash -c "dojo -c Dojofile.to_be_tested \"bats --version\""
  # this is printed on test failure
  echo "output: $output"
  assert_line --partial "Bats ${BATS_VERSION}"
  assert_success
}