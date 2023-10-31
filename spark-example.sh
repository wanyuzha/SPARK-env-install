SPARK_HOME="$HOME/spark"

$SPARK_HOME/sbin/start-all.sh

$SPARK_HOME/bin/spark-submit \
--class org.apache.spark.examples.SparkPi   \
--master spark://rcnfs:7077   \
--driver-memory 512M \
--executor-memory 512M \
--total-executor-cores 1 \
$SPARK_HOME/examples/jars/spark-examples_2.12-3.5.0.jar \
10	