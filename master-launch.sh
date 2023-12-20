#!/bin/bash -i

# Source .bashrc to update the current session
echo "Sourcing .bashrc to update the current session..."
source $HOME/.bashrc

# Use this command only once
hostname=$(hostname)

# if it is the master node
if [[ $hostname == *"rcnfs"* ]]; then
  echo "This is the master node"
  hdfs namenode -format
fi

# start hadoop 
start-all.sh

# Make dir for spark logs
if [[ $hostname == *"rcnfs"* ]]; then
  echo "Make dir for spark logs"
  hadoop fs -mkdir /sparklog
  hadoop fs -chmod 777 /sparklog
fi

# start spark
spark-start-all.sh

# start history server
SPARK_HOME="$HOME/spark"

$SPARK_HOME/sbin/start-history-server.sh