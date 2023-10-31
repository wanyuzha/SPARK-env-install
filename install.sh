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

# Source .bashrc to update the current session
echo "Sourcing .bashrc to update the current session..."
source $HOME/.bashrc

./hadoop-configuration.sh $NUM_SLAVES

# Use this command only once
hostname=$(hostname)

# if it is the master node
if [[ $hostname == *"rcnfs"* ]]; then
  echo "This is the master node"
  hdfs namenode -format
fi

# Install Spark later on
./spark-install.sh 

./spark-configuration.sh 3

# Make dir for spark logs
if [[ $hostname == *"rcnfs"* ]]; then
  echo "Make dir for spark logs"
  hadoop fs -mkdir /sparklog
  hadoop fs -chmod 777 /sparklog
fi
