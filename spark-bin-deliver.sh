#!/bin/bash

# Check if a number is provided as an argument
if [ "$#" -ne 1 ]; then
 echo "Usage: $0 <number-of-slave-nodes>"
 exit 1
fi

# Number of slave nodes
NUM_SLAVES=$1

#mv ~/spark/spark-3.4.4-SNAPSHOT-bin-custom-spark.tgz ~/spark-custom.tgz

for i in $(seq 2 $NUM_SLAVES); do
 node=$(printf "rc%02d" $((i - 1)))
 scp -r ~/spark-3.4.4-SNAPSHOT-bin-custom-spark.tgz $node:~/
done
