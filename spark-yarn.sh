# Set your Spark installation path
SPARK_HOME="$HOME/spark"

$SPARK_HOME/bin/spark-submit \
--master yarn \
--num-executors 25 \
--executor-cores 4 \
--executor-memory 4g \
wiki_Q1.py