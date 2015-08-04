#!/bin/bash
function installPackage() {
    local INSTALLER_ACTION="install"

    local INSTALLER_LIST=("equo" "yum" "aptitude")
    local INSTALLER_NAME=""
    local INSTALLER_COMMAND=""

    for INSTALLER_NAME in "${INSTALLER_LIST[@]}"; do
        if which "$INSTALLER_NAME"; then
            # package manager exists
            break
        fi
    done

    echo -e "Installing the \"$1\" package using $INSTALLER_NAME"
    INSTALLER_COMMAND=/bin/bash which "$INSTALLER_NAME" "$INSTALLER_ACTION" "$1"
    /bin/bash "$INSTALLER_COMMAND"

    # Check to see if the action was successful
    if [ $? = 0 ]; then
        echo -e "Installation was successful!"
    else
        echo -e "======================================"
        echo -e "There was an error running the command:"
        echo -e $INSTALLER_COMMAND
    fi
}

function makeLink() {
    local SRC=$1
    local DEST=$2
    local OVERWRITE_LINKS=false

    if [ ! -e "$SRC" ]; then
        echo -e "Source file \"$SRC\" does not exist"
    fi

    if [ $OVERWRITE_LINKS = false ]; then
        if [ -e "$DEST" ]; then
            read -p "The destination file \"$DEST/${SRC##*/}\" already exists, do you wish to overwrite it\n(Y)es; (n)o; (A)ll; (Q)uit: " -n 1
            echo
            if [[ $REPLY =~ ^[Nn]*$ ]]; then
                echo -e "Aborting link"
                return
            elif [[ $REPLY =~ ^[aA]*$ ]]; then
                echo -e "Overwriting all existing links"
                OVERWRITE_LINKS=true
            elif [[ $REPLY =~ ^[Qq]*$ ]]; then
                echo -e "Shit man! I didn't mean to offend you!"
                return
            fi
        fi
    fi

    /bin/bash which ln -sf "$SRC" "$DEST"

    if [ $? = 0 ]; then
        echo -e "Link was made to \"$DEST/${SRC##*/}\""
    else
        echo -e "======================================"
        echo -e "There was an error making a link from:"
        echo -e "$SRC"
        echo -e "    to..."
        echo -e "$DEST"
        echo -e "======================================"
    fi
}

function makeLinks() {
    DOTFILES="$DOTFILES_DIR"

    makeLink "$DOTFILES/.bashrc"        "$HOME"
    makeLink "$DOTFILES/.bash_profile"  "$HOME"
    makeLink "$DOTFILES/.bash_prompt"   "$HOME"
    makeLink "$DOTFILES/.aliases"       "$HOME"
    makeLink "$DOTFILES/.exports"       "$HOME"
    makeLink "$DOTFILES/.functions"     "$HOME"
    makeLink "$DOTFILES/.gitconfig"     "$HOME"
    makeLink "$DOTFILES/.gitignore"     "$HOME"
    makeLink "$DOTFILES/.path"          "$HOME"
    makeLink "$DOTFILES/.tmux.conf"     "$HOME"
    makeLink "$DOTFILES/.tmuxinator"    "$HOME"
    makeLink "$DOTFILES/.vimrc"         "$HOME"
    makeLink "$DOTFILES/.xinitrc"       "$HOME"
    makeLink "$DOTFILES/.blueProximity" "$HOME"
    makeLink "$DOTFILES/.config/autostart/Home" "$HOME/.config/autostart"
}

makeLinks

echo -e "\nSourcing ~/.bashrc"
source ~/.bashrc

echo -e "\nSetting up Vim"
if ! which vim; then
    echo -e "Vim is NOT installed so bear with me..."
    installPackage vim
fi
if [ ! -d  ~/.vim/bundle/Vundle.vim ]; then
    echo -e "\nInstalling vim packages...please wait, over"
    git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi
vim +PluginInstall +qall
echo -e "Vim is now set up"

echo -e "\nInstalling Composer dependancies"
if ! which composer; then
    echo -e "Composer is NOT installed...wait, out!"
    curl -sS https://getcomposer.org/installer | php
    echo -e "\nMoving the newly created composer.phar to ~/.local/share/bin/composer"

    mv composer.phar ~/.local/share/bin/composer
fi
if [ -f ~/.composer/composer.lock ]; then
    COMPOSER_ACTION="install"
else
    COMPOSER_ACTION="require"
fi
composer global $COMPOSER_ACTION

echo -e "Composer set up is now complete"


