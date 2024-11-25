# Export HADOOP CONF
export HADOOP_CONF_DIR=/users/Wanyu/hadoop/etc/hadoop

# Export YARN CONF
export YARN_CONF_DIR=/users/Wanyu/hadoop/etc/hadoop

spark-shell --name run_gluten \
 --master yarn --deploy-mode client \
 --conf spark.plugins=io.glutenproject.GlutenPlugin \
 --conf spark.memory.offHeap.enabled=true \
 --conf spark.memory.offHeap.size=20g \
 --jars /users/Wanyu/gluten-velox-bundle-spark3.4_2.12-1.1.0.jar 