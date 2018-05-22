#!/bin/bash

sed "s/^/ /g" 4.txt > 4.tmp
sed "s/^/ /g" 4_b.txt > 4_b.tmp

cat 4.tmp | grep -v Source | tr -s ' ' | cut -d ' ' -f 3 > time.tmp
cat 4.tmp | grep -v Source | tr -s ' ' | cut -d ' ' -f 10 > port.tmp

cat 4_b.tmp | grep -v Source | tr -s ' ' | cut -d ' ' -f 3 > time_b.tmp
cat 4_b.tmp | grep -v Source | tr -s ' ' | cut -d ' ' -f 10 > port_b.tmp

paste time.tmp port.tmp > 4_port.txt
paste time_b.tmp port_b.tmp > 4_b_port.txt

rm -rf *.tmp
