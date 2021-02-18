#!/usr/bin/env bats

load '/opt/bats-support/load.bash'
load '/opt/bats-assert/load.bash'

@test "shellcheck is installed" {
  run /bin/bash -c "dojo -c Dojofile.to_be_tested \"shellcheck --version\""
  # this is printed on test failure
  echo "output: $output"
  assert_line --partial "ShellCheck - shell script analysis tool"
  assert_success
}