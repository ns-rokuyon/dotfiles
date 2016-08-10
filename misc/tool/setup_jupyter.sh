#!/bin/bash
# Setup jupyter notebook

DIR=$(cd $(dirname $0) && pwd)

main() {
    if [ ! -d ~/.jupyter ]; then
        cp -r $DIR/../../.jupyter ~/
    else
        if [ ! -f ~/.jupyter/jupyter_notebook_config.py ]; then
            cp $DIR/../../.jupyter/jupyter_notebook_config.py ~/.jupyter/
        else
            read -p "Overwrite jupyter_notebook_config.py? [y/N]" ans
            case $ans in
                y)
                    :
                    ;;
                *)
                    echo "canceled"
                    exit 1
                    ;;
            esac
        fi
    fi

    # Set password
    cd $HOME
    python -c "from notebook.auth import passwd; sha1 = passwd(); f = open('.jupyter/jupyter_notebook_config.py', 'a'); f.write('\n# PASSWORD\nc.NotebookApp.password = u\'{}\'\n'.format(sha1)); f.close()"
}

main "$@"
