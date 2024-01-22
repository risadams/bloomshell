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

    Describe 'The split function'
        It 'splits a string on a delimiter'
            When call split "apples,oranges,pears,grapes" ","
            The output should eq "apples
oranges
pears
grapes"
        End
       It 'splits a string on a delimiter'
            When call split "1, 2, 3, 4, 5" ", "
            The output should eq '1
2
3
4
5'
        End
    End

End
