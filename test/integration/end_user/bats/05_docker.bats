#!/usr/bin/env bats

load '/opt/bats-support/load.bash'
load '/opt/bats-assert/load.bash'

@test "docker is installed" {
  run /bin/bash -c "dojo -c Dojofile.to_be_tested \"docker --version\""
  # this is printed on test failure
  echo "output: $output"
  assert_line --partial "Docker version ${DOCKER_VERSION}"
  assert_success
}