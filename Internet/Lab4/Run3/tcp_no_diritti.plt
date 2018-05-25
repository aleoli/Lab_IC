set title "TCP Port Scan"
set xlabel "Tempo [s]"
set ylabel "Port"
set grid
set terminal png
set output "tcp_no_diritti.png"
plot "tcp_no_diritti_port.txt"
