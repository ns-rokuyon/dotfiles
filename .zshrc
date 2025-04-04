
# User configuration
# =======================================================
export PATH=/bin:/usr/bin:/usr/local/bin:$HOME/misc/bin:$HOME/local/bin:$HOME/bin:/usr/local/bin
export LD_LIBRARY_PATH=/lib64:/usr/lib:/usr/local/lib:/home/ns64/misc/lib:$HOME/local/lib
export PKG_CONFIG_PATH=/usr/lib/pkgconfig:/usr/local/lib/pkgconfig:/home/ns64/local/lib/pkgconfig

# zplug
# =======================================================
source ~/.zplug/init.zsh
zplug "zsh-users/zsh-history-substring-search"
zplug "zsh-users/zsh-syntax-highlighting"

zplug "plugins/git", from:oh-my-zsh
zplug "plugins/yum", from:oh-my-zsh
zplug "plugins/python", from:oh-my-zsh

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

# Prompt
# =======================================================
autoload -Uz colors
colors
PROMPT='%{$fg[green]%}[%n@%m]%{$reset_color%} %~ %# '


# git
# (http://tkengo.github.io/blog/2013/05/12/zsh-vcs-info/)
# =======================================================
autoload -Uz vcs_info
setopt prompt_subst
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%F{yellow}!"
zstyle ':vcs_info:git:*' unstagedstr "%F{red}+"
zstyle ':vcs_info:*' formats "%F{green}%c%u[%b]%f"
zstyle ':vcs_info:*' actionformats '[%b|%a]'
precmd () { vcs_info }
RPROMPT='${vcs_info_msg_0_}'

# rbenv
if [ -d ~/.rbenv ]; then
    export PATH="$HOME/.rbenv/bin:$PATH"
    eval "$(rbenv init -)"
fi

# pyenv
# if [ -d ~/.pyenv ]; then
#     export PYENV_ROOT=$HOME/.pyenv
#     export PATH=$PYENV_ROOT/bin:$PATH
#     eval "$(pyenv init -)"
# fi

# if [ -d ~/.pyenv/plugins/pyenv-virtualenv ]; then
#     eval "$(pyenv virtualenv-init -)"
# fi

# zplug
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi
zplug load --verbose

alias ls='ls -la --color=auto'
alias ks='ls'


. "$HOME/.local/bin/env"
