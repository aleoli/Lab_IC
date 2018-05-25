set title "sudo nmap IP_ADDRESS –p 1-100"
set xlabel "Tempo [s]"
set ylabel "Port"
set grid
set terminal png
set output "4.png"
plot "4_port.txt"
