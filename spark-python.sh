# Set your Spark installation path
SPARK_HOME="$HOME/spark"

$SPARK_HOME/bin/spark-submit \
--master spark://rcnfs:7077   \
--executor-memory 4g \
~/tpch/tpch_query/sf10/query9.py