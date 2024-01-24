#!/usr/bin/env bash

# ------------------------------------------------------------------------------
# SCRIPT NAME: bloomshell.sh
# DESCRIPTION: Entry point into the bloom framework
# VERSION: 1.0
# AUTHOR: Ris Adams
# CREATED DATE: 2024-01-22
# LAST UPDATED: 2024-01-24
# ------------------------------------------------------------------------------
# PROJECT INFO:
# Project Name: Bloomshell
# Repository: https://github.com/risadams/bloomshell
# ------------------------------------------------------------------------------
# ADDITIONAL NOTES:
# - The core library should be included first before loading any additional scripts
# - BLOOM_ROOT and BLOOMSH_VERSION need to be set, if renamed they should be renamed in all files.
# ------------------------------------------------------------------------------

# setup global variables
SCRIPT_NAME=$(basename "$0")
SELF=$(readlink -f "$0")
export BLOOM_ROOT=${SELF%/*}
export BLOOMSH_VERSION="0.0.1"

## Setup Plugins we wish to load
# Disable shellcheck complaining about unused variable
# shellcheck disable=SC2034
plugins=(
  alias   # includes common general-purpose aliases
  missing # check to ensure a missing plugin throws a warning
)

# Load core library utilities
# Disable shellcheck complaining about variables in sourced files
# shellcheck disable=SC1090
source "$BLOOM_ROOT/lib/core.sh"

# strip duplicate entries from the path
PATH="$(echo -n "$PATH" | awk -v RS=: -v ORS=: '!($0 in a) {a[$0]; print}')"
export PATH

echo "Running $SCRIPT_NAME v$BLOOMSH_VERSION."
echo "Loaded libs: $BLOOMSH_LIBS_STRING"
echo "Loaded plugins: $BLOOMSH_PLUGINS_STRING"
