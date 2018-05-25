set title "UDP Port Scan [sudo]"
set xlabel "Tempo [s]"
set ylabel "Port"
set grid
set terminal png
set output "udp_sudo.png"
plot "udp_sudo_port.txt"
