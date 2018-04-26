#!/bin/bash

cat server_to_client.txt | grep -v Source | tr -s ' ' | cut -d' ' -f 3 > server.time.txt
cat server_to_client.txt | grep -v Source | cut -d'=' -f 2 | cut -d' ' -f 1 > server.seqno.txt
cat server_to_client.txt | grep -v Source | cut -d'=' -f 3 | cut -d' ' -f 1 > server.ackno.txt
cat server_to_client.txt | grep -v Source | cut -d'=' -f 4 | cut -d' ' -f 1 > server.rwin.txt
cat server_to_client.txt | grep -v Source | cut -d'=' -f 5 | cut -d' ' -f 1 > server.len.txt

paste server.time.txt server.len.txt > server_len.dat
