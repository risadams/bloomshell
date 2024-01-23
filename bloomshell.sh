#!/usr/bin/env bash

# setup global variables
VERSION="0.0.1"
SCRIPT_NAME=$(basename "$0")
SELF=$(readlink -f "$0")
BLOOM_ROOT=${SELF%/*}

# Load core library utilities
source "$BLOOM_ROOT/lib/core.sh"
source_lib "$BLOOM_ROOT/lib"
