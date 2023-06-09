#!/usr/bin/bash

SRCDIR=https://raw.githubusercontent.com/tekinengin/cse101-pt.s23/main/pa3

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

if [ ! -e backup ]; then
  mkdir backup
fi

cp *.c *.h Makefile backup   # copy all files of importance into backup

curl $SRCDIR/ModelListTest.c > ModelListTest.c

echo ""
echo ""

rm -f *.o FindComponents

echo ""

echo "Press Enter To Continue with ListTest Results"
read verbose

gcc -c -std=c17 -Wall -g ModelListTest.c List.c
gcc -o ModelListTest ModelListTest.o List.o

timeout 6 ./ModelListTest -v > ListTest-out.txt
if [ $? -eq 124 ]; then
    echo -e "${RED} ModelListTest TEST TIMED OUT ${NC}"
fi

cat ListTest-out.txt

rm -f *.o ModelListTest* garbage ListTest-out.txt

