#!/usr/bin/env bash

# grab shellspec
curl -fsSL https://git.io/shellspec | sh -s -- --yes
chmod +x "$HOME/.local/bin/shellspec"
echo "Shellspec installed"
shellspec -v

# compile kcov, should be cloned via action
cd "$GITHUB_WORKSPACE/kcov" || {
  echo "Failure to find kcov root dir."
  exit 1
}
cmake "$GITHUB_WORKSPACE/kcov"
make
sudo make install

# path for both shellspac and kcov
export PATH=$PATH:$HOME/.local/bin:/usr/local/bin
