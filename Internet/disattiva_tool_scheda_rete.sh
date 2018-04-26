#!/bin/bash

sudo ethtool -K ens9 rx off tx off sg off tso off gso off gro off
