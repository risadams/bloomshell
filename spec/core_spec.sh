#shellcheck shell=bash

Describe 'Evaluating source_lib mock: '
  Include lib/core.sh

  It 'Loads sh libs'
    When call source_lib "spec/support/libtest1"
    The output should eq ''
  End
  
  It 'lib error on missing dir'
    When call source_lib "spec/support/missing"
    The output should eq 'Error: The directory spec/support/missing does not exist.'
  End

  load_dir_twice() {
    source_lib "spec/support/libtest1"
    source_lib "spec/support/libtest1"
  }  

  It 'Loads sh libs only once'
    When call load_dir_twice
    The output should eq ''
  End

End