# Set your Spark installation path
SPARK_HOME="$HOME/spark"

$SPARK_HOME/bin/spark-submit \
--master yarn \
--num-executors 50 \
--executor-cores 4 \
--executor-memory 4g \
--conf spark.executor.extraJavaOptions=-agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=8008 \
wiki_Q1.py