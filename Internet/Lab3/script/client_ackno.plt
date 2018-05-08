set xlabel "Tempo [s]"
set ylabel "Client Ack Number"
set grid
set terminal png
set output "client_ackno.png"
plot "client_ackno.txt" with linespoint
