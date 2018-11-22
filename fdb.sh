#!/bin/bash
#  _____ ____  ____  
# |  ___|  _ \| __ ) 
# | |_  | | | |  _ \ 
# |  _| | |_| | |_) |
# |_|   |____/|____/ 
#                    
databases=databases

while [[ $# -gt 0 ]]
do
  case $1 in
    create-database)
      shift
      name=$1
      dd if=/dev/zero of=$databases/$name.fdb bs=1024 count=1000
      mkfs.ext4 $databases/$name.fdb
      mkdir $databases/$name
      sudo mount -o loop $databases/$name.fdb $databases/$name
      shift
      ;;
    *)
      echo Unknown command.
      shift
      ;;
  esac 
done
