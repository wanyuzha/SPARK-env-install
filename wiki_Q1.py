'''
  Copyright 2023 Google LLC

  Licensed under the Apache License, Version 2.0 (the "License");
  you may not use this file except in compliance with the License.
  You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License.
 '''

#!/usr/bin/env python
# coding: utf-8

from pyspark.sql import SparkSession
import pyspark
from pyspark.ml.classification import MultilayerPerceptronClassifier
from pyspark.ml.evaluation import MulticlassClassificationEvaluator
from pyspark.sql.functions import *
from pyspark.ml.feature import VectorAssembler, StringIndexer
from pyspark.mllib.evaluation import MulticlassMetrics
from pyspark.sql.types import FloatType
import sys
import pyspark.sql.functions as F

#Building a Spark session to be able to perform read/write operations to and from BigQuery
spark = SparkSession.builder.appName("Wiki1B").getOrCreate()


df = spark.read.parquet("hdfs://rcnfs:8020/wiki/1B/")

#df.printSchema()

#df.show()

#print("Number of partitions before:", df.rdd.getNumPartitions())

#df = df.repartition(1200)

#print("Number of partitions after:", df.rdd.getNumPartitions())

#df.show(5)
#df.printSchema()
df.createOrReplaceTempView("Wiki1B")

result = spark.sql("""SELECT language, SUM(views)
FROM Wiki1B
GROUP BY language""")

result.show()

print('Job Completed Successfully!')
