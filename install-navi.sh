#!/usr/bin/env bash

# creates navi folder
mkdir ~/.navi
cp bin/navi.sh ~/.navi/

# shell = $SHELL
if [ "$SHELL"="/bin/zsh" ]; then
  echo "alias navi='$HOME/.navi/navi.sh'" >> ~/.zshrc
  zsh
  source .zshrc
  print "Written to .zshrc"
else
  echo "alias navi='$HOME/.navi/navi.sh'" >> ~/.bashrc
  bash
  source .bashrc
  echo "Written to .bashrc"
fi
