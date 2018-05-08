set xlabel "Tempo [s]"
set ylabel "Client Packets Size"
set grid
set terminal png
set output "client_len.png"
plot "client_len.txt" with linespoint
