set title "TCP Port Scan [sudo]"
set xlabel "Tempo [s]"
set ylabel "Port"
set grid
set terminal png
set output "tcp_sudo.png"
plot "tcp_sudo_port.txt"
