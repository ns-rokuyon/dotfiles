
# zplug
source ~/.zplug/zplug
zplug "zsh-users/zsh-history-substring-search"
zplug "zsh-users/zsh-syntax-highlighting"

zplug "plugins/git", from:oh-my-zsh
zplug "plugins/yum", from:oh-my-zsh
zplug "plugins/python", from:oh-my-zsh


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

# zplug
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi
zplug load --verbose

