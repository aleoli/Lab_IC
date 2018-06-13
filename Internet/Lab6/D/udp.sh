#!/bin/bash

nttcp -T -u 10.0.0.2 > udp_h2.dat & nttcp -T -u -r 10.0.0.2 > udp_h1.dat
