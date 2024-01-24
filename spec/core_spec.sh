#shellcheck shell=bash

export BLOOMSH_VERSION="1.0-test-harness"

Describe 'Evaluating source_lib mock: '
  Include lib/core.sh
  AfterRun 'unset_bloomsh_version'

  unset_bloomsh_version() {
    unset BLOOMSH_VERSION
  }

  # Use current path as default.
  # When running as a Github action, find the working directory.
  work_dir="${GITHUB_WORKSPACE:-$(pwd)}"

  It 'Loads sh libs'
    When call source_lib "$work_dir/spec/support/libtest1"
    The output should eq ''
    The status should eq 0
  End
  
  It 'lib error on missing dir'
    When call source_lib "$work_dir/spec/support/missing"
    The output should eq "Error: The directory $work_dir/spec/support/missing does not exist."
    The status should eq 1
  End

  load_dir_twice() {
    source_lib "$work_dir/spec/support/libtest1"
    source_lib "$work_dir/spec/support/libtest1"
  }  

  It 'Loads sh libs only once'
    When call load_dir_twice
    The output should eq ''
  End

  It 'Can test for a valid plugin'
    When call __is_plugin "$work_dir" "alias"
    The status should eq 0
  End

  It 'Can test for a missing plugin'
    When call __is_plugin "$work_dir" "missing"
    The status should eq 1
  End

End