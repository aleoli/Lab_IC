#!/bin/bash

sed -i "s/^/ /g" client_to_server.txt
sed -i "s/^/ /g" server_to_client.txt

cat client_to_server.txt | grep -v Source | tr -s ' ' | cut -d' ' -f 3 > client.time.txt
cat client_to_server.txt | grep -v Source | cut -d'=' -f 2 | cut -d' ' -f 1 > client.seqno.txt
cat client_to_server.txt | grep -v Source | cut -d'=' -f 3 | cut -d' ' -f 1 > client.ackno.txt.tmp
cat client_to_server.txt | grep -v Source | cut -d'=' -f 4 | cut -d' ' -f 1 > client.rwin.txt.tmp
cat client_to_server.txt | grep -v Source | cut -d'=' -f 5 | cut -d' ' -f 1 > client.len.txt.tmp


cat server_to_client.txt | grep -v Source | tr -s ' ' | cut -d' ' -f 3 > server.time.txt
cat server_to_client.txt | grep -v Source | cut -d'=' -f 2 | cut -d' ' -f 1 > server.seqno.txt
cat server_to_client.txt | grep -v Source | cut -d'=' -f 3 | cut -d' ' -f 1 > server.ackno.txt
cat server_to_client.txt | grep -v Source | cut -d'=' -f 4 | cut -d' ' -f 1 > server.rwin.txt
cat server_to_client.txt | grep -v Source | cut -d'=' -f 5 | cut -d' ' -f 1 > server.len.txt


# al primo pacchetto manca l'ack e quindi mi prende la lunghezza sbagliata
echo 0 > client.len.txt
tail client.len.txt.tmp -n +2 >> client.len.txt

echo 0 > client.ackno.txt
tail client.ackno.txt.tmp -n +2 >> client.ackno.txt

echo 0 > client.rwin.txt.tmp
tail client.rwin.txt.tmp -n +2 >> client.rwin.txt

rm -rf *.tmp


paste client.time.txt client.seqno.txt > client_seqno.txt
paste client.time.txt client.ackno.txt > client_ackno.txt
paste client.time.txt client.rwin.txt > client_rwin.txt
paste client.time.txt client.len.txt > client_len.txt


paste server.time.txt server.seqno.txt > server_seqno.txt
paste server.time.txt server.ackno.txt > server_ackno.txt
paste server.time.txt server.rwin.txt > server_rwin.txt
paste server.time.txt server.len.txt > server_len.txt


gnuplot client_seqno.plt
gnuplot client_ackno.plt
gnuplot client_rwin.plt
gnuplot client_len.plt


gnuplot server_seqno.plt
gnuplot server_ackno.plt
gnuplot server_rwin.plt
gnuplot server_len.plt


