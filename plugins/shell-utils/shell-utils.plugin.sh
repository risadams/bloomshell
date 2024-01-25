#!/usr/bin/env bash

# ------------------------------------------------------------------------------
# SCRIPT NAME: shell-utils.sh
# DESCRIPTION: various bash functions and utilities
# VERSION: 1.0
# AUTHOR: Ris Adams
# CREATED DATE: 2024-01-25
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

if [ -n "$_BLOOMSH_PLUGIN_SH_UTILS_SOURCED" ]; then
  return 0
fi
_BLOOMSH_PLUGIN_SH_UTILS_SOURCED=1

function fn() {
  : <<'DOC'
NAME
    fn - Find by Name
SYNOPSIS
    fn [PATTERN]
DESCRIPTION
  Searches for files and directories within the current directory
  that contain the specified pattern in their name.
PARAMETERS
  <pattern> - A string pattern to search for in file and directory names.
EXAMPLES
  fn foo      # Finds all files and directories containing 'foo'
  fn "*.txt"  # Finds all files and directories containing '.txt'
RETURNS
  A list of file and directory names that match the pattern.
DOC
  find . -type f -name "*$1*" -o -type d -name "*$1*"
}
