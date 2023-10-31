#!/bin/bash

# Define the Hadoop version and installation directory
HADOOP_VERSION="3.3.6"
INSTALL_DIR="$HOME/hadoop"

# Download Hadoop
echo "Downloading Hadoop $HADOOP_VERSION..."
wget -q https://dlcdn.apache.org/hadoop/common/hadoop-$HADOOP_VERSION/hadoop-$HADOOP_VERSION.tar.gz

# Extract Hadoop
echo "Extracting Hadoop..."
tar -zxf hadoop-$HADOOP_VERSION.tar.gz

# Move Hadoop to the installation directory
echo "Moving Hadoop to $INSTALL_DIR..."
mv hadoop-$HADOOP_VERSION $INSTALL_DIR

# Clean up the downloaded tar.gz file
rm hadoop-$HADOOP_VERSION.tar.gz

# Add Hadoop to PATH in .bashrc
echo "Adding Hadoop to PATH in .bashrc..."
echo "export PATH=\$PATH:$INSTALL_DIR/bin:$INSTALL_DIR/sbin" >> $HOME/.bashrc

echo "Hadoop $HADOOP_VERSION installation and configuration completed!"
