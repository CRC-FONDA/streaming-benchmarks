#!/bin/bash
# Copyright 2015, Yahoo Inc.
# Licensed under the terms of the Apache License 2.0. Please see LICENSE file in the project root for terms.
set -o pipefail
set -o errtrace
set -o nounset
set -o errexit

LEIN=${LEIN:-lein}
MVN=${MVN:-mvn}
GIT=${GIT:-git}
MAKE=${MAKE:-make}
MVN_REPO=${REPO:-"https://repo.maven.apache.org/maven2"}

BEAM_VERSION=${BEAM_VERSION:-"2.22.0"}
KAFKA_VERSION=${KAFKA_VERSION:-"2.4.1"}
REDIS_VERSION=${REDIS_VERSION:-"6.0.5"}
SCALA_BIN_VERSION=${SCALA_BIN_VERSION:-"2.12"}
SCALA_SUB_VERSION=${SCALA_SUB_VERSION:-"11"}
STORM_VERSION=${STORM_VERSION:-"2.2.0"}
FLINK_VERSION=${FLINK_VERSION:-"1.11.0"}
SPARK_VERSION=${SPARK_VERSION:-"3.0.0"}
HADOOP_FLINK_BUNDLE_VERSION=${HADOOP_VERSION:-"2.8.3-0.10"}

STORM_DIR=${STORM_DIR:-"apache-storm-$STORM_VERSION"}
REDIS_DIR=${REDIS_DIR:-"redis-$REDIS_VERSION"}
KAFKA_DIR=${KAFKA_DIR:-"kafka_$SCALA_BIN_VERSION-$KAFKA_VERSION"}
FLINK_DIR=${FLINK_DIR:-"flink-$FLINK_VERSION"}
SPARK_DIR=${SPARK_DIR:-"spark-$SPARK_VERSION-bin-hadoop2.7"}
ROOT=${ROOT:-"."}

#Get one of the closet apache mirrors
APACHE_MIRROR=$"https://archive.apache.org/dist"

ZK_HOST="localhost"
ZK_PORT="2181"
ZK_CONNECTIONS="$ZK_HOST:$ZK_PORT"
TOPIC=${TOPIC:-"ad-events"}
PARTITIONS=${PARTITIONS:-1}
LOAD=${LOAD:-1000}
CONF_FILE=./conf/localConf.yaml
TEST_TIME=${TEST_TIME:-240}

pid_match() {
   local VAL=`ps -aef | grep "$1" | grep -v grep | awk '{print $2}'`
   echo $VAL
}

start_if_needed() {
  local match="$1"
  shift
  local name="$1"
  shift
  local sleep_time="$1"
  shift
  local PID=`pid_match "$match"`

  if [[ "$PID" -ne "" ]];
  then
    echo "$name is already running..."
  else
    "$@" &
    sleep $sleep_time
  fi
}

stop_if_needed() {
  local match="$1"
  local name="$2"
  local PID=`pid_match "$match"`
  if [[ "$PID" -ne "" ]];
  then
    kill "$PID"
    sleep 1
    local CHECK_AGAIN=`pid_match "$match"`
    if [[ "$CHECK_AGAIN" -ne "" ]];
    then
      kill -9 "$CHECK_AGAIN"
    fi
  else
    echo "No $name instance found to stop"
  fi
}

fetch_untar_file() {
  local FILE="download-cache/$1"
  local URL=$2
  if [[ -e "$FILE" ]];
  then
    echo "Using cached File $FILE"
  else
	mkdir -p download-cache/
    WGET=`whereis wget`
    CURL=`whereis curl`
    if [ -n "$WGET" ];
    then
      wget -O "$FILE" "$URL"
    elif [ -n "$CURL" ];
    then
      curl -o "$FILE" "$URL"
    else
      echo "Please install curl or wget to continue.";
      exit 1
    fi
  fi
  tar -xzvf "$FILE"
}

create_kafka_topic() {
    local count=`$KAFKA_DIR/bin/kafka-topics.sh --describe --zookeeper "$ZK_CONNECTIONS" --topic $TOPIC 2>/dev/null | grep -c $TOPIC`
    if [[ "$count" = "0" ]];
    then
        $KAFKA_DIR/bin/kafka-topics.sh --create --zookeeper "$ZK_CONNECTIONS" --replication-factor 1 --partitions $PARTITIONS --topic $TOPIC
    else
        echo "Kafka topic $TOPIC already exists"
    fi
}

