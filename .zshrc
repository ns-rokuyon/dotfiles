# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
ZSH_THEME="gallois"

plugins=(git python ruby rails yum)

source $ZSH/oh-my-zsh.sh

# User configuration
. ~/.bashrc
export PATH=$HOME/misc/bin:$HOME/bin:/usr/local/bin:$PATH
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/home/ns64/misc/lib
export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/home/ns64/local/lib/pkgconfig

autoload -U compinit; compinit 
setopt auto_list               
setopt auto_menu                
setopt list_packed             
setopt list_types              
bindkey "^[[Z" reverse-menu-complete  
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' 

setopt auto_cd         
setopt auto_pushd      
#setopt correct         
unsetopt correct_all

alias ls='ls -la --color=auto'
alias ks='ls'

# rbenv
if [ -d ~/.rbenv ]; then
    export PATH="$HOME/.rbenv/bin:$PATH"
    eval "$(rbenv init -)"
fi

# pyenv
if [ -d ~/.pyenv ]; then
    export PYENV_ROOT=$HOME/.pyenv
    export PATH=$PYENV_ROOT/bin:$PATH
    eval "$(pyenv init -)"
fi

if [ -d ~/.pyenv/plugins/pyenv-virtualenv ]; then
    eval "$(pyenv virtualenv-init -)"
fi
