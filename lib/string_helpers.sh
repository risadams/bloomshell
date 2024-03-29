#!/bin/env bash

# ------------------------------------------------------------------------------
# SCRIPT NAME: string_helpers.sh
# DESCRIPTION: Generic string helpers and utilities.
# VERSION: 1.0
# AUTHOR: Ris Adams
# CREATED DATE: 2024-01-22
# LAST UPDATED: 2024-01-22
# ------------------------------------------------------------------------------
# PROJECT INFO:
# Project Name: Bloomshell
# Repository: https://github.com/risadams/bloomshell
# ------------------------------------------------------------------------------

if [ -n "$_BLOOMSH_STRING_HELPERS_SOURCED" ]; then
  return 0
fi

_BLOOMSH_STRING_HELPERS_SOURCED=1

trim_string() {
  : <<'DOC'
NAME
       trim_string - Trims leading and trailing whitespace from a string.
SYNOPSIS
       trim_string STRING
DESCRIPTION
       trim_string is a bash function that removes leading and trailing whitespace from the provided string.
       The function operates by using parameter expansion and pattern matching features of bash. It does not modify the original string but prints the trimmed version to standard output.
       This method is POSIX compliant, ensuring compatibility across various Unix-like systems.
PARAMETERS
       STRING
           The string input from which leading and trailing whitespace will be removed.
EXAMPLES
       To trim a string:
              input="   Hello, World!   "
              trimmed=$(trim_string "$input")
              echo "Trimmed string: '$trimmed'"
       This will output:
              Trimmed string: 'Hello, World!'
NOTES
       The function uses the special variable '_' (underscore), which holds the last argument of the previous command executed. This behavior is utilized to store and manipulate the trimmed string.
       The function is written to be POSIX compliant, ensuring it works across different shells that adhere to the POSIX standard.
       It utilizes the ':' (colon) command, a shell built-in that effectively performs no action, but is used for the side-effect of its parameter expansion capabilities.  
DOC
  local var="$1"
  var="${var#"${var%%[![:space:]]*}"}" # Remove leading whitespace characters
  var="${var%"${var##*[![:space:]]}"}" # Remove trailing whitespace characters
  printf '%s\n' "$var"
}

split() {
  : <<'DOC'
NAME
    split - Splits a string into parts based on a specified delimiter.
SYNOPSIS
    split STRING DELIMITER
DESCRIPTION
    split is a function that takes two arguments: a string and a delimiter.
    It splits the string into parts wherever the delimiter occurs and
    prints each part on a new line. This function temporarily changes the
    Internal Field Separator (IFS) to the specified delimiter for splitting
    the string and disables globbing to ensure safe word-splitting.
ARGUMENTS
    STRING
        The string to be split.
    DELIMITER
        The delimiter character on which the string will be split.
        If the delimiter is a space, it should be passed as ' '.
OUTPUT
    Prints each split part of the string on a new line.
EXAMPLES
    split "one,two,three" ","
        Splits the string "one,two,three" at each comma and prints:
        one
        two
        three
    split "apple orange banana" " "
        Splits the string "apple orange banana" at each space and prints:
        apple
        orange
        banana
NOTES
    This function temporarily disables globbing and modifies the IFS
    only within its scope. The original IFS value is restored before the
    function exits.
DOC
  set -f             # Disable globbing. This ensures that the word-splitting is safe.
  local old_ifs=$IFS # Store the current value of 'IFS' so we can restore it later.
  IFS=$2             # Change the field separator to what we're splitting on.

  # Create an argument list splitting at each occurance of '$2'.
  # shellcheck disable=2086
  set -- $1
  printf '%s\n' "$@" # Print each list value on its own line.
  IFS=$old_ifs       # Restore the value of 'IFS'.
  set +f             # Re-enable globbing.
}
