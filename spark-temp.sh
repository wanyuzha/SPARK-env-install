# Use this command only once
hostname=$(hostname)

# if it is the master node
if [[ $hostname == *"rcnfs"* ]]; then
  echo "This is the master node"
  hdfs namenode -format
fi

start-all.sh

# Make dir for spark logs
if [[ $hostname == *"rcnfs"* ]]; then
  echo "Make dir for spark logs"
  hadoop fs -mkdir /sparklog
  hadoop fs -chmod 777 /sparklog
fi