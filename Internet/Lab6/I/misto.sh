#!/bin/bash

nttcp -T -u 10.0.0.2 > H1_H2_misto.txt & nttcp -T -r -u 10.0.0.2 > H2_H1_misto.txt & nttcp -T 10.0.0.3 > H1_H3_misto.txt & nttcp -T -r 10.0.0.3 > H3_H1_misto.txt
