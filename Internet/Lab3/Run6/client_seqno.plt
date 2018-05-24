set xlabel "Tempo [s]"
set ylabel "Client Sequence Number"
set grid
set terminal png
set output "client_seqno.png"
plot "client_seqno.txt" with linespoint
