# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
ZSH_THEME="gallois"

plugins=(git python ruby rails yum)

source $ZSH/oh-my-zsh.sh

# User configuration
export PATH=$HOME/bin:/usr/local/bin:$PATH

autoload -U compinit; compinit 
setopt auto_list               
setopt auto_menu                
setopt list_packed             
setopt list_types              
bindkey "^[[Z" reverse-menu-complete  
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' 

setopt auto_cd         
setopt auto_pushd      
setopt correct         

export CLICOLOR=true

alias ls='ls -la'
alias ks='ls'

alias vi='env LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/Vim "$@"'
alias vim='env LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/Vim "$@"'

export PATH=/opt/local/bin:/opt/local/sbin:$PATH
export PATH=$PATH:/usr/local/mysql/bin

export MANPATH=/opt/local/share/man:/opt/local/man:$MANPATH
