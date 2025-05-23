#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=<database_name> -t --no-align -c"

# if no arguement is provided
if [[ -z $1 ]];
then
    echo  "Please provide an element as an argument."
    exit
fi

# check how to search
if [[ $1 =~  ^[0-9]+$ ]]
then 
  SEARCH_BY="atomitc_number"
elif [[ $1 =~  ^[A-Z][a-z]?$ ]]
then
  SEARCH_BY="symbol"
else
  SEARCH_BY="name"
fi

