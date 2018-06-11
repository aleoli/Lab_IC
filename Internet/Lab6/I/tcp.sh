#!/bin/bash

nttcp -T 10.0.0.2 > H1_H2_tcp.txt & nttcp -T -r 10.0.0.2 > H2_H1_tcp.txt & nttcp -T 10.0.0.3 > H1_H3_tcp.txt & nttcp -T -r 10.0.0.3 > H3_H1_tcp.txt
