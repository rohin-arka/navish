#!/bin/sh
naviinstall(){
  # create navi base directory
  dir='/var/navi'
  sudo mkdir $dir
  sudo chmod -R 777 $dir
  echo "Create /var/navi directory... done."

  # clone navi-client into /var/navi
  echo "Cloning navi-client into ~/.navi/navi-client..."
  cloneGitRepository(){
      url='https://github.com/BlackRabbitt/navi-client.git'
      git clone $url ~/.navi/navi-client
  }
  # Path to the naviai executable
  cloneGitRepository
  echo "... done."

  echo "Installing navi-client..."
  # Path to the navi-client executable script
  if [ $SHELL = '/bin/zsh' ] && [ $1 == "update" ]; then
      echo "export NAVI_PATH='\$HOME/.navi'" >> ~/.zshrc
      echo "alias navicli='\$NAVI_PATH/navi-client/bin/navi-client'" >> ~/.zshrc
  else
      echo "export NAVI_PATH='\$HOME/.navi'" >> ~/.bashrc
      echo "alias navicli='\$NAVI_PATH/navi-client/bin/navi-client'" >> ~/.bashrc
  fi
  echo "... done"

  echo "Installing the dependent gems for navi-client..."
  bundleDependencies(){
      cd /Users/suryasiwakoti/.navi/navi-client/bin/; bundle install; cd $HOME;
  }
  bundleDependencies

  echo "... done."

  echo "Downloading naviai program ..."
  downloadNaviAI(){
      curl -o $HOME/.navi/naviai.zip "https://s3.amazonaws.com/locallockbox/naviai.zip"
      cd ~/.navi/
      unzip -a naviai.zip
      rm -rf naviai.zip
  }
  downloadNaviAI
  echo "... done."

  brew install mitie

  echo "Installing naviai ..."
  if [ $SHELL = '/bin/zsh' ] && [ $1 == "update" ]; then
      echo "alias naviai='\$NAVI_PATH/naviai'" >> ~/.zshrc
  else
      echo "alias naviai='\$NAVI_PATH/naviai'" >> ~/.bashrc
  fi
  echo "... done."

  echo "Copy config file to /var/navi..."
  copyConfigFile(){
      curl -o $dir/config.yml "https://s3.amazonaws.com/locallockbox/config.yml.example"
  }

  copyConfigFile

  copyMitFile(){
      curl -o $dir/MITIE-models.zip "https://s3.amazonaws.com/locallockbox/MITIE-models.zip"
      cd $dir
      unzip -a MITIE-models.zip
      rm -rf MITIE-models.zip
  }

  copyMitFile

  exec $SHELL
  echo "... done."
}

naviupdate(){
  sudo rm -rf /var/navi
  sudo rm -rf $HOME/.navi/
  naviinstall
}
if [ $# -eq 0 ]; then
    echo "No arguments supplied. available arguments: install"

elif [ $1 == "install" ]; then
  naviinstall

elif  [ $1 == "update" ]; then
  naviupdate
else
  echo $1
    # echo "available arguments: install"
fi

command_exists () {
  command "$1" &> /dev/null ;
}

if command_exists rbenv
then
  command rbenv install ruby 2.4.1
  rbenv local 2.4.1
elif command_exists rvm
then
  command rvm install 2.4.1
  rvm use 2.4.1
fi
