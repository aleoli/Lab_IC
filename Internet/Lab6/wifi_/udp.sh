#!/bin/bash

nttcp -T -u 192.168.2.100 > udp_h2.dat & nttcp -T -u -r 192.168.2.100 > udp_h1.dat
