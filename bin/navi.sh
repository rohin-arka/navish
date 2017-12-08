#!/bin/sh

if [ $# -eq 0 ]; then
    echo "No arguments supplied. available arguments: install"

elif [ $1 == "install" ]; then

    # clone navi-client into /var/navi
    echo "Cloning navi-client into ~/.navi/navi-client..."
    cloneGitRepository(){
        url='https://github.com/BlackRabbitt/navi-client.git'
        git clone $url ~/.navi/navi-client
    }
    # Path to the naviai executable
    cloneGitRepository
    echo "... done."

    echo "Installing the dependent gems for navi-client..."
    bundleDependencies(){
        cd $NAVI_PATH; bundle install; cd $HOME;
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
        unzip -a $NAVI_PATH/MITIE-models.zip $NAVI_PATH/
        rm -rf $NAVI_PATH/MITIE-models.zip
    }

    copyMitFile
    echo "... done."
else
    echo "available arguments: install"
fi
