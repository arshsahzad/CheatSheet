#!/bin/sh

readarray array <<< $( cat "$@" )

mkdir -p ~/git && cd ~/git

for element in ${array[@]}
do
  echo "clonning $element"
  git clone $element
done