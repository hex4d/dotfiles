#!/bin/bash

for f in .??*
do 
  [[ "$f" == ".git" ]] && continue
  [[ "$f" == ".DS_Store" ]] && continue

  path=$(cd $(dirname $f) && pwd)
  path="${path}/${f}"
  echo $path
  ln -s $path ~/
done

# aaaa

