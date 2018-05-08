#!/bin/bash

sed -i "s/^/ /g" client_to_server.txt
sed -i "s/^/ /g" server_to_client.txt

cat client_to_server.txt | grep -v Source | tr -s ' ' | cut -d' ' -f 3 > client.time.txt
cat client_to_server.txt | grep -v Source | cut -d'=' -f 2 | cut -d' ' -f 1 > client.seqno.txt
cat client_to_server.txt | grep -v Source | cut -d'=' -f 3 | cut -d' ' -f 1 > client.ackno.txt
cat client_to_server.txt | grep -v Source | cut -d'=' -f 4 | cut -d' ' -f 1 > client.rwin.txt
cat client_to_server.txt | grep -v Source | cut -d'=' -f 5 | cut -d' ' -f 1 > client.len.txt


cat server_to_client.txt | grep -v Source | tr -s ' ' | cut -d' ' -f 3 > server.time.txt
cat server_to_client.txt | grep -v Source | cut -d'=' -f 2 | cut -d' ' -f 1 > server.seqno.txt
cat server_to_client.txt | grep -v Source | cut -d'=' -f 3 | cut -d' ' -f 1 > server.ackno.txt
cat server_to_client.txt | grep -v Source | cut -d'=' -f 4 | cut -d' ' -f 1 > server.rwin.txt
cat server_to_client.txt | grep -v Source | cut -d'=' -f 5 | cut -d' ' -f 1 > server.len.txt


paste client.time.txt client.seqno.txt > client_seqno.txt
paste client.time.txt client.ackno.txt > client_ackno.txt
paste client.time.txt client.rwin.txt > client_rwin.txt
paste client.time.txt client.len.txt > client_len.txt


paste server.time.txt server.seqno.txt > server_seqno.txt
paste server.time.txt server.ackno.txt > server_ackno.txt
paste server.time.txt server.rwin.txt > server_rwin.txt
paste server.time.txt server.len.txt > server_len.txt
