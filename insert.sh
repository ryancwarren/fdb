#!/bin/bash

# Insert a record into a table.

table=
values=
FDB_DB=databases/test

if [[ ! -v FDB_DB ]]
then
  echo Please set FDB_DB to a database name
  exit 1
fi

while [[ $# -gt 0 ]]
do
  echo Looking at $1
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

echo table $table
echo values $values

primary_key=$(ls -l $FDB_DB/$table/*.r| wc -l)

echo primary_key $primary_key

echo -n $primary_key,$values >> $FDB_DB/$table/$primary_key.fdb
