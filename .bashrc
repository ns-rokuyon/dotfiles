# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific aliases and functions
alias ls='ls -la -G --color' 

export LD_LIBRARY_PATH=/usr/local/lib:/home/ns64/local/lib:/usr/lib:/usr/lib64:/usr/local/cuda-6.0/lib64:$LD_LIBRARY_PATH
export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig:$PKG_CONFIG_PATH
export PYTHONPATH=/usr/local/opencv/lib/python2.7/site-packages:/usr/local/lib/python2.7/site-packages:~/git_repos/caffe/python:$PYTHONPATH

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
#    eval "$(pyenv virtualenv-init -)"
# fi

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/ns64/google-cloud-sdk/path.bash.inc' ]; then . '/home/ns64/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/ns64/google-cloud-sdk/completion.bash.inc' ]; then . '/home/ns64/google-cloud-sdk/completion.bash.inc'; fi

. "$HOME/.local/bin/env"
