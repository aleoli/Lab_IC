set xlabel "Tempo [s]"
set ylabel "Server Ack Number"
set grid
set terminal png
set output "server_ackno.png"
plot "server_ackno.txt" with linespoint
