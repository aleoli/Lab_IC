#!/bin/bash

nttcp -T 10.0.0.2 > tcp_h2.dat & nttcp -T -r 10.0.0.2 > tcp_h1.dat
