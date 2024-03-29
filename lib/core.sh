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

# Protect against running outside of bloom execution.
if [ -z "$BLOOMSH_VERSION" ]; then
  echo "This must be executed from a bloom session."
  exit 1
fi

# Protect against sourcing multiple times
if [ -n "$_BLOOMSH_CORE_SOURCED" ]; then
  return 0
fi
_BLOOMSH_CORE_SOURCED=1

declare -a BLOOMSH_LIBS
declare -a BLOOMSH_CMDS
declare -a BLOOMSH_PLUGINS

__source() {
  : <<'DOC'
NAME
    __source - Source a script file and set the context based on its path.
SYNOPSIS
    __source [FILEPATH]
DESCRIPTION
    This function takes a file path as an argument, sources the script if it
    exists and is readable, and sets the context based on the path.
ARGUMENTS
   FILEPATH 
      The file path to the script. Must have a valid context
      Contexts:
        - For files in the 'lib/' directory: 'lib:<lib_name>'
        - For files in the 'commands/' directory: 'commands:<command_name>'
        - For files in the 'plugins/' directory: 'plugins:<plugin_name>'
EXAMPLES
   __source "lib/my_lib.sh"
NOTES
    This function (and any function starting with '__') should not be directly executed.  
DOC
  local context filepath="$1"

  # Construct context based on path
  case "$filepath" in
  lib/*) # lib_name from lib/lib_name.sh
    context="lib:$(basename "${filepath%.*}")"
    BLOOMSH_LIBS+=("$context")
    ;;
  commands/*) # commands_name from commands/command_name.sh
    context="commands:$(basename "${filepath%.*}")"
    BLOOMSH_CMDS+=("$context")
    ;;
  plugins/*) # plugin_name from plugins/plugin_name/file.sh
    context="plugins:$(basename "$(dirname "$filepath")")"
    BLOOMSH_PLUGINS+=("$context")
    ;;
  esac

  # Disable shellcheck complaining about variables in sourced files
  # shellcheck disable=SC1090
  if [[ -f "$BLOOM_ROOT/$filepath" && -r "$BLOOM_ROOT/$filepath" ]]; then
    source "$BLOOM_ROOT/$filepath"
  fi
}

source_lib() {
  : <<'DOC'
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
    This function, intentionally, does not recursively source files in subdirectories.
    It only sources files directly within the specified directory.
DOC
  local dir="$1"

  # Check if the directory exists
  if [ -d "$dir" ]; then
    for script_file in "$dir"/*.sh; do
      # Check if the file exists and is readable
      if [ -f "$script_file" ] && [ -r "$script_file" ]; then
        # Disable shellcheck complaining about variables in sourced files
        # shellcheck disable=SC1090
        __source "lib/$(basename "$script_file")"
      fi
    done
  else
    echo "Error: The directory $dir does not exist."
    return 1
  fi
}

# Load all libs
source_lib "$BLOOM_ROOT/lib"

# are there any plugins?
__is_plugin() {
  local base_dir=$1
  local name=$2
  test -f "$base_dir/plugins/$name/$name.plugin.sh"
}

# If any plugins are defined, attempt to load them
# Disable warning about "plugins" being undefined
# shellcheck disable=SC2154
if [[ -n ${plugins+x} && ${#plugins[@]} -ne 0 ]]; then
  for plugin in "${plugins[@]}"; do
    if __is_plugin "$BLOOM_ROOT" "$plugin"; then
      __source "plugins/$plugin/$plugin.plugin.sh"
    else
      echo "[BLOOM] plugin '$plugin' not found"
    fi
  done
fi

# Export the loaded libs,cmds,plugins for use in other scripts
BLOOMSH_LIBS_STRING=$(
  IFS=,
  echo "${BLOOMSH_LIBS[*]}"
)
BLOOMSH_CMDS_STRING=$(
  IFS=,
  echo "${BLOOMSH_CMDS[*]}"
)
BLOOMSH_PLUGINS_STRING=$(
  IFS=,
  echo "${BLOOMSH_PLUGINS[*]}"
)
export BLOOMSH_LIBS_STRING
export BLOOMSH_CMDS_STRING
export BLOOMSH_PLUGINS_STRING
