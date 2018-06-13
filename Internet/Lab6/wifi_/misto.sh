#!/bin/bash

nttcp -T -u 192.168.2.100 > misto_h2.dat & nttcp -T -r 192.168.2.100 > misto_h1.dat
