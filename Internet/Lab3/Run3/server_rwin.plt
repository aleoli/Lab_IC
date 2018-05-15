set xlabel "Tempo [s]"
set ylabel "Server Window Size"
set grid
set terminal png
set output "server_rwin.png"
plot "server_rwin.txt" with linespoint
