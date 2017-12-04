#!/usr/bin/env bash

# creates navi folder
mkdir ~/.navi
sudo chmod -R 777 ~/.navi
cp bin/navi.sh ~/.navi/

# shell = $SHELL
if [ "$SHELL"="/bin/zsh" ]; then
  echo "alias navi='$HOME/.navi/navi.sh'" >> ~/.zshrc
  zsh
  print "Written to .zshrc"
else
  echo "alias navi='$HOME/.navi/navi.sh'" >> ~/.bashrc
  bash
  echo "Written to .bashrc"
fi
