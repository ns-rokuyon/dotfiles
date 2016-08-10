#!/bin/bash

logging(){
    level=$1
    message=$2
    echo "[$level] $message"
}

get_args(){
    SRC_DIR=$1
    DST_DIR_ROOT=$2

    if [ "$SRC_DIR" = "" ]; then
        logging "ERROR" "not specified: SRC_DIR"
        exit 1
    fi
    if [ "$DST_DIR_ROOT" = "" ]; then
        logging "ERROR" "not specified: DST_DIR_ROOT"
        exit 1
    fi
}

search_mov(){
    movies=`find "$SRC_DIR" -type f -name '*.MOV' | xargs`
    if [ "$movies" = "" ]; then
        logging "INFO" "no movie files in $SRC_DIR"
        exit 1
    fi
}

cut_images(){
    set -e

    for mov in $movies
    do
        logging "INFO" "mov=$mov"
        outdir=$DST_DIR_ROOT/`echo "$mov" | xargs basename | cut -d'.' -f1`
        if [ ! -d $outdir ]; then
            mkdir $outdir
        else
            logging "ERROR" "$outdir already exists"
            exit 1
        fi

        logging "INFO" "ffmpeg start ..."
        ffmpeg -ss 3 -i $mov -r 1 -f image2 $outdir/%03d.jpg > /dev/null 2>&1
        logging "INFO" "ffmpeg end"

        images_num=`find $outdir -type f -name '*.jpg' | wc -l`
        delete_num=`expr $images_num / 3 \* 2`      # 削除する枚数を全体の2/3とする
        logging "DEBUG" "images_num=$images_num, delete_num=$delete_num"

        logging "INFO" "random sampling ..."
        find $outdir -type f -name '*.jpg' | shuf -n $delete_num | xargs rm

        logging "INFO" "resizing ..."
        mogrify -resize 640x -quality 100 $outdir/*.jpg > /dev/null

        logging "INFO" "done: $mov (images=`find $outdir -type f -name '*.jpg' | wc -l` in $outdir)"
    done
}

main(){
    get_args "$@"

    search_mov
    cut_images

    exit 0
}

main "$@"
