#!/bin/bash

function main(){
    local DIR=$(cd $(dirname $0) && pwd)
    local TMPDIR=$DIR/tmp

    # settings
    local INSTALL_DIR=~/local
    local VIM_VERSION="v7-4-380"
    local PYTHON_CONFIG_DIR=/usr/local/lib/python2.7/config
    local LUA_PREFIX=/usr
    
    if [ ! -d $TMPDIR ]; then
        mkdir $TMPDIR
        echo "mkdir: $TMPDIR"
    fi
    if [ ! -d $INSTALL_DIR ]; then
        mkdir $INSTALL_DIR
        echo "mkdir: $INSTALL_DIR"
    fi

    # install packages
    sudo yum install mercurial ncurses-devel lua-devel ruby-devel perl-devel perl-ExtUtils-Embed

    cd $TMPDIR

    # download vim source
    hg clone https://vim.googlecode.com/hg/ vim
    if [ $? -ne 0 ]; then
        # /usr/bin/pythonをpython2.7に置き換えているときはhgコマンドが通らないので,
        # /usr/bin/hgの1行目#!/usr/bin/pythonを#!/usr/bin/python2.6に書き換える
        echo "error"
        exit 1
    fi

    cd vim

    hg tags | grep "$VIM_VERSION"
    if [ $? -ne 0 ]; then
        echo "version error: $VIM_VERSION"
        exit 1
    fi

    hg update "$VIM_VERSION"

    # configure and make
    ./configure \
    --enable-multibyte \
    --with-features=huge \
    --disable-selinux \
    --prefix=$INSTALL_DIR \
    --enable-pythoninterp \
    --with-python-config-dir=$PYTHON_CONFIG_DIR \
    --enable-perlinterp \
    --enable-rubyinterp \
    --enable-luainterp \
    --with-lua-prefix=$LUA_PREFIX \
    --enable-cscope \
    --enable-fontset \
    --enable-gpm

    make
    make test

    echo "install to $INSTALL_DIR [y/N]"
    read ans
    case $ans in
        y)
            :
            ;;
        *)
            echo "skip: install" 
            exit 1
            ;;
    esac

    # install
    make install
    echo "install done"

    exit 0
}

main $@
