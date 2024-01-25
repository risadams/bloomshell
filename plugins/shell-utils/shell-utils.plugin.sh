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

#TODO...