run() {
  OPERATION=$1
  if [ "SETUP" = "$OPERATION" ];
  then
    $GIT clean -fd

    echo 'kafka.brokers:' > $CONF_FILE
    echo '    - "localhost"' >> $CONF_FILE
    echo >> $CONF_FILE
    echo 'zookeeper.servers:' >> $CONF_FILE
    echo '    - "'$ZK_HOST'"' >> $CONF_FILE
    echo >> $CONF_FILE
    echo 'kafka.port: 9092' >> $CONF_FILE
	echo 'zookeeper.port: '$ZK_PORT >> $CONF_FILE
	echo 'redis.host: "localhost"' >> $CONF_FILE
	echo 'kafka.topic: "'$TOPIC'"' >> $CONF_FILE
	echo 'kafka.partitions: '$PARTITIONS >> $CONF_FILE
	echo 'process.hosts: 1' >> $CONF_FILE
	echo 'process.cores: 1' >> $CONF_FILE
	echo 'storm.workers: 1' >> $CONF_FILE
	echo 'storm.ackers: 2' >> $CONF_FILE
	echo 'spark.batch.time: 2000' >> $CONF_FILE
	echo 'spark.continuous.time: 1000' >> $CONF_FILE

    echo "$MVN clean install -Dbeam.version="$BEAM_VERSION" -Dspark.version="$SPARK_VERSION" -Dkafka.version="$KAFKA_VERSION" -Dflink.version="$FLINK_VERSION" -Dstorm.version="$STORM_VERSION" -Dscala.binary.version="$SCALA_BIN_VERSION" -Dscala.version="$SCALA_BIN_VERSION.$SCALA_SUB_VERSION""
    $MVN clean install -Dbeam.version="$BEAM_VERSION" -Dspark.version="$SPARK_VERSION" -Dkafka.version="$KAFKA_VERSION" -Dflink.version="$FLINK_VERSION" -Dstorm.version="$STORM_VERSION" -Dscala.binary.version="$SCALA_BIN_VERSION" -Dscala.version="$SCALA_BIN_VERSION.$SCALA_SUB_VERSION"

    # Remove corrupted signature for beam
    zip -d ./apache-beam-validator/target/apache-beam-validator-0.1.0.jar META-INF/*.RSA META-INF/*.DSA META-INF/*.SF

    #Fetch and build Redis: mirror broken, for cluster test not required
    REDIS_FILE="$REDIS_DIR.tar.gz"
    fetch_untar_file "$REDIS_FILE" "http://download.redis.io/releases/$REDIS_FILE"

    cd $REDIS_DIR
    $MAKE
    cd ..

    #Fetch Kafka
    KAFKA_FILE="$KAFKA_DIR.tgz"
    fetch_untar_file "$KAFKA_FILE" "$APACHE_MIRROR/kafka/$KAFKA_VERSION/$KAFKA_FILE"

    #Fetch Storm
    STORM_FILE="$STORM_DIR.tar.gz"
    fetch_untar_file "$STORM_FILE" "$APACHE_MIRROR/storm/$STORM_DIR/$STORM_FILE"

    #Fetch Flink
    # FLINK_FILE="$FLINK_DIR-bin-hadoop27-scala_${SCALA_BIN_VERSION}.tgz"
    FLINK_FILE="$FLINK_DIR-bin-scala_${SCALA_BIN_VERSION}.tgz"
    fetch_untar_file "$FLINK_FILE" "$APACHE_MIRROR/flink/flink-$FLINK_VERSION/$FLINK_FILE"
    # TODO: Flink on yarn setup requires pre-bundled hadoop jars
    # UBER_REF="flink-shaded-hadoop-2-uber"
    # curl -O "$MVN_REPO/org/apache/flink/$UBER_REF/$HADOOP_FLINK_BUNDLE_VERSION/$UBER_REF-$HADOOP_FLINK_BUNDLE_VERSION.jar"
    # mv "$UBER_REF-$HADOOP_FLINK_BUNDLE_VERSION.jar" "flink-$FLINK_VERSION/lib"

    #Fetch Spark
    SPARK_FILE="$SPARK_DIR.tgz"
    fetch_untar_file "$SPARK_FILE" "$APACHE_MIRROR/spark/spark-$SPARK_VERSION/$SPARK_FILE"

  elif [ "START_ZK" = "$OPERATION" ];
  then
    start_if_needed dev_zookeeper ZooKeeper 10 "$STORM_DIR/bin/storm" dev-zookeeper
  elif [ "STOP_ZK" = "$OPERATION" ];
  then
    stop_if_needed dev_zookeeper ZooKeeper
    rm -rf /tmp/dev-storm-zookeeper
    # For remote quorum setup
    stop_if_needed org\.apache\.zookeeper\.server\.quorum\.QuorumPeerMain Zookeeper
    rm -rf /tmp/zookeeper
  elif [ "START_REDIS" = "$OPERATION" ];
  then
    start_if_needed redis-server Redis 1 "$REDIS_DIR/src/redis-server"
    cd $ROOT/data
    $LEIN run -n --configPath ../conf/benchmarkConf.yaml
    cd ..
  elif [ "STOP_REDIS" = "$OPERATION" ];
  then
    stop_if_needed redis-server Redis
    rm -f dump.rdb
  elif [ "START_STORM" = "$OPERATION" ];
  then
    start_if_needed daemon.name=nimbus "Storm Nimbus" 3 "$STORM_DIR/bin/storm" nimbus
    start_if_needed daemon.name=supervisor "Storm Supervisor" 3 "$STORM_DIR/bin/storm" supervisor
    start_if_needed daemon.name=ui "Storm UI" 3 "$STORM_DIR/bin/storm" ui
    start_if_needed daemon.name=logviewer "Storm LogViewer" 3 "$STORM_DIR/bin/storm" logviewer
    sleep 20
  elif [ "STOP_STORM" = "$OPERATION" ];
  then
    stop_if_needed daemon.name=nimbus "Storm Nimbus"
    stop_if_needed daemon.name=supervisor "Storm Supervisor"
    stop_if_needed daemon.name=ui "Storm UI"
    stop_if_needed daemon.name=logviewer "Storm LogViewer"
  elif [ "START_KAFKA" = "$OPERATION" ];
  then
    start_if_needed kafka\.Kafka Kafka 10 "$KAFKA_DIR/bin/kafka-server-start.sh" "$KAFKA_DIR/config/server.properties"
    create_kafka_topic
  elif [ "STOP_KAFKA" = "$OPERATION" ];
  then
    stop_if_needed kafka\.Kafka Kafka
    rm -rf /tmp/kafka-logs/
  elif [ "START_FLINK" = "$OPERATION" ];
  then
    start_if_needed org.apache.flink.runtime.jobmanager.JobManager Flink 1 $FLINK_DIR/bin/start-cluster.sh
  elif [ "STOP_FLINK" = "$OPERATION" ];
  then
    $FLINK_DIR/bin/stop-cluster.sh
  elif [ "START_SPARK" = "$OPERATION" ];
  then
    start_if_needed org.apache.spark.deploy.master.Master SparkMaster 5 $SPARK_DIR/sbin/start-master.sh -h localhost -p 7077
    start_if_needed org.apache.spark.deploy.worker.Worker SparkSlave 5 $SPARK_DIR/sbin/start-slave.sh spark://localhost:7077
  elif [ "STOP_SPARK" = "$OPERATION" ];
  then
    stop_if_needed org.apache.spark.deploy.master.Master SparkMaster
    stop_if_needed org.apache.spark.deploy.worker.Worker SparkSlave
    sleep 3
  elif [ "START_LOAD" = "$OPERATION" ];
  then
    cd $ROOT/data
    start_if_needed leiningen.core.main "Load Generation" 1 $LEIN run -r -t $LOAD --configPath ../$CONF_FILE
    cd ..
  elif [ "STOP_LOAD" = "$OPERATION" ];
  then
    stop_if_needed leiningen.core.main "Load Generation"
    cd $ROOT/data
    $LEIN run -g --configPath ../$CONF_FILE || true
    cd ..
  elif [ "START_STORM_TOPOLOGY" = "$OPERATION" ];
  then
    "$STORM_DIR/bin/storm" jar ./storm-benchmarks/target/storm-benchmarks-0.1.0.jar storm.benchmark.AdvertisingTopology test-topo -conf $CONF_FILE
    sleep 15
  elif [ "STOP_STORM_TOPOLOGY" = "$OPERATION" ];
  then
    "$STORM_DIR/bin/storm" kill -w 0 test-topo || true
    sleep 10
  elif [ "START_TRIDENT_STORM_TOPOLOGY" = "$OPERATION" ];
  then
    "$STORM_DIR/bin/storm" jar ./storm-benchmarks/target/storm-benchmarks-0.1.0.jar storm.benchmark.AdvertisingTridentTopology test-trident-topo -conf $CONF_FILE
    sleep 15
  elif [ "STOP_TRIDENT_STORM_TOPOLOGY" = "$OPERATION" ];
  then
    "$STORM_DIR/bin/storm" kill -w 0 test-trident-topo || true
    sleep 10

  elif [ "START_BEAM_SS_SPARK_PROCESSING" = "$OPERATION" ];
  then
    "$SPARK_DIR/bin/spark-submit" --master spark://localhost:7077 --class apache.beam.AdvertisingBeamStream ./apache-beam-validator/target/apache-beam-validator-0.1.0.jar --runner=SparkStructuredStreamingRunner --conf="$CONF_FILE" &
    sleep 5
  elif [ "STOP_BEAM_SS_SPARK_PROCESSING" = "$OPERATION" ];
  then
    stop_if_needed apache.beam.AdvertisingBeamStream "Apache Beam Spark Process"
  elif [ "START_BEAM_SPARK_PROCESSING" = "$OPERATION" ];
  then
    "$SPARK_DIR/bin/spark-submit" --master spark://localhost:7077 --class apache.beam.AdvertisingBeamStream ./apache-beam-validator/target/apache-beam-validator-0.1.0.jar --runner=SparkRunner --beamConf="$CONF_FILE" &
    sleep 5
  elif [ "STOP_BEAM_SPARK_PROCESSING" = "$OPERATION" ];
  then
    stop_if_needed apache.beam.AdvertisingBeamStream "Apache Beam Spark Process"
  elif [ "START_BEAM_FLINK_PROCESSING" = "$OPERATION" ];
  then
    "$FLINK_DIR/bin/flink" run -c apache.beam.AdvertisingBeamStream ./apache-beam-validator/target/apache-beam-validator-0.1.0.jar --runner=FlinkRunner --streaming --beamConf=$CONF_FILE &
    sleep 5
  elif [ "STOP_BEAM_FLINK_PROCESSING" = "$OPERATION" ];
  then
    stop_if_needed apache.beam.AdvertisingBeamStream "Apache Beam Flink Process"
  elif [ "START_DSTREAM_SPARK_PROCESSING" = "$OPERATION" ];
  then
    "$SPARK_DIR/bin/spark-submit" --master spark://localhost:7077 --class spark.benchmark.dstream.KafkaRedisDStreamAdvertisingStream ./spark-dstream-benchmarks/target/spark-dstream-benchmarks-0.1.0.jar "$CONF_FILE" &
    sleep 5
  elif [ "STOP_DSTREAM_SPARK_PROCESSING" = "$OPERATION" ];
  then
    stop_if_needed spark.benchmark.dstream.KafkaRedisDStreamAdvertisingStream "Spark Client Process"
  elif [ "START_SS_SPARK_PROCESSING" = "$OPERATION" ];
    then
      "$SPARK_DIR/bin/spark-submit" --packages org.apache.spark:spark-sql-kafka-0-10_2.12:$SPARK_VERSION --conf spark.executor.extraJavaOptions="-XX:+TraceClassLoading" --conf spark.driver.extraJavaOptions="-XX:+TraceClassLoading" --master spark://localhost:7077 --class spark.benchmark.structuredstreaming.KafkaRedisSSContinuousAdvertisingStream ./spark-ss-benchmarks/target/spark-ss-benchmarks-0.1.0.jar "$CONF_FILE" &
      #"$SPARK_DIR/bin/spark-submit" --packages org.apache.spark:spark-sql-kafka-0-10_2.12:$SPARK_VERSION --master spark://localhost:7077 --class spark.benchmark.structuredstreaming.KafkaRedisSSContinuousAdvertisingStream ./spark-ss-benchmarks/target/spark-ss-benchmarks-0.1.0.jar "$CONF_FILE" &
      sleep 5
  elif [ "STOP_SS_SPARK_PROCESSING" = "$OPERATION" ];
    then
      stop_if_needed spark.benchmark.structuredstreaming.KafkaRedisSSContinuousAdvertisingStream "Spark Client Process"
  elif [ "START_FLINK_PROCESSING" = "$OPERATION" ];
  then
    "$FLINK_DIR/bin/flink" run ./flink-benchmarks/target/flink-benchmarks-0.1.0.jar --confPath $CONF_FILE &
    sleep 3
  elif [ "STOP_FLINK_PROCESSING" = "$OPERATION" ];
  then
    FLINK_ID=`"$FLINK_DIR/bin/flink" list | grep 'Flink Streaming Job' | awk '{print $4}'; true`
    if [ "$FLINK_ID" == "" ];
	then
	  echo "Could not find streaming job to kill"
    else
      "$FLINK_DIR/bin/flink" cancel $FLINK_ID
      sleep 3
    fi
  elif [ "STORM_TEST" = "$OPERATION" ];
  then
    run "START_ZK"
    run "START_REDIS"
    run "START_KAFKA"
    run "START_STORM"
    run "START_STORM_TOPOLOGY"
    run "START_LOAD"
    sleep $TEST_TIME
    run "STOP_LOAD"
    run "STOP_STORM_TOPOLOGY"
    run "STOP_STORM"
    run "STOP_KAFKA"
    run "STOP_REDIS"
    run "STOP_ZK"
  elif [ "STORM_TRIDENT_TEST" = "$OPERATION" ];
  then
    run "START_ZK"
    run "START_REDIS"
    run "START_KAFKA"
    run "START_STORM"
    run "START_TRIDENT_STORM_TOPOLOGY"
    run "START_LOAD"
    sleep $TEST_TIME
    run "STOP_LOAD"
    run "STOP_TRIDENT_STORM_TOPOLOGY"
    run "STOP_STORM"
    run "STOP_KAFKA"
    run "STOP_REDIS"
    run "STOP_ZK"
  elif [ "FLINK_TEST" = "$OPERATION" ];
  then
    run "START_ZK"
    run "START_REDIS"
    run "START_KAFKA"
    run "START_FLINK"
    run "START_FLINK_PROCESSING"
    run "START_LOAD"
    sleep $TEST_TIME
    run "STOP_LOAD"
    run "STOP_FLINK_PROCESSING"
    run "STOP_FLINK"
    run "STOP_KAFKA"
    run "STOP_REDIS"
    run "STOP_ZK"
  elif [ "BEAM_SPARK_SS_TEST" = "$OPERATION" ];
  then
    run "START_ZK"
    run "START_REDIS"
    run "START_KAFKA"
    run "START_SPARK"
    run "START_BEAM_SS_SPARK_PROCESSING"
    run "START_LOAD"
    sleep $TEST_TIME
    run "STOP_LOAD"
    run "STOP_BEAM_SS_SPARK_PROCESSING"
    run "STOP_SPARK"
    run "STOP_KAFKA"
    run "STOP_REDIS"
    run "STOP_ZK"
  elif [ "BEAM_SPARK_TEST" = "$OPERATION" ];
  then
    run "START_ZK"
    run "START_REDIS"
    run "START_KAFKA"
    run "START_SPARK"
    run "START_BEAM_SPARK_PROCESSING"
    run "START_LOAD"
    sleep $TEST_TIME
    run "STOP_LOAD"
    run "STOP_BEAM_SPARK_PROCESSING"
    run "STOP_SPARK"
    run "STOP_KAFKA"
    run "STOP_REDIS"
    run "STOP_ZK"
  elif [ "BEAM_FLINK_TEST" = "$OPERATION" ];
  then
    run "START_ZK"
    run "START_REDIS"
    run "START_KAFKA"
    run "START_FLINK"
    run "START_BEAM_FLINK_PROCESSING"
    run "START_LOAD"
    sleep $TEST_TIME
    run "STOP_LOAD"
    run "STOP_BEAM_FLINK_PROCESSING"
    run "STOP_FLINK"
    run "STOP_KAFKA"
    run "STOP_REDIS"
    run "STOP_ZK"
  elif [ "SPARK_DSTREAM_TEST" = "$OPERATION" ];
  then
    run "START_ZK"
    run "START_REDIS"
    run "START_KAFKA"
    run "START_SPARK"
    run "START_DSTREAM_SPARK_PROCESSING"
    run "START_LOAD"
    sleep $TEST_TIME
    run "STOP_LOAD"
    run "STOP_DSTREAM_SPARK_PROCESSING"
    run "STOP_SPARK"
    run "STOP_KAFKA"
    run "STOP_REDIS"
    run "STOP_ZK"
  elif [ "SPARK_SS_TEST" = "$OPERATION" ];
    then
      run "START_ZK"
      run "START_REDIS"
      run "START_KAFKA"
      run "START_SPARK"
      run "START_SS_SPARK_PROCESSING"
      run "START_LOAD"
      sleep $TEST_TIME
      run "STOP_LOAD"
      run "STOP_SS_SPARK_PROCESSING"
      run "STOP_SPARK"
      run "STOP_KAFKA"
      run "STOP_REDIS"
      run "STOP_ZK"
  elif [ "STOP_ALL" = "$OPERATION" ];
  then
    run "STOP_LOAD"
    run "STOP_DSTREAM_SPARK_PROCESSING"
    run "STOP_SS_SPARK_PROCESSING"
    run "STOP_BEAM_SPARK_PROCESSING"
    run "STOP_BEAM_FLINK_PROCESSING"
    run "STOP_SPARK"
    run "STOP_FLINK_PROCESSING"
    run "STOP_FLINK"
    run "STOP_STORM_TOPOLOGY"
    run "STOP_STORM"
    run "STOP_KAFKA"
    run "STOP_REDIS"
    run "STOP_ZK"
  else
    if [ "HELP" != "$OPERATION" ];
    then
      echo "UNKOWN OPERATION '$OPERATION'"
      echo
    fi
    echo "Supported Operations:"
    echo "SETUP: download and setup dependencies for running a single node test. For BEAM_SPARK_SS_TEST export SPARK_VERSION=2.4.5. For BEAM_FLINK_TEST export FLINK_VERSION=1.9.0"
    echo "START_ZK: run a single node ZooKeeper instance on local host in the background"
    echo "STOP_ZK: kill the ZooKeeper instance"
    echo "START_REDIS: run a redis instance in the background"
    echo "STOP_REDIS: kill the redis instance"
    echo "START_KAFKA: run kafka in the background"
    echo "STOP_KAFKA: kill kafka"
    echo "START_LOAD: run kafka load generation"
    echo "STOP_LOAD: kill kafka load generation"
    echo "START_STORM: run storm daemons in the background"
    echo "STOP_STORM: kill the storm daemons"
    echo "START_FLINK: run flink processes"
    echo "STOP_FLINK: kill flink processes"
    echo "START_SPARK: run spark processes"
    echo "STOP_SPARK: kill spark processes"
    echo
    echo "START_STORM_TOPOLOGY: run the storm test topology"
    echo "STOP_STORM_TOPOLOGY: kill the storm test topology"
    echo "START_TRIDENT_STORM_TOPOLOGY: run the storm test topology"
    echo "STOP_TRIDENT_STORM_TOPOLOGY: kill the storm test topology"
    echo "START_FLINK_PROCESSING: run the flink test processing"
    echo "STOP_FLINK_PROCESSSING: kill the flink test processing"
    echo "START_DSTREAM_SPARK_PROCESSING: run the spark legacy dstream test processing"
    echo "STOP_DSTREAM_SPARK_PROCESSSING: kill the spark legacy dstream test processing"
    echo "START_SS_SPARK_PROCESSING: run the spark structured streaming test processing"
    echo "STOP_SS_SPARK_PROCESSING: kill spark structured streaming test processing"
    echo "START_BEAM_SPARK_PROCESSING: run apache beam spark runner pipeline"
    echo "STOP_BEAM_SPARK_PROCESSING: kill apache beam spark runner pipeline"
    echo "START_BEAM_SS_SPARK_PROCESSING: run apache beam spark structured streaming runner pipeline"
    echo "STOP_BEAM_SS_SPARK_PROCESSING: kill apache beam spark structured streaming runner pipeline"
    echo "START_BEAM_FLINK_PROCESSING: run apache beam flink runner pipeline"
    echo "STOP_BEAM_FLINK_PROCESSING: kill apache beam flink runner pipeline"
    echo
    echo "STORM_TEST: run storm test (assumes SETUP is done)"
    echo "STORM_TRIDENT_TEST: run storm test (assumes SETUP is done)"
    echo "FLINK_TEST: run flink test (assumes SETUP is done)"
    echo "SPARK_DSTREAM_TEST: run spark dstream legacy test (assumes SETUP is done)"
    echo "SPARK_SS_TEST: run spark structured streaming test (assumes SETUP is done)"
    echo "BEAM_SPARK_TEST: run apache beam using spark runner test (assumes SETUP is done)"
    echo "BEAM_SPARK_SS_TEST: run apache beam using spark structured streaming runner test (assumes SETUP is done)"
    echo "BEAM_FLINK_TEST: run apache beam using flink runner test (assumes SETUP is done)"
    echo "STOP_ALL: stop everything"
    echo
    echo "HELP: print out this message"
    echo
    exit 1
  fi
}

if [ $# -lt 1 ];
then
  run "HELP"
else
  while [ $# -gt 0 ];
  do
    run "$1"
    shift
  done
fi
