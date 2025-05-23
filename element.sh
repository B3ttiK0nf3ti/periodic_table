#!/bin/bash
PSQL="psql  --username=freecodecamp --dbname=periodic_table -t --no-align -c"

# if no arguement is provided
if [[ -z $1 ]];
then
    echo  "Please provide an element as an argument."
    exit
fi

# check how to search
if [[ $1 =~  ^[0-9]+$ ]]
then 
  SEARCH_BY="atomic_number"
elif [[ $1 =~  ^[A-Z][a-z]?$ ]]
then
  SEARCH_BY="symbol"
else
  SEARCH_BY="name"
fi

RESULT=$($PSQL "SELECT p.atomic_number, p.atomic_mass, p.melting_point_celsius, p.boiling_point_celsius, e.symbol, e.name, t.type FROM properties p INNER JOIN elements e USING(atomic_number) INNER JOIN types t USING(type_id) WHERE $SEARCH_BY = '$1'")

if [[ -z $RESULT ]]
then
  echo "I could not find that element in the database."
else
  IFS="|" read ATOMIC_NUMBER ATOMIC_MASS MELTING_POINT_CELSIUS BOILING_POINT_CELSIUS SYMBOL NAME TYPE  <<< "$RESULT"
  echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT_CELSIUS celsius and a boiling point of $BOILING_POINT_CELSIUS celsius."
fi
