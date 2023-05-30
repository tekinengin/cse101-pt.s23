#!/bin/bash
# cse101-pt.s23
# usage: pa7.sh
# (run within your pa7 directory to test your code)

SRCDIR=https://raw.githubusercontent.com/tekinengin/cse101-pt.s23/main/pa7

TIME_COEFF = $1

EXE_ALL=( pa7-func-check.sh pa7-unit-check.sh pa7-make-check.sh )
EXE_RANGE=$((${#EXE_ALL[*]} - 1))
echo $EXE_RANGE
for i in $(seq 0 $EXE_RANGE); do
  curl $SRCDIR/${EXE_ALL[i]} > ${EXE_ALL[i]}
  chmod +x ${EXE_ALL[i]}
  ./${EXE_ALL[i]} $TIME_COEFF
  rm -f ${EXE_ALL[i]}
done
