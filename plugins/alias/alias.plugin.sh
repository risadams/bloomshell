#!/usr/bin/env bash

# ------------------------------------------------------------------------------
# SCRIPT NAME: alias.sh
# DESCRIPTION: alias definitions
# VERSION: 1.0
# AUTHOR: Ris Adams
# CREATED DATE: 2024-01-24
# LAST UPDATED: 2024-01-25
# ------------------------------------------------------------------------------
# PROJECT INFO:
# Project Name: Bloomshell
# Repository: https://github.com/risadams/bloomshell
# ------------------------------------------------------------------------------
# ADDITIONAL NOTES:
# - The core library should be included first before loading any additional scripts
# - BLOOM_ROOT and BLOOMSH_VERSION need to be set, if renamed they should be renamed in all files.
# ------------------------------------------------------------------------------

if [ -n "$_BLOOMSH_PLUGIN_ALIAS_SOURCED" ]; then
  return 0
fi
_BLOOMSH_PLUGIN_ALIAS_SOURCED=1

shopt -s expand_aliases

function alias_value() {
  : <<'DOC'
NAME
    alias_value - Displays the true value of an alias.
SYNOPSIS
    alias_value [ALIAS]
DESCRIPTION
    This function takes a shell alias as a function and displays its true value
ARGUMENTS
   ALIAS
      The name of an alias to resolve.
OUTPUT
    If the passed argument exists as an alias, it
EXAMPLES
   alias_value "duh"
EXIT_STATUS
    0   The alias was found, it's value printed to STDOUT
    1   No alias by that name was found.
NOTES
    This function (and any function starting with '__') should not be directly executed.
DOC
  # Check if an argument is provided
  if [ $# -eq 0 ]; then
    echo "Usage: display_alias_value <alias_name>"
    return 1
  fi

  # Check if the provided argument is a defined alias
  if alias "$1" &>/dev/null; then
    # Extract and display the alias value
    alias "$1" | sed "s/alias $1='//; s/'$//"
  else
    echo "Alias '$1' not found."
    return 1
  fi
}

## alias list

alias duh='du -h' # human readable disk usage
