# Set your Spark installation path
SPARK_HOME="$HOME/spark"
GLUTEN_JAR="/users/Wanyu/gluten/package/target/gluten-velox-bundle-spark3.4_3.12-ubuntu_22.04_x86_64-1.2.0-SNAPSHOT.jar"

$SPARK_HOME/bin/spark-submit \
  --master spark://rcnfs:7077   \
  --conf spark.plugins=io.glutenproject.GlutenPlugin \
  --conf spark.driver.extraClassPath=${GLUTEN_JAR} \
  --conf spark.executor.extraClassPath=${GLUTEN_JAR} \
  --conf spark.memory.offHeap.enabled=true \
  --conf spark.memory.offHeap.size=2g \
  --executor-memory 4g \
  --conf spark.executor.memoryOverhead=2g \
  --conf spark.driver.maxResultSize=2g \
  ~/tpch/tpch_query/sf100/query9.py