#shellcheck shell=bash

Describe 'Evaluating helper functions: '
    Include lib/string_helpers.sh

    Describe 'The trim_string function'
        It 'trims leading and trailing white-space from string'
            When call trim_string "    Hello,  World    "
            The output should eq 'Hello,  World'
        End

        It 'trims leading and trailing white-space from string'
            name="   John Doe  "
            When call trim_string "$name"
            The output should eq 'John Doe'
        End
    End

End
