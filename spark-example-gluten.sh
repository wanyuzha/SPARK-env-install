GLUTEN_JAR="/users/Wanyu/gluten/package/target/gluten-velox-bundle-spark3.4_2.12-ubuntu_22.04-1.2.0-SNAPSHOT.jar"

# Set your Spark installation path
SPARK_HOME="$HOME/spark"

$SPARK_HOME/bin/spark-submit \
--class org.apache.spark.examples.SparkPi   \
--master spark://rcnfs:7077   \
--conf spark.plugins=io.glutenproject.GlutenPlugin \
--conf spark.driver.extraClassPath=$GLUTEN_JAR \
--conf spark.executor.extraClassPath=$GLUTEN_JAR \
--conf spark.memory.offHeap.enabled=true \
--conf spark.memory.offHeap.size=512M \
--driver-memory 512M \
--executor-memory 512M \
--total-executor-cores 1 \
$SPARK_HOME/examples/jars/spark-examples_2.12-3.4.2.jar \
10	