#!/bin/bash

# This script converts the local paths defined in compile_commands.json to paths through a mountpoint.
# It is indended to assist users using SSH to edit code, using YouCompleteMe in Vim. VIM FTW

currentdir=$PWD
findmnt=`(until findmnt . ; do cd .. ; done) | tail -n 1`
mountdir=`echo $findmnt | awk '{print $1}'`/
devicedir=`echo $findmnt | awk '{print $2}' | sed -e "s/.*:\(.*\)/\1/g"`
echo $devicedir
echo $mountdir
sed ./build/compile_commands.json -i.bak -e "s:$devicedir:$mountdir:g"
