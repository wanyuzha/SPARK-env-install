#!/bin/bash

# Check if a number is provided as an argument
if [ "$#" -ne 1 ]; then
  echo "Usage: $0 <number-of-slave-nodes>"
  exit 1
fi

# Number of slave nodes
NUM_SLAVES=$1

./hadoop-install.sh 

./java-install.sh 

./hadoop-configuration.sh $NUM_SLAVES