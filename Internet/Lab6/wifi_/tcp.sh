#!/bin/bash

nttcp -T 192.168.2.100 > tcp_h2.dat & nttcp -T -r 192.168.2.100 > tcp_h1.dat
