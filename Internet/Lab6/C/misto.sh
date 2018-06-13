#!/bin/bash

nttcp -T -u 10.0.0.2 > misto_h2.dat & nttcp -T -r 10.0.0.2 > misto_h1.dat
