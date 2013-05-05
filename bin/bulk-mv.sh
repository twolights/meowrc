#!/bin/bash

TEMPDIR=`mktemp -d -t bulk_mv` || exit 2;
SOURCE_FILE=$TEMPDIR/s
TARGET_FILE=$TEMPDIR/t

touch $SOURCE_FILE $TARGET_FILE

for file in $@; do
    echo $file >> $SOURCE_FILE
    echo $file >> $TARGET_FILE
done

vimdiff +'set readonly' +'wincmd l' +foldopen $SOURCE_FILE $TARGET_FILE

while true; do
    read -r src <&3
    read -r tgt <&4
    if [ -z "$src" -o -z "$tgt" ]; then
        break
    fi
    if [ "$src" = "$tgt" ]; then
        continue
    fi
    echo "$src" '=>' "$tgt"
    mv "$src" "$tgt"
done 3<$SOURCE_FILE 4<$TARGET_FILE

rm -f $SOURCE_FILE $TARGET_FILE

rmdir $TEMPDIR
