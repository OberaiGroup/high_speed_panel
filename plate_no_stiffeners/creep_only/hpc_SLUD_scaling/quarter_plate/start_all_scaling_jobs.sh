#!/usr/bin/bash

rootdir="$(pwd)"

for d in `find . -type d`
do
  cd $d
  sbatch run_albany*.sh
  cd $rootdir
done 
