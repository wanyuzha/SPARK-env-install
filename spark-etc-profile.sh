#!/bin/bash

# Check if an input argument is provided
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 'Environment variable string'"
    exit 1
fi

# Get the input argument
USER_DIR="$1"

# Check if the script is run as root
if [ "$(id -u)" != "0" ]; then
   echo "This script needs to be run as root" 1>&2
   exit 1
fi

# Add environment variables to /etc/profile
echo "Modifying /etc/profile..."

echo "# JAVA_HOME" >> /etc/profile
echo "export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64/" >> /etc/profile
echo "# HADOOP_HOME" >> /etc/profile
echo "export HADOOP_HOME=$USER_DIR/hadoop" >> /etc/profile
echo "# SPARK_HOME" >> /etc/profile
echo "export SPARK_HOME=$USER_DIR/spark" >> /etc/profile
echo "# HADOOP_CONF_DIR" >> /etc/profile
echo "export HADOOP_CONF_DIR=$USER_DIR/hadoop/etc/hadoop" >> /etc/profile

echo "/etc/profile has been modified."

# Prompt user to re-login or source /etc/profile to apply changes
echo "Please log out and log back in, or run 'source /etc/profile' to make the environment variable changes take effect immediately."
