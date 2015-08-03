source ~/.path
source ~/.extras
source ~/.bash_prompt
source ~/.exports
source ~/.aliases
source ~/.functions

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# Include z.sh
Z_PREFIX="$HOME/.local/share/z"
Z_FILE="/z.sh"
if [ -f "$Z_PREFIX$Z_FILE" ]; then
    source "$Z_PREFIX$Z_FILE"
else
    git clone git@github.com:rupa/z.git "$Z_PREFIX"
    source "$Z_PREFIX$Z_FILE"
fi
