#!/bin/bash
startdir=$PWD
cd ~
pacaur -S go
if [ ! -d ".go" ]; then
	mkdir .go
	go get github.com/thefryscorer/schemer2
fi
cd $startdir
ln -s ~/.go/bin/schemer2 .
