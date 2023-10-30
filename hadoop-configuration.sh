#!/bin/bash

# Check if a number is provided as an argument
if [ "$#" -ne 1 ]; then
  echo "Usage: $0 <number-of-slave-nodes>"
  exit 1
fi

# Number of slave nodes
NUM_SLAVES=$1

# Path to Hadoop etc directory
HADOOP_ETC_DIR="$HOME/hadoop/etc/hadoop"

HADOOP_INSTALL_DIR="$HOME/hadoop"

echo "JAVA HOME is $JAVA_HOME"

# Set JAVA_HOME in hadoop-env.sh
echo "export JAVA_HOME=$JAVA_HOME" >> "$HADOOP_ETC_DIR/hadoop-env.sh"

# Set workers
echo "rcnfs" > "$HADOOP_ETC_DIR/workers"
for i in $(seq 2 $((NUM_SLAVES))); do
  printf "rc%02d\n" $((i - 1))  >> "$HADOOP_ETC_DIR/workers"
done

# Configure core-site.xml
cat <<EOL > "$HADOOP_ETC_DIR/core-site.xml"
<configuration>
	<property>
		<name>fs.defaultFS</name>
    	<value>hdfs://rcnfs:8020</value>
	</property>
	<property>
		 <name>hadoop.tmp.dir</name>						    
		 <value>file:$HADOOP_INSTALL_DIR/tmp</value>
		 <description>A base for other temporary directories.</description>
	</property>
</configuration>
EOL

# Configure hdfs-site.xml
cat <<EOL > "$HADOOP_ETC_DIR/hdfs-site.xml"
<configuration>
  <property>
    <name>dfs.namenode.secondary.http-address</name>
    <value>rcnfs:50090</value>
  </property>
  <property>
    <name>dfs.replication</name>
    <value>3</value>
  </property>
  <property>
    <name>dfs.namenode.name.dir</name>
    <value>file:$HADOOP_INSTALL_DIR/tmp/dfs/name</value>
  </property>
  <property>
    <name>dfs.datanode.data.dir</name>
    <value>file:$HADOOP_INSTALL_DIR/tmp/dfs/data</value>
  </property>
</configuration>
EOL

# Configure mapred-site.xml
cat <<EOL > "$HADOOP_ETC_DIR/mapred-site.xml"
<configuration>
  <property>
    <name>mapreduce.framework.name</name>
    <value>yarn</value>
  </property>
  <property>
    <name>mapreduce.jobhistory.address</name>
    <value>rcnfs:10020</value>
  </property>
  <property>
    <name>mapreduce.jobhistory.webapp.address</name>
    <value>rcnfs:19888</value>
  </property>
  <property>
    <name>yarn.app.mapreduce.am.env</name>
    <value>HADOOP_MAPRED_HOME=$HADOOP_INSTALL_DIR</value>
  </property>
  <property>
    <name>mapreduce.map.env</name>
    <value>HADOOP_MAPRED_HOME=$HADOOP_INSTALL_DIR</value>
  </property>
  <property>
    <name>mapreduce.reduce.env</name>
    <value>HADOOP_MAPRED_HOME=$HADOOP_INSTALL_DIR</value>
  </property>
</configuration>
EOL

# Configure yarn-site.xml
cat <<EOL > "$HADOOP_ETC_DIR/yarn-site.xml"
<configuration>
  <property>
    <name>yarn.resourcemanager.hostname</name>
    <value>rcnfs</value>
  </property>
  <property>
    <name>yarn.nodemanager.aux-services</name>
    <value>mapreduce_shuffle</value>
  </property>
</configuration>
EOL

echo "Hadoop configuration is completed!"
