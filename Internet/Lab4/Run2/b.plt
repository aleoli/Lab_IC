set title "sudo nmap IP_ADDRESS –p 1-100 -sU"
set xlabel "Tempo [s]"
set ylabel "Port"
set grid
set terminal png
set output "4_b.png"
plot "4_b_port.txt"
