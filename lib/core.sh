#!/usr/bin/env bash

# ------------------------------------------------------------------------------
# SCRIPT NAME: core.sh
# DESCRIPTION: This script includes basic functionality needed to support the framework.
# VERSION: 1.0
# AUTHOR: Ris Adams
# CREATED DATE: 2024-01-22
# LAST UPDATED: 2024-01-22
# ------------------------------------------------------------------------------
# PROJECT INFO:
# Project Name: Bloomshell
# Repository: https://github.com/risadams/bloomshell
# ------------------------------------------------------------------------------
# ADDITIONAL NOTES:
# - The core library should be included first before loading any additional scripts
# - It is required for basic functionality
# ------------------------------------------------------------------------------

if [ -n "$_BLOOMSH_CORE_SOURCED" ]; then
  return 0
fi

_BLOOMSH_CORE_SOURCED=1

: <<'SOURCE_LIB'
 NAME
        source_lib - Sources shell script files from a specified directory.

    SYNOPSIS
        source_lib [DIRECTORY]

    DESCRIPTION
        source_lib is a function that takes a single argument, a directory path,
        and sources all shell script files (.sh) located within that directory.
        
        This function first checks if the specified directory exists. If it does,
        it iterates over each shell script file in the directory. For each file,
        it checks if the file exists and is readable. If both conditions are met,
        the script file is sourced, and a confirmation message is echoed to
        the terminal, indicating the file has been sourced.

        If the specified directory does not exist, an error message is displayed.

    ARGUMENTS
        DIRECTORY
            A path to the directory containing shell script files to be sourced.
            The directory must exist and contain files with a .sh extension.

    OUTPUT
        For each sourced script file, a confirmation message "Sourced: [FILE_PATH]"
        is displayed. If the directory does not exist, an error message is shown.

    EXAMPLES
        source_lib "/path/to/scripts"
            This will source all .sh files located in '/path/to/scripts'.

    NOTES
        This function does not recursively source files in subdirectories.
        It only sources files directly within the specified directory.

    AUTHOR
        Written by Ris Adams.
SOURCE_LIB
source_lib() {
  local dir="$1"

  # Check if the directory exists
  if [ -d "$dir" ]; then
    for script_file in "$dir"/*.sh; do
      # Check if the file exists and is readable
      if [ -f "$script_file" ] && [ -r "$script_file" ]; then
        source "$script_file"
      fi
    done
  else
    echo "Error: The directory $dir does not exist."
  fi
}
