#!/bin/sh

naviinstall(){
    # clone navi-client into /var/navi
    echo "Cloning navi-client into ~/.navi/navi-client..."
    cloneGitRepository(){
        url='https://github.com/BlackRabbitt/navi-client.git'
        git clone $url ~/.navi/navi-client
    }
    # Path to the naviai executable
    cloneGitRepository
    echo "... done."

    # include the bin/ directory of navi-client in PATH
    if [ "$SHELL"="/bin/zsh" ]; then
        echo "export PATH=\$PATH:\$NAVI_PATH/navi-client/bin" >> ~/.zshrc
    else
        echo "export PATH=\$PATH:\$NAVI_PATH/navi-client/bin" >> ~/.bashrc
    fi


    echo "Installing the dependent gems for navi-client..."
    bundleDependencies(){
        cd $NAVI_PATH/navi-client; bundle install; cd $HOME;
    }
    bundleDependencies

    echo "... done."

    echo "Downloading naviai program ..."
    downloadNaviAI(){
        curl -o $NAVI_PATH/bin/naviai.zip "https://s3.amazonaws.com/locallockbox/naviai.zip"
        unzip -a $NAVI_PATH/bin/naviai.zip $NAVI_PATH/bin/
        rm -rf $NAVI_PATH/bin/naviai.zip
    }
    downloadNaviAI
    echo "... done."

    brew install mitie
    echo "... done."

    echo "Copy config file to /var/navi..."
    copyConfigFile(){
        curl -o $NAVI_PATH/config.yml "https://s3.amazonaws.com/locallockbox/config.yml.example"
    }

    copyConfigFile

    copyMitFile(){
        curl -o $NAVI_PATH/MITIE-models.zip "https://s3.amazonaws.com/locallockbox/MITIE-models.zip"
        unzip -a $NAVI_PATH/MITIE-models.zip -d $NAVI_PATH/MITIE-models
        rm -rf $NAVI_PATH/MITIE-models.zip
    }

    # copyMitFile
    echo "... done."
}

naviupdate(){
  sudo rm -rf $HOME/.navi/
  naviinstall
}

command_exists () {
    command "$1" &> /dev/null ;
}

if command_exists rbenv
then
    command rbenv install ruby 2.4.1
    rbenv local 2.4.1
elif command_exists rvm
then
  rvm list > local_ruby_versions.txt
  get_ruby_version="$(grep ruby-2.2.4 local_ruby_versions.txt)"
  if [ "$get_ruby_version" ]; then
    bash -l -c "rvm use 2.2.4"
  else
    bash -l -c "rvm install 2.2.4"
  fi
  bash -l -c "rvm use 2.2.4"
fi

if [ $# -eq 0 ]; then
    echo "No arguments supplied. available arguments: install"
    exit 64;
elif [ $1 == "install" ]; then
  naviinstall
elif  [ $1 == "update" ]; then
  naviupdate
else
  echo $1
  echo "available arguments: install"
fi

if [ "$SHELL"="/bin/zsh" ]; then
    zsh
else
    bash
fi
