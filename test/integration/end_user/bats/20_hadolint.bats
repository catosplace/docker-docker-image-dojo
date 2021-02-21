#!/usr/bin/env bats

load '/opt/bats-support/load.bash'
load '/opt/bats-assert/load.bash'

@test "hadloint is installed" {
  run /bin/bash -c "dojo -c Dojofile.to_be_tested \"hadolint --version\""
  # this is printed on test failure
  echo "output: $output"
  assert_line --partial "Haskell Dockerfile Linter"
  assert_success
}

@test "hadolint fails when Dockerfile fails linting" {
  run /bin/bash -c "dojo -c Dojofile.to_be_tested \"hadolint ./test/integration/test_dojo_work/image/Dockerfile\""
  # this is printed on test failure
  echo "output: $output"
  assert_line --partial "DL3018 warning"
  assert_failure
}

@test "hadolint passes when Dockerfile issue ignored" {
  run /bin/bash -c "dojo -c Dojofile.to_be_tested \" hadolint --ignore DL3018 ./test/integration/test_dojo_work/image/Dockerfile\""
  echo "$output"
  assert_success
} 