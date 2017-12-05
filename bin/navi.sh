#!/bin/sh

if [ $# -eq 0 ]; then
    echo "No arguments supplied. available arguments: install"

elif [ $1 == "install" ]; then

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
    if [ $SHELL = '/bin/zsh' ]; then
        echo "export NAVI_PATH='\$HOME/.navi'" >> ~/.zshrc
        echo "alias navicli='\$NAVI_PATH/navi-client/bin/navi-client'" >> ~/.zshrc
    else
        echo "export NAVI_PATH='\$HOME/.navi'" >> ~/.bashrc
        echo "alias navicli='\$NAVI_PATH/navi-client/bin/navi-client'" >> ~/.bashrc
    fi
    echo "... done"

    echo "Installing the dependent gems for navi-client..."
    bundleDependencies(){
        cd $HOME/.navi; bundle install; cd $HOME;
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
    if [ $SHELL = '/bin/zsh' ]; then
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

else
    echo "available arguments: install"
fi
