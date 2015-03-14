alias emacs='/Applications/Emacs.app/Contents/MacOS/Emacs'
alias ls='ls -la -G'
alias platex='platex --kanji==utf8'
alias javac='javac -J-Dfile.encoding=UTF-8'
alias java='java -Dfile.encoding=UTF-8'

alias vi='env LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/Vim "$@"'
alias vim='env LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/Vim "$@"'

export PS1='\[\033[40;1;32m\]\W \[\033[40;2;37m\]\u\[\033[0m\] $ '


export PATH=/opt/local/bin:/opt/local/sbin:$PATH
export MANPATH=/opt/local/share/man:/opt/local/man:$MANPATH

export PATH=$PATH:/usr/local/mysql/bin

[[ -s ~/.nvm/nvm.sh ]] && . ~/.nvm/nvm.sh
nvm use default
npm_dir=${NVM_PATH}_modules
export NODE_PATH=$npm_dir
