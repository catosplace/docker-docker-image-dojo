#!/usr/bin/env bats

load '/opt/bats-support/load.bash'
load '/opt/bats-assert/load.bash'

@test "/usr/bin/entrypoint.sh returns 0" {
    run /bin/bash -c "dojo \"pwd && whoami\""
    # this is printed on test failure
    echo "output: $output"
    assert_output --partial "dojo init finished"
    assert_output --partial "/dojo/work"
    assert_output --partial "dojo"
    refute_output --partial "root"
    assert_equal "$status" 0
}