#!/bin/bash

sed "s/^/ /g" tcp_no_diritti.txt > tcp_no_diritti.tmp
sed "s/^/ /g" tcp_sudo.txt > tcp_sudo.tmp
sed "s/^/ /g" udp_sudo.txt > udp_sudo.tmp

cat tcp_no_diritti.tmp | grep -v Source | tr -s ' ' | cut -d ' ' -f 3 > time_tcp_no_diritti.tmp
cat tcp_no_diritti.tmp | grep -v Source | tr -s ' ' | cut -d ' ' -f 10 > port_tcp_no_diritti.tmp

cat tcp_sudo.tmp | grep -v Source | tr -s ' ' | cut -d ' ' -f 3 > time_tcp_sudo.tmp
cat tcp_sudo.tmp | grep -v Source | tr -s ' ' | cut -d ' ' -f 10 > port_tcp_sudo.tmp

cat udp_sudo.tmp | grep -v Source | tr -s ' ' | cut -d ' ' -f 3 > time_udp_sudo.tmp
cat udp_sudo.tmp | grep -v Source | tr -s ' ' | cut -d ' ' -f 10 > port_udp_sudo.tmp

paste time_tcp_no_diritti.tmp port_tcp_no_diritti.tmp > tcp_no_diritti_port.txt
paste time_tcp_sudo.tmp port_tcp_sudo.tmp > tcp_sudo_port.txt
paste time_udp_sudo.tmp port_udp_sudo.tmp > udp_sudo_port.txt

rm -rf *.tmp

gnuplot tcp_no_diritti.plt
gnuplot tcp_sudo.plt
gnuplot udp_sudo.plt
