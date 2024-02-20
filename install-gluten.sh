#!/bin/bash

# Dependencies 
sudo apt-get install -y libre2-dev maven curl zip unzip tar pkg-config autoconf bison libtool flex autoconf-archive

# Set JAVA PATH
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
export PATH=$JAVA_HOME/bin:$PATH

cd ..

# Clone Gluten
git clone https://github.com/oap-project/gluten.git

# Enter Gluten and build
cd gluten
sudo ./dev/buildbundle-veloxbe.sh --enable_hdfs=ON
