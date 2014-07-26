# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific aliases and functions
alias ls='ls -la -G --color' 

export LD_LIBRARY_PATH=/usr/local/lib:/home/ns64/local/lib:/usr/lib:/usr/lib64:/usr/local/cuda-6.0/lib64:$LD_LIBRARY_PATH
export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig:$PKG_CONFIG_PATH
export PYTHONPATH=/usr/local/opencv/lib/python2.7/site-packages:/usr/local/lib/python2.7/site-packages:$PYTHONPATH
