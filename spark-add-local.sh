#!/bin/bash

# Check if a number is provided as an argument
if [ "$#" -ne 1 ]; then
 echo "Usage: $0 <number-of-slave-nodes>"
 exit 1
fi

# Number of slave nodes
NUM_SLAVES=$1

echo 'export SPARK_LOCAL_IP=rcnfs' >> ~/spark/conf/spark-env.sh

for i in $(seq 2 $NUM_SLAVES); do
 node=$(printf "rc%02d" $((i - 1)))
 ssh $node "echo 'export SPARK_LOCAL_IP=$node' >> ~/spark/conf/spark-env.sh"
done
