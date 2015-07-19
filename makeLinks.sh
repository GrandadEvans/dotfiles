function installPackage() {
    local UNAME=`uname -a`
    local INSTALLER_ACTION="install"

    local INSTALLER_LIST=("equo", "yum", "aptitude")
    local INSTALLER_NAME=""

    for INSTALLER_NAME in $INSTALLER_LIST; do
        if `which $INSTALLER_NAME`; then
            # package manager exists
            break
        fi
    done

    echo "Installing the \"$1\" package using $INSTALLER_NAME"
    local INSTALLER_COMMAND="`which $INSTALLER_NAME` $INSTALLER_ACTION $1"
    `$INSTALLER_COMMAND`

    # Check to see if the action was successful
    if [ $? === 0 ]; then
        echo "Installation was successful!"
    else
        echo "======================================"
        echo "There was an error running the command:"
        echo $INSTALLER_COMMAND
    fi
}

function makeLink() {
    local SRC=$1
    local DEST=$2

    if [ ! -e "$SRC" ]; then
        echo "Source file \"$SRC\" does not exist"
    fi

    if [ -e "$DEST" ]; then
        read -p "The destination file \"$DEST/${SRC##*/}\" already exists, do you wish to overwrite it (Y|n): " -n 1
        echo
        if [[ $REPLY =~ ^[Nn]*$ ]]; then
            echo "Aborting link"
            return
        fi
    fi 

    `which ln` -sf "$SRC" "$DEST"
    
    if [ `echo $?` = 0 ]; then
        echo "Link was made to \"$DEST/${SRC##*/}\""
    else
        echo "======================================"
        echo "There was an error making a link from:"
        echo "$SRC"
        echo "    to..."
        echo "$DEST"
        echo "======================================"
    fi
}

makeLink /home/john/dotfiles/.bashrc ~
makeLink /home/john/dotfiles/.bash_profile ~
makeLink /home/john/dotfiles/.bash_prompt ~
makeLink /home/john/dotfiles/.aliases ~
makeLink /home/john/dotfiles/.exports ~
makeLink /home/john/dotfiles/.functions ~
makeLink /home/john/dotfiles/.gitconfig ~
makeLink /home/john/dotfiles/.gitignore ~
makeLink /home/john/dotfiles/.path ~
makeLink /home/john/dotfiles/.tmux.conf ~
makeLink /home/john/dotfiles/.tmuxinator ~
makeLink /home/john/dotfiles/.vimrc ~

echo "\nSourcing ~/.bashrc"
source ~/.bashrc

echo "\nSetting up Vim"
#if ! `which vim`; then
#    echo "Vim is NOT installed so bear with me..."
#    installPackage vim
#fi
#git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
#vim +PluginInstall +qall
#echo "Vim is now set up"
#
#echo "\nInstalling Composer dependancies"
#if ! `which composer`; then
#    echo "Composer is NOT installed...wait, out!"
#    curl -sS https://getcomposer.org/installer | php
#fi
#if [ -f ~/.composer/composer.lock ]; then
#    local COMPOSER_ACTION="install"
#else
#    local COMPOSER_ACTION="require"
#fi
#composer --global $COMPOSER_ACTION
#echo "Composer set up is now complete"
#
#
