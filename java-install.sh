#!/bin/bash

# Update the package list of the system
sudo apt-get update

# Install OpenJDK 11
sudo apt-get install -y openjdk-11-jdk

# Set the JAVA_HOME environment variable
export JAVA_HOME=$(readlink -f /usr/bin/java | sed "s:bin/java::")

# Add JAVA_HOME environment variable to bashrc file, so it will be set on every login
echo "export JAVA_HOME=$JAVA_HOME" >> ~/.bashrc
echo 'export PATH=$PATH:$JAVA_HOME/bin' >> ~/.bashrc

# Print the value of JAVA_HOME variable to confirm if it is set successfully
echo "JAVA_HOME is set to $JAVA_HOME"
