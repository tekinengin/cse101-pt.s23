#!/usr/bin/bash

SRCDIR=https://raw.githubusercontent.com/tekinengin/cse101-pt.s23/main/pa3

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

if [ ! -e backup ]; then
  mkdir backup
fi

cp *.c *.h Makefile backup   # copy all files of importance into backup

curl $SRCDIR/ModelGraphTest.c > ModelGraphTest.c

echo ""
echo ""

rm -f *.o FindComponents

echo "Press Enter To Continue with GraphTest Results"
read verbose

echo ""
echo ""

gcc -c -std=c17 -Wall -g ModelGraphTest.c Graph.c List.c
gcc -o ModelGraphTest ModelGraphTest.o Graph.o List.o

timeout 6 valgrind --leak-check=full -v ./ModelGraphTest -v > GraphTest-out.txt 2> GraphTest-mem.txt
if [ $? -eq 124 ]; then
    echo -e "${RED} ModelGraphTest TEST TIMED OUT ${NC}"
fi

cat GraphTest-mem.txt
cat GraphTest-out.txt

rm -f *.o ModelGraphTest* garbage GraphTest-mem.txt GraphTest-out.txt

