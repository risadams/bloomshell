#!/usr/bin/env bash

# grab shellspec
curl -fsSL https://git.io/shellspec | sh -s -- --yes
chmod +x $HOME/.local/bin/shellspec
echo "Shellspec installed"
shellspec -v

# compile kcov, should be cloned via action
cd /home/runner/work/bloomshell/bloomshell/kcov
cmake /home/runner/work/bloomshell/bloomshell/kcov
make
sudo make install

# path for both shellspac and kcov
export PATH=$PATH:$HOME/.local/bin:/usr/local/bin