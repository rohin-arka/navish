#!/usr/bin/env bash
# create navi base directory
dir='/var/navi'
sudo mkdir $dir
chmod +x $dir

# clone navi-client into /var/navi



cloneGitRepository(){
  url='https://github.com/BlackRabbitt/navi-client.git'
  git clone $url ~/.navi/navi-client
}
# Path to the naviai executable
cloneGitRepository

# Path to the navi-client executable script
if echo $SHELL = '/bin/zsh'; then
  echo "export NAVI_PATH='$HOME/.navi'" >> ~/.zshrc
  echo "alias navicli='$HOME/.navi/navi-client/bin/navi-client'" >> ~/.zshrc
  zsh
  source .zshrc
else
  echo "export NAVI_PATH='$HOME/.navi'" >> ~/.bashrc
  bash
  source .bashrc
  echo "alias navicli='$NAVI_PATH/navi-client/bin/navi-client'" >> ~/.bashrc
  bash
  source .bashrc
fi
bundleDependencies(){
  cd $NAVI_PATH
  bundle
  cd $HOME
}
bundleDependencies

downloadNaviAI(){
  curl -o $NAVI_PATH/naviai.zip "https://s3.amazonaws.com/locallockbox/naviai.zip"
  cd ~/.navi/
  unzip -a naviai.zip
  rm -rf naviai.zip
}
downloadNaviAI

brew install mitie

if echo $SHELL = '/bin/zsh'; then
  echo "alias naviai='$NAVI_PATH/naviai'" >> ~/.zshrc
  zsh
  source .zshrc
else
  echo "alias naviai='$NAVI_PATH/naviai'" >> ~/.bashrc
  bash
  source .bashrc
fi

copyConfigFile(){
  curl -o $dir/config.yml "https://s3.amazonaws.com/locallockbox/config.yml.example"
}

copyConfigFile

copyMitFile(){
  curl -o $dir/MITIE-models.zip "https://s3.amazonaws.com/locallockbox/MITIE-models.zip"
  unzip -a MITIE-models.zip
  rm -rf MITIE-models.zip
}

copyMitFile
