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

# TRIM_STRING(1)              User Commands              TRIM_STRING(1)
#
# NAME
#        trim_string - Trims leading and trailing whitespace from a string.
#
# SYNOPSIS
#        trim_string STRING
#
# DESCRIPTION
#        trim_string is a bash function that removes leading and trailing whitespace from the provided string.
#        The function operates by using parameter expansion and pattern matching features of bash. It does not modify the original string but prints the trimmed version to standard output.
#        This method is POSIX compliant, ensuring compatibility across various Unix-like systems.
#
# PARAMETERS
#        STRING
#            The string input from which leading and trailing whitespace will be removed.
#
# EXAMPLES
#        To trim a string:
#               input="   Hello, World!   "
#               trimmed=$(trim_string "$input")
#               echo "Trimmed string: '$trimmed'"
#
#        This will output:
#               Trimmed string: 'Hello, World!'
#
# NOTES
#        The function uses the special variable '_' (underscore), which holds the last argument of the previous command executed. This behavior is utilized to store and manipulate the trimmed string.
#        The function is written to be POSIX compliant, ensuring it works across different shells that adhere to the POSIX standard.
#        It utilizes the ':' (colon) command, a shell built-in that effectively performs no action, but is used for the side-effect of its parameter expansion capabilities.
#
# AUTHOR
#        Written by Ris Adams.
#
trim_string() {
  : "${1#"${1%%[![:space:]]*}"}"
  : "${_%"${_##*[![:space:]]}"}"
  printf '%s\n' "$_"
}
