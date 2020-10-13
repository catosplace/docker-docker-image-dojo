#!/usr/bin/env bats

load '/opt/bats-support/load.bash'
load '/opt/bats-assert/load.bash'

@test "hadolint" {
  run hadolint ./image/Dockerfile
  echo "$output"
  assert_failure
}

@test "hadolint2" {
  run hadolint --ignore DL3018 ./image/Dockerfile
  echo "$output"
  assert_success
}

@test "bash" {
  run bash --version
  assert_success
  assert_line --partial "GNU bash, version"
}