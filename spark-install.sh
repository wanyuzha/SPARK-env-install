#!/bin/bash

# Step 1: Install Scala
echo "Installing Scala..."
sudo apt update
sudo apt install -y scala

# Check if Scala is installed successfully
if ! command -v scala &> /dev/null
then
  echo "Scala installation failed."
  exit 1
fi
echo "Scala has been installed successfully."

# Step 2: Install PySpark
sudo apt install -y python3 python3-pip
pip3 install pyspark
pip3 install pandas
pip3 install pyarrow

# Step 3: Download and Unzip Spark
INSTALL_DIR="$HOME/spark"

echo "Unzipping Spark..."
tar -xzf spark-3.4.4-SNAPSHOT-bin-custom-spark.tgz
rm spark-3.4.4-SNAPSHOT-bin-custom-spark.tgz
mv spark-3.4.4-SNAPSHOT-bin-custom-spark $INSTALL_DIR

echo "Spark has been downloaded and unzipped."
