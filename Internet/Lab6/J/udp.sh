#!/bin/bash

nttcp -T -u 10.0.0.2 > H1_H2_udp.txt & nttcp -T -u -r 10.0.0.2 > H2_H1_udp.txt & nttcp -T -u 10.0.0.3 > H1_H3_udp.txt & nttcp -T -u -r 10.0.0.3 > H3_H1_udp.txt
