#!/usr/bin/env bash

# creates navi folder
mkdir ~/.navi
sudo chmod -R 777 ~/.navi
cp bin/navi.sh ~/.navi/bin/navi

# shell = $SHELL
if [ "$SHELL"="/bin/zsh" ]; then
    echo "export NAVI_PATH=\$HOME/.navi" >> ~/.zshrc
    echo "export PATH=\$PATH:\$NAVI_PATH/bin" >> ~/.zshrc

    echo "use `navi install` command to install navi-localLockbox"
    zsh
else
    echo "export NAVI_PATH=\$HOME/.navi" >> ~/.bashrc
    echo "export PATH=\$PATH:\$NAVI_PATH/bin" >> ~/.bashrc

    echo "use `navi install` command to install navi-localLockbox"
    bash
fi
