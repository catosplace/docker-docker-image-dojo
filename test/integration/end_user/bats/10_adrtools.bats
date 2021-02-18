#!/usr/bin/env bats

load '/opt/bats-support/load.bash'
load '/opt/bats-assert/load.bash'

@test "adr tools is installed" {
    # Why does this test only work when we use the full path here!!!
    run /bin/bash --login -x -c "dojo -c Dojofile.to_be_tested \"/usr/local/bin/adr-tools-${ADR_TOOLS_VERSION}/src/adr list\""
    echo "output: $output"
    #assert_line --partial "usage: adr init [DIRECTORY]"
    assert_success
}