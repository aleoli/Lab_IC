set xlabel "Tempo [s]"
set ylabel "Client Window Size"
set grid
set terminal png
set output "client_rwin.png"
plot "client_rwin.txt" with linespoint
