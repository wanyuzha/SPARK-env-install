# Set your Spark installation path
SPARK_HOME="$HOME/spark"

$SPARK_HOME/bin/spark-submit \
--class org.apache.spark.examples.SparkPi   \
--master spark://rcnfs:7077   \
--driver-memory 512M \
--executor-memory 512M \
--total-executor-cores 1 \
--conf spark.executor.extraJavaOptions=-agentlib:jdwp=transport=dt_socket,server=y,suspend=y,address=8008 \
$SPARK_HOME/examples/jars/spark-examples_2.12-3.4.3.jar \
10	