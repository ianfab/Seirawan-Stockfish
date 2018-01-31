#!/bin/bash
# obtain and optionally verify Bench / signature
# if no reference is given, the output is deliberately limited to just the signature

error()
{
  echo "running bench for signature failed on line $1"
  cat bench.txt
  exit 1
}
trap 'error ${LINENO}' ERR

# obtain

./stockfish bench &> bench.txt

signature=`grep "Nodes searched  : " bench.txt | awk '{print $4}'`

if [ $# -gt 0 ]; then
   # compare to given reference
   if [ "$1" != "$signature" ]; then
      echo "signature mismatch: reference $1 obtained $signature"
      exit 1
   else
      echo "signature OK: $signature"
   fi
else
   # just report signature
   echo $signature
fi
