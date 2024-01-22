#shellcheck shell=bash

It 'is simple'
  When call echo 'ok'
  The output should eq 'ok'
End