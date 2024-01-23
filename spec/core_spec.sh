#shellcheck shell=bash

Describe 'Evaluating source_lib mock: '
  Include lib/core.sh
  BeforeAll 'setup_working_directory'

  # Use current path as default.
  # When running as a Github action, find the working directory.
  work_dir="${GITHUB_WORKSPACE:-.}"
  setup_working_directory() {
    cd $work_dir
    echo "Working in $work_dir"
  }

  It 'Loads sh libs'
    When call source_lib "$work_dir/spec/support/libtest1"
    The output should eq ''
  End
  
  It 'lib error on missing dir'
    When call source_lib "$work_dir/spec/support/missing"
    The output should eq "Error: The directory $work_dir/spec/support/missing does not exist."
  End

  load_dir_twice() {
    source_lib "$work_dir/spec/support/libtest1"
    source_lib "$work_dir/spec/support/libtest1"
  }  

  It 'Loads sh libs only once'
    When call load_dir_twice
    The output should eq ''
  End

End