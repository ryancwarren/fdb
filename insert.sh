#!/bin/bash

#  ___ _   _ ____  _____ ____ _____ 
# |_ _| \ | / ___|| ____|  _ \_   _|
#  | ||  \| \___ \|  _| | |_) || |  
#  | || |\  |___) | |___|  _ < | |  
# |___|_| \_|____/|_____|_| \_\|_|  
#                                   
# Insert a record into a table.

table=
values=
FDB_DB= 

if [[ ! -v FDB_DB ]]
then
  echo Please set FDB_DB to a database name
  exit 1
fi

while [[ $# -gt 0 ]]
do
  case $1 in
    into)
      shift
      table=$1
      shift
      ;;
    values)
      shift
      values=$1
      shift
      ;; 
    *)
      echo unknown
      shift 
  esac
done

primary_key=$(ls -l $FDB_DB/$table/*.r| wc -l)

echo -n $primary_key,$values > $FDB_DB/$table/$primary_key.fdb
