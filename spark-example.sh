# Set your Spark installation path
SPARK_HOME="$HOME/spark"

$SPARK_HOME/bin/spark-submit \
--class org.apache.spark.examples.SparkPi   \
--master spark://rcnfs:7077   \
--driver-memory 512M \
--executor-memory 512M \
--total-executor-cores 1 \
$SPARK_HOME/examples/jars/spark-examples_2.12-3.3.4.jar \
10	