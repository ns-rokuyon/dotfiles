# User dependent .bashrc file
export LANG=ja_JP.UTF-8
export PAGER='lv -Ou8'
#export PS1='\[\e]0;\w\a\]\n\[\e[32m\]\u@\h [$PWD]\$ '
export PS1="\[\e]0;\w\a\]\[\e[32m\]\u@\h \[\e[33m\]\w\[\e[0m\]\$ "

alias ls='ls -la --show-control-chars --color=auto'
alias apt-cyg='apt-cyg -m ftp://ftp.jaist.ac.jp/pub/cygwin/ -c /package'

# If not running interactively, don't do anything
[[ "$-" != *i* ]] && return
