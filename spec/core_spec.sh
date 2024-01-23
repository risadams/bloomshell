#shellcheck shell=bash

Describe 'Evaluating source_lib mock: '
  Include lib/core.sh
  BeforeEach 'setup_working_directory'
  AfterEach 'restore_directory'

  # Use current path as default.
  # When running as a Github action, find the working directory.
  work_dir="${GITHUB_WORKSPACE:-.}"

  setup_working_directory() {
    original_dir=$(pwd)
    cd $work_dir
  }

  restore_directory() {
    cd "$original_dir"
  }  

  It 'Loads sh libs'
    When call source_lib "./support/libtest1"
    The output should eq ''
  End
  
  It 'lib error on missing dir'
    When call source_lib "./support/missing"
    The output should eq "Error: The directory ./support/missing does not exist."
  End

  load_dir_twice() {
    source_lib "./support/libtest1"
    source_lib "./support/libtest1"
  }  

  It 'Loads sh libs only once'
    When call load_dir_twice
    The output should eq ''
  End

End