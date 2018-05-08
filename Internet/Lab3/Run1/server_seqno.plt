set xlabel "Tempo [s]"
set ylabel "Server Sequence Number"
set grid
set terminal png
set output "server_seqno.png"
plot "server_seqno.txt" with linespoint
