#!/usr/bin/bash

SRCDIR=https://raw.githubusercontent.com/tekinengin/cse101-pt.s23/main/pa7

if [ ! -e backup ]; then
   echo "WARNING: a backup has been created for you in the \"backup\" folder"
   mkdir backup
fi

TIME_COEFF = $1
let MAX_TIME = $TIME_COEFF*5

cp *.cpp *.h Makefile backup   # copy all files of importance into backup

curl $SRCDIR/ModelDictionaryTest.cpp > ModelDictionaryTest.cpp

echo ""
echo ""

echo "Press Enter To Continue with Dictionary Unit Test"
read verbose

echo ""
echo ""

g++ -std=c++17 -Wall -c -g ModelDictionaryTest.cpp Dictionary.cpp
g++ -std=c++17 -Wall -o ModelDictionaryTest ModelDictionaryTest.o Dictionary.o

timeout $MAX_TIME valgrind --leak-check=full -v ./ModelDictionaryTest -v > DictionaryTest-out.txt 

cat DictionaryTest-out.txt 

rm -f *.o ModelDictionaryTest DictionaryTest-out.txt ModelDictionaryTest.cpp

