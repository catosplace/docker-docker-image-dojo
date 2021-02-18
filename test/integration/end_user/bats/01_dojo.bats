#!/usr/bin/env bats

load '/opt/bats-support/load.bash'
load '/opt/bats-assert/load.bash'

@test "/usr/bin/entrypoint.sh succeds" {
    run /bin/bash -c "dojo -c Dojofile.to_be_tested \"pwd && whoami\""
    # this is printed on test failure
    echo "output: $output"
    assert_output --partial "dojo init finished"
    assert_output --partial "/dojo/work"
    assert_output --partial "dojo"
    refute_output --partial "root"
    assert_success
}

@test "dojo is installed" {
  run /bin/bash -c "dojo -c Dojofile.to_be_tested \"dojo --version\""
  # this is printed on test failure
  echo "output: $output"
  assert_line --partial "Dojo version ${DOJO_VERSION}"
  assert_success
}