#!/bin/sh
cd $( dirname -- "$0"; )
list=".vimrc"
for i in $list; do
    rsync -auK $i "$(readlink -f ~/$i)"
done
