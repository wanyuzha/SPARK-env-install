#!/bin/bash
set -e

# Check if a number is provided as an argument
if [ "$#" -ne 1 ]; then
 echo "Usage: $0 <number-of-slave-nodes>"
 exit 1
fi

# Number of slave nodes
NUM_SLAVES=$1

sudo ./ssh-distribute.sh $NUM_SLAVES

./install-local.sh $NUM_SLAVES

./parallel-install.sh $NUM_SLAVES

cd ~

git clone https://github.com/wanyuzha/tpch.git