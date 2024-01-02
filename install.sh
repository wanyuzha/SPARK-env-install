#!/bin/bash -i

# Check if a number is provided as an argument
if [ "$#" -ne 1 ]; then
  echo "Usage: $0 <number-of-slave-nodes>"
  exit 1
fi

# Number of slave nodes
NUM_SLAVES=$1

./hadoop-install.sh 

./java-install.sh 

# Source .bashrc to update the current session
echo "Sourcing .bashrc to update the current session..."
source $HOME/.bashrc

./hadoop-configuration.sh $NUM_SLAVES

# Install Spark later on
./spark-install.sh 

./spark-configuration.sh $NUM_SLAVES

./parallel-install $NUM_SLAVES