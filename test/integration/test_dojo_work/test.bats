#!/usr/bin/env bats

load '/opt/bats-support/load.bash'
load '/opt/bats-assert/load.bash'

setup_file() {
  sudo apk --no-cache add make parallel
  make build
}

@test "hadolint" {
  run dojo -c Dojofile "hadolint ./image/Dockerfile"
  echo "$output"
  assert_failure
}

@test "hadolint2" {
  run dojo -c Dojofile "hadolint --ignore DL3018 ./image/Dockerfile"
  echo "$output"
  assert_success
}

@test "bash" {
  run bash --version
  assert_success
  assert_line --partial "GNU bash, version"
}