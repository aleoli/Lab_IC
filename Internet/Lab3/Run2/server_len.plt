set xlabel "Tempo [s]"
set ylabel "Server Packets Size"
set grid
set terminal png
set output "server_len.png"
plot "server_len.txt" with linespoint
