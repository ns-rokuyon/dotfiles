# User configuration
export PATH=$HOME/bin:/usr/local/bin:$PATH

# zplug
source ~/.zplug/init.zsh
zplug "zsh-users/zsh-history-substring-search"
zplug "zsh-users/zsh-syntax-highlighting"

zplug "plugins/git", from:oh-my-zsh
zplug "plugins/yum", from:oh-my-zsh
zplug "plugins/python", from:oh-my-zsh

# zplug
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi
zplug load --verbose

# nodejs
[[ -s ~/.nvm/nvm.sh ]] && . ~/.nvm/nvm.sh
nvm alias default v0.11.10
nvm use default
npm_dir=${NVM_PATH}_modules
export NODE_PATH=$npm_dir

# zsh
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
autoload -Uz vcs_info    
setopt prompt_subst    
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%F{yellow}!"
zstyle ':vcs_info:git:*' unstagedstr "%F{red}+"
zstyle ':vcs_info:*' formats "%F{green}%c%u[%b]%f"
zstyle ':vcs_info:*' actionformats '[%b|%a]'
precmd () { vcs_info }
PROMPT="[%{${fg[green]}%}%n%{${reset_color}%}@%F{blue}localhost%f:%d]$ "
RPROMPT='${vcs_info_msg_0_}'

if [ -f /usr/local/bin/gls ]; then
    alias ls='gls -la --color=auto'
else
    alias ls='ls -la -G'
fi
alias ks='ls'

alias vi='env LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/Vim "$@"'
alias vim='env LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/Vim "$@"'

export PATH=$PATH:/opt/local/bin:/opt/local/sbin
export PATH=$PATH:/usr/local/mysql/bin

export MANPATH=/opt/local/share/man:/opt/local/man:$MANPATH

# rbenv
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

# Golang
if which go > /dev/null; then
    export GOPATH=$HOME/go
fi

