# Set your Spark installation path
SPARK_HOME="$HOME/spark"

for i in {1}; do
    $SPARK_HOME/bin/spark-submit \
    --name "wiki$i" \
    --master spark://rcnfs:7077   \
    --conf "spark.executor.extraJavaOptions=-agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=localhost:5005" \
    --executor-memory 4g \
    wiki_Q1.py
done