#!/usr/bin/env bash

curl -fsSL https://git.io/shellspec | sh -s -- --yes
chmod +x $HOME/.local/bin/shellspec
export PATH=$PATH:$HOME/.local/bin

echo "Shellspec installed"
shellspec -v
