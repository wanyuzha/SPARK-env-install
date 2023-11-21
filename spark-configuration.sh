#!/bin/bash

# Check if a number is provided as an argument
if [ "$#" -ne 1 ]; then
  echo "Usage: $0 <number-of-slave-nodes>"
  exit 1
fi

# Number of slave nodes
NUM_SLAVES=$1

# Set your Spark installation path
SPARK_HOME="$HOME/spark"

# Set your Hadoop NameNode host
HADOOP_NAMENODE_HOST="rcnfs"

# copy spark start-all.sh and stop-all.sh and add it to path
cp $SPARK_HOME/sbin/start-all.sh $SPARK_HOME/sbin/spark-start-all.sh 
cp $SPARK_HOME/sbin/stop-all.sh $SPARK_HOME/sbin/spark-stop-all.sh 
echo "export PATH=\$PATH:$SPARK_HOME/sbin" >> $HOME/.bashrc

# copy log4j2.properties
mv $SPARK_HOME/conf/log4j2.properties.template $SPARK_HOME/conf/log4j2.properties

# Configure workers
WORKERS_FILE="$SPARK_HOME/conf/workers"
echo "Configuring $WORKERS_FILE"
echo "rcnfs" > "$WORKERS_FILE"
for i in $(seq 2 $((NUM_SLAVES))); do
  printf "rc%02d\n" $((i - 1))  >> "$WORKERS_FILE"
done
echo "Workers configured."

# Configure spark-defaults.conf
DEFAULTS_FILE="$SPARK_HOME/conf/spark-defaults.conf"
echo "Configuring $DEFAULTS_FILE"
cat > "$DEFAULTS_FILE" <<EOL
spark.eventLog.enabled true
spark.eventLog.dir hdfs://rcnfs:8020/sparklog/
spark.eventLog.compress true
EOL

# Configure spark-env.sh
SPARK_ENV_FILE="$SPARK_HOME/conf/spark-env.sh"
echo "Configuring $SPARK_ENV_FILE"
cat > "$SPARK_ENV_FILE" <<EOL

# Export JAVA_HOME
export JAVA_HOME=$JAVA_HOME

# Export HADOOP CONF
export HADOOP_CONF_DIR=$HOME/hadoop/etc/hadoop

# Export YARN CONF
export YARN_CONF_DIR=$HOME/hadoop/etc/hadoop

# Spark Jars classpath
export SPARK_DIST_CLASSPATH=$($HOME/hadoop/bin/hadoop classpath)

# Spark master host
export SPARK_MASTER_HOST=rcnfs

# Spark master port
export SPARK_MASTER_PORT=7077

# WebUI port
export SPARK_MASTER_WEBUI_PORT=8080

# Worker CPU cores
export SPARK_WORKER_CORES=1

# Worker memory
export SPARK_WORKER_MEMORY=4g

# Worker port
export SPARK_WORKER_PORT=7078

# Worker WebUI port
export SPARK_WORKER_WEBUI_PORT=8081

# Set history directory
export SPARK_HISTORY_OPTS="-Dspark.history.fs.logDirectory=hdfs://$HADOOP_NAMENODE_HOST:8020/sparklog/ -Dspark.history.fs.cleaner.enabled=true"
EOL
echo "Spark environment variables configured."

echo "Configuration complete."
