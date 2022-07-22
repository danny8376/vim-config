#!/bin/sh
cd $( dirname -- "$0"; )
rsync -au .vimrc ~
