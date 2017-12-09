#!/usr/bin/env bash

# creates navi folder
mkdir ~/.navi
mkdir ~/.navi/bin
sudo chmod -R 777 ~/.navi

cp bin/navi.sh ~/.navi/bin/navi

# shell = $SHELL
if [ "$SHELL"="/bin/zsh" ]; then
    echo "export NAVI_PATH=\$HOME/.navi" >> ~/.zshrc
    echo "export NAVI_ENV=local" >> ~/.zshrc
    echo "export PATH=\$PATH:\$NAVI_PATH/bin" >> ~/.zshrc

    zsh
else
    echo "export NAVI_PATH=\$HOME/.navi" >> ~/.bashrc
    echo "export NAVI_ENV=local" >> ~/.bashrc
    echo "export PATH=\$PATH:\$NAVI_PATH/bin" >> ~/.bashrc

    bash
fi
