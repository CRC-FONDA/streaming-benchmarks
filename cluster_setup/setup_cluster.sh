#!/bin/bash
ROOT="~/streaming-benchmarks"
BEAM_VERSION=${BEAM_VERSION:-"2.20.0"}
KAFKA_VERSION=${KAFKA_VERSION:-"2.4.1"}
REDIS_VERSION=${REDIS_VERSION:-"6.0.1"}
SCALA_BIN_VERSION=${SCALA_BIN_VERSION:-"2.12"}
HADOOP_HOME=/home/schintap/hadoop-2.8.3
HADOOP_PREFIX=$HADOOP_HOME
SCALA_SUB_VERSION=${SCALA_SUB_VERSION:-"11"}
STORM_VERSION=${STORM_VERSION:-"2.2.0"}
FLINK_VERSION=${FLINK_VERSION:-"1.11.0"}
SPARK_VERSION=${SPARK_VERSION:-"3.0.0"}
HADOOP_FLINK_BUNDLE_VERSION=${HADOOP_VERSION:-"2.8.3-0.10"}
YJAVA_HOME=${YJAVA_HOME:-"/home/y/share/yjava_jdk/java"}
HADOOP_CLASSPATH=/home/schintap/hadoop-2.8.3/etc/hadoop:/home/schintap/hadoop-2.8.3/share/hadoop/common/lib/jetty-sslengine-6.1.26.jar:/home/schintap/hadoop-2.8.3/share/hadoop/common/lib/jets3t-0.9.0.jar:/home/schintap/hadoop-2.8.3/share/hadoop/common/lib/httpcore-4.4.4.jar:/home/schintap/hadoop-2.8.3/share/hadoop/common/lib/htrace-core4-4.0.1-incubating.jar:/home/schintap/hadoop-2.8.3/share/hadoop/common/lib/commons-configuration-1.6.jar:/home/schintap/hadoop-2.8.3/share/hadoop/common/lib/jersey-core-1.9.jar:/home/schintap/hadoop-2.8.3/share/hadoop/common/lib/jsr305-3.0.0.jar:/home/schintap/hadoop-2.8.3/share/hadoop/common/lib/commons-lang-2.6.jar:/home/schintap/hadoop-2.8.3/share/hadoop/common/lib/curator-recipes-2.7.1.jar:/home/schintap/hadoop-2.8.3/share/hadoop/common/lib/jaxb-impl-2.2.3-1.jar:/home/schintap/hadoop-2.8.3/share/hadoop/common/lib/java-xmlbuilder-0.4.jar:/home/schintap/hadoop-2.8.3/share/hadoop/common/lib/jackson-jaxrs-1.9.13.jar:/home/schintap/hadoop-2.8.3/share/hadoop/common/lib/snappy-java-1.0.4.1.jar:/home/schintap/hadoop-2.8.3/share/hadoop/common/lib/curator-framework-2.7.1.jar:/home/schintap/hadoop-2.8.3/share/hadoop/common/lib/jsch-0.1.54.jar:/home/schintap/hadoop-2.8.3/share/hadoop/common/lib/guava-11.0.2.jar:/home/schintap/hadoop-2.8.3/share/hadoop/common/lib/zookeeper-3.4.6.jar:/home/schintap/hadoop-2.8.3/share/hadoop/common/lib/jaxb-api-2.2.2.jar:/home/schintap/hadoop-2.8.3/share/hadoop/common/lib/commons-logging-1.1.3.jar:/home/schintap/hadoop-2.8.3/share/hadoop/common/lib/slf4j-api-1.7.10.jar:/home/schintap/hadoop-2.8.3/share/hadoop/common/lib/paranamer-2.3.jar:/home/schintap/hadoop-2.8.3/share/hadoop/common/lib/jersey-json-1.9.jar:/home/schintap/hadoop-2.8.3/share/hadoop/common/lib/api-util-1.0.0-M20.jar:/home/schintap/hadoop-2.8.3/share/hadoop/common/lib/commons-io-2.4.jar:/home/schintap/hadoop-2.8.3/share/hadoop/common/lib/jettison-1.1.jar:/home/schintap/hadoop-2.8.3/share/hadoop/common/lib/asm-3.2.jar:/home/schintap/hadoop-2.8.3/share/hadoop/common/lib/apacheds-i18n-2.0.0-M15.jar:/home/schintap/hadoop-2.8.3/share/hadoop/common/lib/jackson-mapper-asl-1.9.13.jar:/home/schintap/hadoop-2.8.3/share/hadoop/common/lib/log4j-1.2.17.jar:/home/schintap/hadoop-2.8.3/share/hadoop/common/lib/commons-codec-1.4.jar:/home/schintap/hadoop-2.8.3/share/hadoop/common/lib/commons-digester-1.8.jar:/home/schintap/hadoop-2.8.3/share/hadoop/common/lib/commons-beanutils-1.7.0.jar:/home/schintap/hadoop-2.8.3/share/hadoop/common/lib/gson-2.2.4.jar:/home/schintap/hadoop-2.8.3/share/hadoop/common/lib/commons-compress-1.4.1.jar:/home/schintap/hadoop-2.8.3/share/hadoop/common/lib/commons-collections-3.2.2.jar:/home/schintap/hadoop-2.8.3/share/hadoop/common/lib/commons-net-3.1.jar:/home/schintap/hadoop-2.8.3/share/hadoop/common/lib/commons-math3-3.1.1.jar:/home/schintap/hadoop-2.8.3/share/hadoop/common/lib/jsp-api-2.1.jar:/home/schintap/hadoop-2.8.3/share/hadoop/common/lib/hamcrest-core-1.3.jar:/home/schintap/hadoop-2.8.3/share/hadoop/common/lib/stax-api-1.0-2.jar:/home/schintap/hadoop-2.8.3/share/hadoop/common/lib/commons-beanutils-core-1.8.0.jar:/home/schintap/hadoop-2.8.3/share/hadoop/common/lib/apacheds-kerberos-codec-2.0.0-M15.jar:/home/schintap/hadoop-2.8.3/share/hadoop/common/lib/jetty-util-6.1.26.jar:/home/schintap/hadoop-2.8.3/share/hadoop/common/lib/api-asn1-api-1.0.0-M20.jar:/home/schintap/hadoop-2.8.3/share/hadoop/common/lib/xz-1.0.jar:/home/schintap/hadoop-2.8.3/share/hadoop/common/lib/hadoop-auth-2.8.3.jar:/home/schintap/hadoop-2.8.3/share/hadoop/common/lib/jackson-xc-1.9.13.jar:/home/schintap/hadoop-2.8.3/share/hadoop/common/lib/jcip-annotations-1.0.jar:/home/schintap/hadoop-2.8.3/share/hadoop/common/lib/protobuf-java-2.5.0.jar:/home/schintap/hadoop-2.8.3/share/hadoop/common/lib/jersey-server-1.9.jar:/home/schintap/hadoop-2.8.3/share/hadoop/common/lib/mockito-all-1.8.5.jar:/home/schintap/hadoop-2.8.3/share/hadoop/common/lib/curator-client-2.7.1.jar:/home/schintap/hadoop-2.8.3/share/hadoop/common/lib/slf4j-log4j12-1.7.10.jar:/home/schintap/hadoop-2.8.3/share/hadoop/common/lib/servlet-api-2.5.jar:/home/schintap/hadoop-2.8.3/share/hadoop/common/lib/json-smart-1.1.1.jar:/home/schintap/hadoop-2.8.3/share/hadoop/common/lib/xmlenc-0.52.jar:/home/schintap/hadoop-2.8.3/share/hadoop/common/lib/jackson-core-asl-1.9.13.jar:/home/schintap/hadoop-2.8.3/share/hadoop/common/lib/activation-1.1.jar:/home/schintap/hadoop-2.8.3/share/hadoop/common/lib/netty-3.6.2.Final.jar:/home/schintap/hadoop-2.8.3/share/hadoop/common/lib/avro-1.7.4.jar:/home/schintap/hadoop-2.8.3/share/hadoop/common/lib/hadoop-annotations-2.8.3.jar:/home/schintap/hadoop-2.8.3/share/hadoop/common/lib/jetty-6.1.26.jar:/home/schintap/hadoop-2.8.3/share/hadoop/common/lib/nimbus-jose-jwt-3.9.jar:/home/schintap/hadoop-2.8.3/share/hadoop/common/lib/commons-cli-1.2.jar:/home/schintap/hadoop-2.8.3/share/hadoop/common/lib/junit-4.11.jar:/home/schintap/hadoop-2.8.3/share/hadoop/common/lib/httpclient-4.5.2.jar:/home/schintap/hadoop-2.8.3/share/hadoop/common/hadoop-nfs-2.8.3.jar:/home/schintap/hadoop-2.8.3/share/hadoop/common/hadoop-common-2.8.3.jar:/home/schintap/hadoop-2.8.3/share/hadoop/common/hadoop-common-2.8.3-tests.jar:/home/schintap/hadoop-2.8.3/share/hadoop/hdfs:/home/schintap/hadoop-2.8.3/share/hadoop/hdfs/lib/htrace-core4-4.0.1-incubating.jar:/home/schintap/hadoop-2.8.3/share/hadoop/hdfs/lib/jersey-core-1.9.jar:/home/schintap/hadoop-2.8.3/share/hadoop/hdfs/lib/jsr305-3.0.0.jar:/home/schintap/hadoop-2.8.3/share/hadoop/hdfs/lib/commons-lang-2.6.jar:/home/schintap/hadoop-2.8.3/share/hadoop/hdfs/lib/guava-11.0.2.jar:/home/schintap/hadoop-2.8.3/share/hadoop/hdfs/lib/commons-daemon-1.0.13.jar:/home/schintap/hadoop-2.8.3/share/hadoop/hdfs/lib/commons-logging-1.1.3.jar:/home/schintap/hadoop-2.8.3/share/hadoop/hdfs/lib/commons-io-2.4.jar:/home/schintap/hadoop-2.8.3/share/hadoop/hdfs/lib/netty-all-4.0.23.Final.jar:/home/schintap/hadoop-2.8.3/share/hadoop/hdfs/lib/asm-3.2.jar:/home/schintap/hadoop-2.8.3/share/hadoop/hdfs/lib/jackson-mapper-asl-1.9.13.jar:/home/schintap/hadoop-2.8.3/share/hadoop/hdfs/lib/log4j-1.2.17.jar:/home/schintap/hadoop-2.8.3/share/hadoop/hdfs/lib/xercesImpl-2.9.1.jar:/home/schintap/hadoop-2.8.3/share/hadoop/hdfs/lib/commons-codec-1.4.jar:/home/schintap/hadoop-2.8.3/share/hadoop/hdfs/lib/xml-apis-1.3.04.jar:/home/schintap/hadoop-2.8.3/share/hadoop/hdfs/lib/jetty-util-6.1.26.jar:/home/schintap/hadoop-2.8.3/share/hadoop/hdfs/lib/okio-1.4.0.jar:/home/schintap/hadoop-2.8.3/share/hadoop/hdfs/lib/okhttp-2.4.0.jar:/home/schintap/hadoop-2.8.3/share/hadoop/hdfs/lib/protobuf-java-2.5.0.jar:/home/schintap/hadoop-2.8.3/share/hadoop/hdfs/lib/hadoop-hdfs-client-2.8.3.jar:/home/schintap/hadoop-2.8.3/share/hadoop/hdfs/lib/jersey-server-1.9.jar:/home/schintap/hadoop-2.8.3/share/hadoop/hdfs/lib/servlet-api-2.5.jar:/home/schintap/hadoop-2.8.3/share/hadoop/hdfs/lib/leveldbjni-all-1.8.jar:/home/schintap/hadoop-2.8.3/share/hadoop/hdfs/lib/xmlenc-0.52.jar:/home/schintap/hadoop-2.8.3/share/hadoop/hdfs/lib/jackson-core-asl-1.9.13.jar:/home/schintap/hadoop-2.8.3/share/hadoop/hdfs/lib/netty-3.6.2.Final.jar:/home/schintap/hadoop-2.8.3/share/hadoop/hdfs/lib/jetty-6.1.26.jar:/home/schintap/hadoop-2.8.3/share/hadoop/hdfs/lib/commons-cli-1.2.jar:/home/schintap/hadoop-2.8.3/share/hadoop/hdfs/hadoop-hdfs-2.8.3-tests.jar:/home/schintap/hadoop-2.8.3/share/hadoop/hdfs/hadoop-hdfs-nfs-2.8.3.jar:/home/schintap/hadoop-2.8.3/share/hadoop/hdfs/hadoop-hdfs-2.8.3.jar:/home/schintap/hadoop-2.8.3/share/hadoop/hdfs/hadoop-hdfs-native-client-2.8.3.jar:/home/schintap/hadoop-2.8.3/share/hadoop/hdfs/hadoop-hdfs-native-client-2.8.3-tests.jar:/home/schintap/hadoop-2.8.3/share/hadoop/hdfs/hadoop-hdfs-client-2.8.3-tests.jar:/home/schintap/hadoop-2.8.3/share/hadoop/hdfs/hadoop-hdfs-client-2.8.3.jar:/home/schintap/hadoop-2.8.3/share/hadoop/yarn/lib/jersey-client-1.9.jar:/home/schintap/hadoop-2.8.3/share/hadoop/yarn/lib/jersey-core-1.9.jar:/home/schintap/hadoop-2.8.3/share/hadoop/yarn/lib/jsr305-3.0.0.jar:/home/schintap/hadoop-2.8.3/share/hadoop/yarn/lib/commons-lang-2.6.jar:/home/schintap/hadoop-2.8.3/share/hadoop/yarn/lib/jaxb-impl-2.2.3-1.jar:/home/schintap/hadoop-2.8.3/share/hadoop/yarn/lib/zookeeper-3.4.6-tests.jar:/home/schintap/hadoop-2.8.3/share/hadoop/yarn/lib/jackson-jaxrs-1.9.13.jar:/home/schintap/hadoop-2.8.3/share/hadoop/yarn/lib/guava-11.0.2.jar:/home/schintap/hadoop-2.8.3/share/hadoop/yarn/lib/zookeeper-3.4.6.jar:/home/schintap/hadoop-2.8.3/share/hadoop/yarn/lib/jaxb-api-2.2.2.jar:/home/schintap/hadoop-2.8.3/share/hadoop/yarn/lib/commons-logging-1.1.3.jar:/home/schintap/hadoop-2.8.3/share/hadoop/yarn/lib/jersey-json-1.9.jar:/home/schintap/hadoop-2.8.3/share/hadoop/yarn/lib/jersey-guice-1.9.jar:/home/schintap/hadoop-2.8.3/share/hadoop/yarn/lib/commons-io-2.4.jar:/home/schintap/hadoop-2.8.3/share/hadoop/yarn/lib/jettison-1.1.jar:/home/schintap/hadoop-2.8.3/share/hadoop/yarn/lib/guice-servlet-3.0.jar:/home/schintap/hadoop-2.8.3/share/hadoop/yarn/lib/asm-3.2.jar:/home/schintap/hadoop-2.8.3/share/hadoop/yarn/lib/jackson-mapper-asl-1.9.13.jar:/home/schintap/hadoop-2.8.3/share/hadoop/yarn/lib/log4j-1.2.17.jar:/home/schintap/hadoop-2.8.3/share/hadoop/yarn/lib/json-io-2.5.1.jar:/home/schintap/hadoop-2.8.3/share/hadoop/yarn/lib/javassist-3.18.1-GA.jar:/home/schintap/hadoop-2.8.3/share/hadoop/yarn/lib/commons-math-2.2.jar:/home/schintap/hadoop-2.8.3/share/hadoop/yarn/lib/commons-codec-1.4.jar:/home/schintap/hadoop-2.8.3/share/hadoop/yarn/lib/commons-compress-1.4.1.jar:/home/schintap/hadoop-2.8.3/share/hadoop/yarn/lib/guice-3.0.jar:/home/schintap/hadoop-2.8.3/share/hadoop/yarn/lib/commons-collections-3.2.2.jar:/home/schintap/hadoop-2.8.3/share/hadoop/yarn/lib/aopalliance-1.0.jar:/home/schintap/hadoop-2.8.3/share/hadoop/yarn/lib/stax-api-1.0-2.jar:/home/schintap/hadoop-2.8.3/share/hadoop/yarn/lib/jetty-util-6.1.26.jar:/home/schintap/hadoop-2.8.3/share/hadoop/yarn/lib/xz-1.0.jar:/home/schintap/hadoop-2.8.3/share/hadoop/yarn/lib/jackson-xc-1.9.13.jar:/home/schintap/hadoop-2.8.3/share/hadoop/yarn/lib/java-util-1.9.0.jar:/home/schintap/hadoop-2.8.3/share/hadoop/yarn/lib/protobuf-java-2.5.0.jar:/home/schintap/hadoop-2.8.3/share/hadoop/yarn/lib/fst-2.50.jar:/home/schintap/hadoop-2.8.3/share/hadoop/yarn/lib/javax.inject-1.jar:/home/schintap/hadoop-2.8.3/share/hadoop/yarn/lib/jersey-server-1.9.jar:/home/schintap/hadoop-2.8.3/share/hadoop/yarn/lib/curator-client-2.7.1.jar:/home/schintap/hadoop-2.8.3/share/hadoop/yarn/lib/servlet-api-2.5.jar:/home/schintap/hadoop-2.8.3/share/hadoop/yarn/lib/leveldbjni-all-1.8.jar:/home/schintap/hadoop-2.8.3/share/hadoop/yarn/lib/jackson-core-asl-1.9.13.jar:/home/schintap/hadoop-2.8.3/share/hadoop/yarn/lib/activation-1.1.jar:/home/schintap/hadoop-2.8.3/share/hadoop/yarn/lib/netty-3.6.2.Final.jar:/home/schintap/hadoop-2.8.3/share/hadoop/yarn/lib/jetty-6.1.26.jar:/home/schintap/hadoop-2.8.3/share/hadoop/yarn/lib/commons-cli-1.2.jar:/home/schintap/hadoop-2.8.3/share/hadoop/yarn/lib/curator-test-2.7.1.jar:/home/schintap/hadoop-2.8.3/share/hadoop/yarn/hadoop-yarn-api-2.8.3.jar:/home/schintap/hadoop-2.8.3/share/hadoop/yarn/hadoop-yarn-client-2.8.3.jar:/home/schintap/hadoop-2.8.3/share/hadoop/yarn/hadoop-yarn-server-sharedcachemanager-2.8.3.jar:/home/schintap/hadoop-2.8.3/share/hadoop/yarn/hadoop-yarn-server-resourcemanager-2.8.3.jar:/home/schintap/hadoop-2.8.3/share/hadoop/yarn/hadoop-yarn-server-applicationhistoryservice-2.8.3.jar:/home/schintap/hadoop-2.8.3/share/hadoop/yarn/hadoop-yarn-server-nodemanager-2.8.3.jar:/home/schintap/hadoop-2.8.3/share/hadoop/yarn/hadoop-yarn-server-web-proxy-2.8.3.jar:/home/schintap/hadoop-2.8.3/share/hadoop/yarn/hadoop-yarn-server-common-2.8.3.jar:/home/schintap/hadoop-2.8.3/share/hadoop/yarn/hadoop-yarn-server-timeline-pluginstorage-2.8.3.jar:/home/schintap/hadoop-2.8.3/share/hadoop/yarn/hadoop-yarn-registry-2.8.3.jar:/home/schintap/hadoop-2.8.3/share/hadoop/yarn/hadoop-yarn-common-2.8.3.jar:/home/schintap/hadoop-2.8.3/share/hadoop/yarn/hadoop-yarn-applications-distributedshell-2.8.3.jar:/home/schintap/hadoop-2.8.3/share/hadoop/yarn/hadoop-yarn-server-tests-2.8.3.jar:/home/schintap/hadoop-2.8.3/share/hadoop/yarn/hadoop-yarn-applications-unmanaged-am-launcher-2.8.3.jar:/home/schintap/hadoop-2.8.3/share/hadoop/mapreduce/lib/jersey-core-1.9.jar:/home/schintap/hadoop-2.8.3/share/hadoop/mapreduce/lib/snappy-java-1.0.4.1.jar:/home/schintap/hadoop-2.8.3/share/hadoop/mapreduce/lib/paranamer-2.3.jar:/home/schintap/hadoop-2.8.3/share/hadoop/mapreduce/lib/jersey-guice-1.9.jar:/home/schintap/hadoop-2.8.3/share/hadoop/mapreduce/lib/commons-io-2.4.jar:/home/schintap/hadoop-2.8.3/share/hadoop/mapreduce/lib/guice-servlet-3.0.jar:/home/schintap/hadoop-2.8.3/share/hadoop/mapreduce/lib/asm-3.2.jar:/home/schintap/hadoop-2.8.3/share/hadoop/mapreduce/lib/jackson-mapper-asl-1.9.13.jar:/home/schintap/hadoop-2.8.3/share/hadoop/mapreduce/lib/log4j-1.2.17.jar:/home/schintap/hadoop-2.8.3/share/hadoop/mapreduce/lib/commons-compress-1.4.1.jar:/home/schintap/hadoop-2.8.3/share/hadoop/mapreduce/lib/guice-3.0.jar:/home/schintap/hadoop-2.8.3/share/hadoop/mapreduce/lib/aopalliance-1.0.jar:/home/schintap/hadoop-2.8.3/share/hadoop/mapreduce/lib/hamcrest-core-1.3.jar:/home/schintap/hadoop-2.8.3/share/hadoop/mapreduce/lib/xz-1.0.jar:/home/schintap/hadoop-2.8.3/share/hadoop/mapreduce/lib/protobuf-java-2.5.0.jar:/home/schintap/hadoop-2.8.3/share/hadoop/mapreduce/lib/javax.inject-1.jar:/home/schintap/hadoop-2.8.3/share/hadoop/mapreduce/lib/jersey-server-1.9.jar:/home/schintap/hadoop-2.8.3/share/hadoop/mapreduce/lib/leveldbjni-all-1.8.jar:/home/schintap/hadoop-2.8.3/share/hadoop/mapreduce/lib/jackson-core-asl-1.9.13.jar:/home/schintap/hadoop-2.8.3/share/hadoop/mapreduce/lib/netty-3.6.2.Final.jar:/home/schintap/hadoop-2.8.3/share/hadoop/mapreduce/lib/avro-1.7.4.jar:/home/schintap/hadoop-2.8.3/share/hadoop/mapreduce/lib/hadoop-annotations-2.8.3.jar:/home/schintap/hadoop-2.8.3/share/hadoop/mapreduce/lib/junit-4.11.jar:/home/schintap/hadoop-2.8.3/share/hadoop/mapreduce/hadoop-mapreduce-client-jobclient-2.8.3-tests.jar:/home/schintap/hadoop-2.8.3/share/hadoop/mapreduce/hadoop-mapreduce-client-hs-2.8.3.jar:/home/schintap/hadoop-2.8.3/share/hadoop/mapreduce/hadoop-mapreduce-client-core-2.8.3.jar:/home/schintap/hadoop-2.8.3/share/hadoop/mapreduce/hadoop-mapreduce-client-common-2.8.3.jar:/home/schintap/hadoop-2.8.3/share/hadoop/mapreduce/hadoop-mapreduce-client-app-2.8.3.jar:/home/schintap/hadoop-2.8.3/share/hadoop/mapreduce/hadoop-mapreduce-client-shuffle-2.8.3.jar:/home/schintap/hadoop-2.8.3/share/hadoop/mapreduce/hadoop-mapreduce-client-hs-plugins-2.8.3.jar:/home/schintap/hadoop-2.8.3/share/hadoop/mapreduce/hadoop-mapreduce-examples-2.8.3.jar:/home/schintap/hadoop-2.8.3/share/hadoop/mapreduce/hadoop-mapreduce-client-jobclient-2.8.3.jar:/home/schintap/hadoop-2.8.3/etc/hadoop:/home/schintap/hadoop-2.8.3/share/hadoop/common/lib/jetty-sslengine-6.1.26.jar:/home/schintap/hadoop-2.8.3/share/hadoop/common/lib/jets3t-0.9.0.jar:/home/schintap/hadoop-2.8.3/share/hadoop/common/lib/httpcore-4.4.4.jar:/home/schintap/hadoop-2.8.3/share/hadoop/common/lib/htrace-core4-4.0.1-incubating.jar:/home/schintap/hadoop-2.8.3/share/hadoop/common/lib/commons-configuration-1.6.jar:/home/schintap/hadoop-2.8.3/share/hadoop/common/lib/jersey-core-1.9.jar:/home/schintap/hadoop-2.8.3/share/hadoop/common/lib/jsr305-3.0.0.jar:/home/schintap/hadoop-2.8.3/share/hadoop/common/lib/commons-lang-2.6.jar:/home/schintap/hadoop-2.8.3/share/hadoop/common/lib/curator-recipes-2.7.1.jar:/home/schintap/hadoop-2.8.3/share/hadoop/common/lib/jaxb-impl-2.2.3-1.jar:/home/schintap/hadoop-2.8.3/share/hadoop/common/lib/java-xmlbuilder-0.4.jar:/home/schintap/hadoop-2.8.3/share/hadoop/common/lib/jackson-jaxrs-1.9.13.jar:/home/schintap/hadoop-2.8.3/share/hadoop/common/lib/snappy-java-1.0.4.1.jar:/home/schintap/hadoop-2.8.3/share/hadoop/common/lib/curator-framework-2.7.1.jar:/home/schintap/hadoop-2.8.3/share/hadoop/common/lib/jsch-0.1.54.jar:/home/schintap/hadoop-2.8.3/share/hadoop/common/lib/guava-11.0.2.jar:/home/schintap/hadoop-2.8.3/share/hadoop/common/lib/zookeeper-3.4.6.jar:/home/schintap/hadoop-2.8.3/share/hadoop/common/lib/jaxb-api-2.2.2.jar:/home/schintap/hadoop-2.8.3/share/hadoop/common/lib/commons-logging-1.1.3.jar:/home/schintap/hadoop-2.8.3/share/hadoop/common/lib/slf4j-api-1.7.10.jar:/home/schintap/hadoop-2.8.3/share/hadoop/common/lib/paranamer-2.3.jar:/home/schintap/hadoop-2.8.3/share/hadoop/common/lib/jersey-json-1.9.jar:/home/schintap/hadoop-2.8.3/share/hadoop/common/lib/api-util-1.0.0-M20.jar:/home/schintap/hadoop-2.8.3/share/hadoop/common/lib/commons-io-2.4.jar:/home/schintap/hadoop-2.8.3/share/hadoop/common/lib/jettison-1.1.jar:/home/schintap/hadoop-2.8.3/share/hadoop/common/lib/asm-3.2.jar:/home/schintap/hadoop-2.8.3/share/hadoop/common/lib/apacheds-i18n-2.0.0-M15.jar:/home/schintap/hadoop-2.8.3/share/hadoop/common/lib/jackson-mapper-asl-1.9.13.jar:/home/schintap/hadoop-2.8.3/share/hadoop/common/lib/log4j-1.2.17.jar:/home/schintap/hadoop-2.8.3/share/hadoop/common/lib/commons-codec-1.4.jar:/home/schintap/hadoop-2.8.3/share/hadoop/common/lib/commons-digester-1.8.jar:/home/schintap/hadoop-2.8.3/share/hadoop/common/lib/commons-beanutils-1.7.0.jar:/home/schintap/hadoop-2.8.3/share/hadoop/common/lib/gson-2.2.4.jar:/home/schintap/hadoop-2.8.3/share/hadoop/common/lib/commons-compress-1.4.1.jar:/home/schintap/hadoop-2.8.3/share/hadoop/common/lib/commons-collections-3.2.2.jar:/home/schintap/hadoop-2.8.3/share/hadoop/common/lib/commons-net-3.1.jar:/home/schintap/hadoop-2.8.3/share/hadoop/common/lib/commons-math3-3.1.1.jar:/home/schintap/hadoop-2.8.3/share/hadoop/common/lib/jsp-api-2.1.jar:/home/schintap/hadoop-2.8.3/share/hadoop/common/lib/hamcrest-core-1.3.jar:/home/schintap/hadoop-2.8.3/share/hadoop/common/lib/stax-api-1.0-2.jar:/home/schintap/hadoop-2.8.3/share/hadoop/common/lib/commons-beanutils-core-1.8.0.jar:/home/schintap/hadoop-2.8.3/share/hadoop/common/lib/apacheds-kerberos-codec-2.0.0-M15.jar:/home/schintap/hadoop-2.8.3/share/hadoop/common/lib/jetty-util-6.1.26.jar:/home/schintap/hadoop-2.8.3/share/hadoop/common/lib/api-asn1-api-1.0.0-M20.jar:/home/schintap/hadoop-2.8.3/share/hadoop/common/lib/xz-1.0.jar:/home/schintap/hadoop-2.8.3/share/hadoop/common/lib/hadoop-auth-2.8.3.jar:/home/schintap/hadoop-2.8.3/share/hadoop/common/lib/jackson-xc-1.9.13.jar:/home/schintap/hadoop-2.8.3/share/hadoop/common/lib/jcip-annotations-1.0.jar:/home/schintap/hadoop-2.8.3/share/hadoop/common/lib/protobuf-java-2.5.0.jar:/home/schintap/hadoop-2.8.3/share/hadoop/common/lib/jersey-server-1.9.jar:/home/schintap/hadoop-2.8.3/share/hadoop/common/lib/mockito-all-1.8.5.jar:/home/schintap/hadoop-2.8.3/share/hadoop/common/lib/curator-client-2.7.1.jar:/home/schintap/hadoop-2.8.3/share/hadoop/common/lib/slf4j-log4j12-1.7.10.jar:/home/schintap/hadoop-2.8.3/share/hadoop/common/lib/servlet-api-2.5.jar:/home/schintap/hadoop-2.8.3/share/hadoop/common/lib/json-smart-1.1.1.jar:/home/schintap/hadoop-2.8.3/share/hadoop/common/lib/xmlenc-0.52.jar:/home/schintap/hadoop-2.8.3/share/hadoop/common/lib/jackson-core-asl-1.9.13.jar:/home/schintap/hadoop-2.8.3/share/hadoop/common/lib/activation-1.1.jar:/home/schintap/hadoop-2.8.3/share/hadoop/common/lib/netty-3.6.2.Final.jar:/home/schintap/hadoop-2.8.3/share/hadoop/common/lib/avro-1.7.4.jar:/home/schintap/hadoop-2.8.3/share/hadoop/common/lib/hadoop-annotations-2.8.3.jar:/home/schintap/hadoop-2.8.3/share/hadoop/common/lib/jetty-6.1.26.jar:/home/schintap/hadoop-2.8.3/share/hadoop/common/lib/nimbus-jose-jwt-3.9.jar:/home/schintap/hadoop-2.8.3/share/hadoop/common/lib/commons-cli-1.2.jar:/home/schintap/hadoop-2.8.3/share/hadoop/common/lib/junit-4.11.jar:/home/schintap/hadoop-2.8.3/share/hadoop/common/lib/httpclient-4.5.2.jar:/home/schintap/hadoop-2.8.3/share/hadoop/common/hadoop-nfs-2.8.3.jar:/home/schintap/hadoop-2.8.3/share/hadoop/common/hadoop-common-2.8.3.jar:/home/schintap/hadoop-2.8.3/share/hadoop/common/hadoop-common-2.8.3-tests.jar:/home/schintap/hadoop-2.8.3/share/hadoop/hdfs:/home/schintap/hadoop-2.8.3/share/hadoop/hdfs/lib/htrace-core4-4.0.1-incubating.jar:/home/schintap/hadoop-2.8.3/share/hadoop/hdfs/lib/jersey-core-1.9.jar:/home/schintap/hadoop-2.8.3/share/hadoop/hdfs/lib/jsr305-3.0.0.jar:/home/schintap/hadoop-2.8.3/share/hadoop/hdfs/lib/commons-lang-2.6.jar:/home/schintap/hadoop-2.8.3/share/hadoop/hdfs/lib/guava-11.0.2.jar:/home/schintap/hadoop-2.8.3/share/hadoop/hdfs/lib/commons-daemon-1.0.13.jar:/home/schintap/hadoop-2.8.3/share/hadoop/hdfs/lib/commons-logging-1.1.3.jar:/home/schintap/hadoop-2.8.3/share/hadoop/hdfs/lib/commons-io-2.4.jar:/home/schintap/hadoop-2.8.3/share/hadoop/hdfs/lib/netty-all-4.0.23.Final.jar:/home/schintap/hadoop-2.8.3/share/hadoop/hdfs/lib/asm-3.2.jar:/home/schintap/hadoop-2.8.3/share/hadoop/hdfs/lib/jackson-mapper-asl-1.9.13.jar:/home/schintap/hadoop-2.8.3/share/hadoop/hdfs/lib/log4j-1.2.17.jar:/home/schintap/hadoop-2.8.3/share/hadoop/hdfs/lib/xercesImpl-2.9.1.jar:/home/schintap/hadoop-2.8.3/share/hadoop/hdfs/lib/commons-codec-1.4.jar:/home/schintap/hadoop-2.8.3/share/hadoop/hdfs/lib/xml-apis-1.3.04.jar:/home/schintap/hadoop-2.8.3/share/hadoop/hdfs/lib/jetty-util-6.1.26.jar:/home/schintap/hadoop-2.8.3/share/hadoop/hdfs/lib/okio-1.4.0.jar:/home/schintap/hadoop-2.8.3/share/hadoop/hdfs/lib/okhttp-2.4.0.jar:/home/schintap/hadoop-2.8.3/share/hadoop/hdfs/lib/protobuf-java-2.5.0.jar:/home/schintap/hadoop-2.8.3/share/hadoop/hdfs/lib/hadoop-hdfs-client-2.8.3.jar:/home/schintap/hadoop-2.8.3/share/hadoop/hdfs/lib/jersey-server-1.9.jar:/home/schintap/hadoop-2.8.3/share/hadoop/hdfs/lib/servlet-api-2.5.jar:/home/schintap/hadoop-2.8.3/share/hadoop/hdfs/lib/leveldbjni-all-1.8.jar:/home/schintap/hadoop-2.8.3/share/hadoop/hdfs/lib/xmlenc-0.52.jar:/home/schintap/hadoop-2.8.3/share/hadoop/hdfs/lib/jackson-core-asl-1.9.13.jar:/home/schintap/hadoop-2.8.3/share/hadoop/hdfs/lib/netty-3.6.2.Final.jar:/home/schintap/hadoop-2.8.3/share/hadoop/hdfs/lib/jetty-6.1.26.jar:/home/schintap/hadoop-2.8.3/share/hadoop/hdfs/lib/commons-cli-1.2.jar:/home/schintap/hadoop-2.8.3/share/hadoop/hdfs/hadoop-hdfs-2.8.3-tests.jar:/home/schintap/hadoop-2.8.3/share/hadoop/hdfs/hadoop-hdfs-nfs-2.8.3.jar:/home/schintap/hadoop-2.8.3/share/hadoop/hdfs/hadoop-hdfs-2.8.3.jar:/home/schintap/hadoop-2.8.3/share/hadoop/hdfs/hadoop-hdfs-native-client-2.8.3.jar:/home/schintap/hadoop-2.8.3/share/hadoop/hdfs/hadoop-hdfs-native-client-2.8.3-tests.jar:/home/schintap/hadoop-2.8.3/share/hadoop/hdfs/hadoop-hdfs-client-2.8.3-tests.jar:/home/schintap/hadoop-2.8.3/share/hadoop/hdfs/hadoop-hdfs-client-2.8.3.jar:/home/schintap/hadoop-2.8.3/share/hadoop/yarn/lib/jersey-client-1.9.jar:/home/schintap/hadoop-2.8.3/share/hadoop/yarn/lib/jersey-core-1.9.jar:/home/schintap/hadoop-2.8.3/share/hadoop/yarn/lib/jsr305-3.0.0.jar:/home/schintap/hadoop-2.8.3/share/hadoop/yarn/lib/commons-lang-2.6.jar:/home/schintap/hadoop-2.8.3/share/hadoop/yarn/lib/jaxb-impl-2.2.3-1.jar:/home/schintap/hadoop-2.8.3/share/hadoop/yarn/lib/zookeeper-3.4.6-tests.jar:/home/schintap/hadoop-2.8.3/share/hadoop/yarn/lib/jackson-jaxrs-1.9.13.jar:/home/schintap/hadoop-2.8.3/share/hadoop/yarn/lib/guava-11.0.2.jar:/home/schintap/hadoop-2.8.3/share/hadoop/yarn/lib/zookeeper-3.4.6.jar:/home/schintap/hadoop-2.8.3/share/hadoop/yarn/lib/jaxb-api-2.2.2.jar:/home/schintap/hadoop-2.8.3/share/hadoop/yarn/lib/commons-logging-1.1.3.jar:/home/schintap/hadoop-2.8.3/share/hadoop/yarn/lib/jersey-json-1.9.jar:/home/schintap/hadoop-2.8.3/share/hadoop/yarn/lib/jersey-guice-1.9.jar:/home/schintap/hadoop-2.8.3/share/hadoop/yarn/lib/commons-io-2.4.jar:/home/schintap/hadoop-2.8.3/share/hadoop/yarn/lib/jettison-1.1.jar:/home/schintap/hadoop-2.8.3/share/hadoop/yarn/lib/guice-servlet-3.0.jar:/home/schintap/hadoop-2.8.3/share/hadoop/yarn/lib/asm-3.2.jar:/home/schintap/hadoop-2.8.3/share/hadoop/yarn/lib/jackson-mapper-asl-1.9.13.jar:/home/schintap/hadoop-2.8.3/share/hadoop/yarn/lib/log4j-1.2.17.jar:/home/schintap/hadoop-2.8.3/share/hadoop/yarn/lib/json-io-2.5.1.jar:/home/schintap/hadoop-2.8.3/share/hadoop/yarn/lib/javassist-3.18.1-GA.jar:/home/schintap/hadoop-2.8.3/share/hadoop/yarn/lib/commons-math-2.2.jar:/home/schintap/hadoop-2.8.3/share/hadoop/yarn/lib/commons-codec-1.4.jar:/home/schintap/hadoop-2.8.3/share/hadoop/yarn/lib/commons-compress-1.4.1.jar:/home/schintap/hadoop-2.8.3/share/hadoop/yarn/lib/guice-3.0.jar:/home/schintap/hadoop-2.8.3/share/hadoop/yarn/lib/commons-collections-3.2.2.jar:/home/schintap/hadoop-2.8.3/share/hadoop/yarn/lib/aopalliance-1.0.jar:/home/schintap/hadoop-2.8.3/share/hadoop/yarn/lib/stax-api-1.0-2.jar:/home/schintap/hadoop-2.8.3/share/hadoop/yarn/lib/jetty-util-6.1.26.jar:/home/schintap/hadoop-2.8.3/share/hadoop/yarn/lib/xz-1.0.jar:/home/schintap/hadoop-2.8.3/share/hadoop/yarn/lib/jackson-xc-1.9.13.jar:/home/schintap/hadoop-2.8.3/share/hadoop/yarn/lib/java-util-1.9.0.jar:/home/schintap/hadoop-2.8.3/share/hadoop/yarn/lib/protobuf-java-2.5.0.jar:/home/schintap/hadoop-2.8.3/share/hadoop/yarn/lib/fst-2.50.jar:/home/schintap/hadoop-2.8.3/share/hadoop/yarn/lib/javax.inject-1.jar:/home/schintap/hadoop-2.8.3/share/hadoop/yarn/lib/jersey-server-1.9.jar:/home/schintap/hadoop-2.8.3/share/hadoop/yarn/lib/curator-client-2.7.1.jar:/home/schintap/hadoop-2.8.3/share/hadoop/yarn/lib/servlet-api-2.5.jar:/home/schintap/hadoop-2.8.3/share/hadoop/yarn/lib/leveldbjni-all-1.8.jar:/home/schintap/hadoop-2.8.3/share/hadoop/yarn/lib/jackson-core-asl-1.9.13.jar:/home/schintap/hadoop-2.8.3/share/hadoop/yarn/lib/activation-1.1.jar:/home/schintap/hadoop-2.8.3/share/hadoop/yarn/lib/netty-3.6.2.Final.jar:/home/schintap/hadoop-2.8.3/share/hadoop/yarn/lib/jetty-6.1.26.jar:/home/schintap/hadoop-2.8.3/share/hadoop/yarn/lib/commons-cli-1.2.jar:/home/schintap/hadoop-2.8.3/share/hadoop/yarn/lib/curator-test-2.7.1.jar:/home/schintap/hadoop-2.8.3/share/hadoop/yarn/hadoop-yarn-api-2.8.3.jar:/home/schintap/hadoop-2.8.3/share/hadoop/yarn/hadoop-yarn-client-2.8.3.jar:/home/schintap/hadoop-2.8.3/share/hadoop/yarn/hadoop-yarn-server-sharedcachemanager-2.8.3.jar:/home/schintap/hadoop-2.8.3/share/hadoop/yarn/hadoop-yarn-server-resourcemanager-2.8.3.jar:/home/schintap/hadoop-2.8.3/share/hadoop/yarn/hadoop-yarn-server-applicationhistoryservice-2.8.3.jar:/home/schintap/hadoop-2.8.3/share/hadoop/yarn/hadoop-yarn-server-nodemanager-2.8.3.jar:/home/schintap/hadoop-2.8.3/share/hadoop/yarn/hadoop-yarn-server-web-proxy-2.8.3.jar:/home/schintap/hadoop-2.8.3/share/hadoop/yarn/hadoop-yarn-server-common-2.8.3.jar:/home/schintap/hadoop-2.8.3/share/hadoop/yarn/hadoop-yarn-server-timeline-pluginstorage-2.8.3.jar:/home/schintap/hadoop-2.8.3/share/hadoop/yarn/hadoop-yarn-registry-2.8.3.jar:/home/schintap/hadoop-2.8.3/share/hadoop/yarn/hadoop-yarn-common-2.8.3.jar:/home/schintap/hadoop-2.8.3/share/hadoop/yarn/hadoop-yarn-applications-distributedshell-2.8.3.jar:/home/schintap/hadoop-2.8.3/share/hadoop/yarn/hadoop-yarn-server-tests-2.8.3.jar:/home/schintap/hadoop-2.8.3/share/hadoop/yarn/hadoop-yarn-applications-unmanaged-am-launcher-2.8.3.jar:/home/schintap/hadoop-2.8.3/share/hadoop/mapreduce/lib/jersey-core-1.9.jar:/home/schintap/hadoop-2.8.3/share/hadoop/mapreduce/lib/snappy-java-1.0.4.1.jar:/home/schintap/hadoop-2.8.3/share/hadoop/mapreduce/lib/paranamer-2.3.jar:/home/schintap/hadoop-2.8.3/share/hadoop/mapreduce/lib/jersey-guice-1.9.jar:/home/schintap/hadoop-2.8.3/share/hadoop/mapreduce/lib/commons-io-2.4.jar:/home/schintap/hadoop-2.8.3/share/hadoop/mapreduce/lib/guice-servlet-3.0.jar:/home/schintap/hadoop-2.8.3/share/hadoop/mapreduce/lib/asm-3.2.jar:/home/schintap/hadoop-2.8.3/share/hadoop/mapreduce/lib/jackson-mapper-asl-1.9.13.jar:/home/schintap/hadoop-2.8.3/share/hadoop/mapreduce/lib/log4j-1.2.17.jar:/home/schintap/hadoop-2.8.3/share/hadoop/mapreduce/lib/commons-compress-1.4.1.jar:/home/schintap/hadoop-2.8.3/share/hadoop/mapreduce/lib/guice-3.0.jar:/home/schintap/hadoop-2.8.3/share/hadoop/mapreduce/lib/aopalliance-1.0.jar:/home/schintap/hadoop-2.8.3/share/hadoop/mapreduce/lib/hamcrest-core-1.3.jar:/home/schintap/hadoop-2.8.3/share/hadoop/mapreduce/lib/xz-1.0.jar:/home/schintap/hadoop-2.8.3/share/hadoop/mapreduce/lib/protobuf-java-2.5.0.jar:/home/schintap/hadoop-2.8.3/share/hadoop/mapreduce/lib/javax.inject-1.jar:/home/schintap/hadoop-2.8.3/share/hadoop/mapreduce/lib/jersey-server-1.9.jar:/home/schintap/hadoop-2.8.3/share/hadoop/mapreduce/lib/leveldbjni-all-1.8.jar:/home/schintap/hadoop-2.8.3/share/hadoop/mapreduce/lib/jackson-core-asl-1.9.13.jar:/home/schintap/hadoop-2.8.3/share/hadoop/mapreduce/lib/netty-3.6.2.Final.jar:/home/schintap/hadoop-2.8.3/share/hadoop/mapreduce/lib/avro-1.7.4.jar:/home/schintap/hadoop-2.8.3/share/hadoop/mapreduce/lib/hadoop-annotations-2.8.3.jar:/home/schintap/hadoop-2.8.3/share/hadoop/mapreduce/lib/junit-4.11.jar:/home/schintap/hadoop-2.8.3/share/hadoop/mapreduce/hadoop-mapreduce-client-jobclient-2.8.3-tests.jar:/home/schintap/hadoop-2.8.3/share/hadoop/mapreduce/hadoop-mapreduce-client-hs-2.8.3.jar:/home/schintap/hadoop-2.8.3/share/hadoop/mapreduce/hadoop-mapreduce-client-core-2.8.3.jar:/home/schintap/hadoop-2.8.3/share/hadoop/mapreduce/hadoop-mapreduce-client-common-2.8.3.jar:/home/schintap/hadoop-2.8.3/share/hadoop/mapreduce/hadoop-mapreduce-client-app-2.8.3.jar:/home/schintap/hadoop-2.8.3/share/hadoop/mapreduce/hadoop-mapreduce-client-shuffle-2.8.3.jar:/home/schintap/hadoop-2.8.3/share/hadoop/mapreduce/hadoop-mapreduce-client-hs-plugins-2.8.3.jar:/home/schintap/hadoop-2.8.3/share/hadoop/mapreduce/hadoop-mapreduce-examples-2.8.3.jar:/home/schintap/hadoop-2.8.3/share/hadoop/mapreduce/hadoop-mapreduce-client-jobclient-2.8.3.jar:/home/schintap/hadoop-2.8.3/contrib/capacity-scheduler/*.jar:/home/schintap/hadoop-2.8.3/contrib/capacity-scheduler/*.jar

STORM_DIR="$ROOT/apache-storm-$STORM_VERSION"
REDIS_DIR="$ROOT/redis-$REDIS_VERSION"
KAFKA_DIR="$ROOT/kafka_$SCALA_BIN_VERSION-$KAFKA_VERSION"
FLINK_DIR="$ROOT/flink-$FLINK_VERSION"
SPARK_DIR="$ROOT/spark-$SPARK_VERSION-bin-hadoop2.7"

ZK_HOST="localhost"
ZK_PORT="2181"
ZK_CONNECTIONS="$ZK_HOST:$ZK_PORT"
TOPIC=${TOPIC:-"ad-events"}
PARTITIONS=${PARTITIONS:-5}
LOAD=${LOAD:-50000}
CONF_FILE="$ROOT/conf/localConf.yaml"
TEST_TIME=${TEST_TIME:-1800}
ADMIN_HOST=${ADMIN_HOST:-"stbl1230n00.blue.ygrid.yahoo.com"}
ZK_DIR=${ZK_DIR:-"/tmp/zookeeper/"}
PRODUCERS=${PRODUCERS:-10}

# TODO: May be there is a way to avoid touching yubikey for initial setup for few ops and yinst installs
# TODO: Replace for loops based on file list or env variables
setup_lein() {
  for i in {0..9};
  do
    scp ./lein stbl1230n0$i.blue.ygrid.yahoo.com:~
    ssh -o StrictHostKeyChecking=no -A `whoami`@stbl1230n0$i.blue.ygrid.yahoo.com 'mkdir -p ~/.lein/self-installs/'
    scp ./leiningen-2.9.3-standalone.jar stbl1230n0$i.blue.ygrid.yahoo.com:~/.lein/self-installs/
    ssh -o StrictHostKeyChecking=no -A `whoami`@stbl1230n0$i.blue.ygrid.yahoo.com 'sudo cp ~/lein /usr/local/bin'
    ssh -o StrictHostKeyChecking=no -A `whoami`@stbl1230n0$i.blue.ygrid.yahoo.com 'sudo chmod a+x /usr/local/bin/lein'
  done

  #mvn zip and upload
  # TODO: Replace for loops based on file list or env variables
  cd ~
  zip -r m2.zip .m2
  for i in {0..9};
  do
    scp m2.zip stbl1230n0$i.blue.ygrid.yahoo.com:~
    ssh -o StrictHostKeyChecking=no -A `whoami`@stbl1230n0$i.blue.ygrid.yahoo.com 'nohup unzip -o m2.zip > /dev/null 2>&1 &'
  done
  cd -
}

setup_yarn_cluster() {
  #zip -r ./hadoop-2.8.3.zip ./hadoop-2.8.3
  for i in {0..4};
  do
     #scp ./hadoop-2.8.3.zip stbl1230n0$i.blue.ygrid.yahoo.com:~
     scp ./hadoop.sh stbl1230n0$i.blue.ygrid.yahoo.com:~
     ssh -o StrictHostKeyChecking=no -A `whoami`@stbl1230n0$i.blue.ygrid.yahoo.com 'sudo mv ~/hadoop.sh /etc/profile.d/'
     ssh -o StrictHostKeyChecking=no -A `whoami`@stbl1230n0$i.blue.ygrid.yahoo.com 'sudo chmod 777 /etc/profile.d/hadoop.sh'
     ssh -o StrictHostKeyChecking=no -A `whoami`@stbl1230n0$i.blue.ygrid.yahoo.com 'nohup rm -rf ~/hadoop-2.8.3 > /dev/null 2>&1 &'
     ssh -o StrictHostKeyChecking=no -A `whoami`@stbl1230n0$i.blue.ygrid.yahoo.com 'nohup unzip -o ~/hadoop-2.8.3.zip > /dev/null 2>&1 &'
     ssh -o StrictHostKeyChecking=no -A `whoami`@stbl1230n0$i.blue.ygrid.yahoo.com 'nohup rm -rf /tmp/dfs > /dev/null 2>&1 &'
     ssh -o StrictHostKeyChecking=no -A `whoami`@stbl1230n0$i.blue.ygrid.yahoo.com 'nohup rm -rf /tmp/yarn > /dev/null 2>&1 &'
     ssh -o StrictHostKeyChecking=no -A `whoami`@stbl1230n0$i.blue.ygrid.yahoo.com 'nohup mkdir -p /tmp/dfs/namenode && chmod -R 777 /tmp/dfs/namenode > /dev/null 2>&1 &'
     ssh -o StrictHostKeyChecking=no -A `whoami`@stbl1230n0$i.blue.ygrid.yahoo.com 'nohup mkdir -p /tmp/dfs/journal/node/local/data && chmod -R 777 /tmp/dfs/journal > /dev/null 2>&1 &'
     ssh -o StrictHostKeyChecking=no -A `whoami`@stbl1230n0$i.blue.ygrid.yahoo.com 'nohup mkdir -p /tmp/dfs/data && chmod -R 777 /tmp/dfs/data > /dev/null 2>&1 &'
     ssh -o StrictHostKeyChecking=no -A `whoami`@stbl1230n0$i.blue.ygrid.yahoo.com 'nohup mkdir -p /tmp/yarn/nm-local-dir && chmod -R 777 /tmp/yarn/nm-local-dir > /dev/null 2>&1 &'
     ssh -o StrictHostKeyChecking=no -A `whoami`@stbl1230n0$i.blue.ygrid.yahoo.com 'nohup mkdir -p /tmp/yarn/nm-log && chmod -R 777 /tmp/yarn/nm-log > /dev/null 2>&1 &'
  done
}

stop_yarn_cluster() {
  ssh -o StrictHostKeyChecking=no -A `whoami`@stbl1230n00.blue.ygrid.yahoo.com "nohup $HADOOP_PREFIX/sbin/stop-dfs.sh && sleep 10 > /dev/null &"
  #for i in {1..4};
  #do
  #  ssh -o StrictHostKeyChecking=no -A `whoami`@stbl1230n0$i.blue.ygrid.yahoo.com "nohup $HADOOP_HOME/sbin/hadoop-daemon.sh stop journalnode > /dev/null &"
  #  sleep 10
  #done
  #for i in {1..2};
  #do
  #  ssh -o StrictHostKeyChecking=no -A `whoami`@stbl1230n0$i.blue.ygrid.yahoo.com "nohup $HADOOP_HOME/sbin/yarn-daemon.sh --config $HADOOP_HOME/etc/hadoop stop resourcemanager && sleep 10 > /dev/null &"
  #done
  #for i in {1..4};
  #do
  #  ssh -o StrictHostKeyChecking=no -A `whoami`@stbl1230n0$i.blue.ygrid.yahoo.com "nohup $HADOOP_HOME/sbin/yarn-daemon.sh --config $HADOOP_HOME/etc/hadoop stop nodemanager && sleep 10 > /dev/null &"
  #done
  ssh -o StrictHostKeyChecking=no -A `whoami`@stbl1230n00.blue.ygrid.yahoo.com "nohup $HADOOP_PREFIX/sbin/stop-yarn.sh && sleep 10 > /dev/null &"
  ssh -o StrictHostKeyChecking=no -A `whoami`@stbl1230n01.blue.ygrid.yahoo.com "nohup $HADOOP_HOME/sbin/yarn-daemon.sh --config $HADOOP_HOME/etc/hadoop stop resourcemanager && sleep 10 > /dev/null &"


}

start_yarn_cluster() {
  #for i in {1..4};
  #do
  #  ssh -o StrictHostKeyChecking=no -A `whoami`@stbl1230n0$i.blue.ygrid.yahoo.com "nohup $HADOOP_HOME/sbin/hadoop-daemon.sh start journalnode > /dev/null &"
  #  sleep 10
  #done

  #for i in {1..2};
  #do
  ssh -o StrictHostKeyChecking=no -A `whoami`@stbl1230n01.blue.ygrid.yahoo.com "nohup $HADOOP_PREFIX/bin/hdfs namenode -format> /dev/null &"
  #  sleep 10
  #done

  #ssh -o StrictHostKeyChecking=no -A `whoami`@stbl1230n01.blue.ygrid.yahoo.com "nohup $HADOOP_PREFIX/bin/hdfs zkfc -formatZK > /dev/null &"

  #for i in {1..4};
  #do
  #  ssh -o StrictHostKeyChecking=no -A `whoami`@stbl1230n01.blue.ygrid.yahoo.com "nohup $HADOOP_HOME/sbin/hadoop-daemon.sh stop journalnode > /dev/null &"
  #  sleep 10
  #done
  #ssh -o StrictHostKeyChecking=no -A `whoami`@stbl1230n00.blue.ygrid.yahoo.com "nohup $HADOOP_PREFIX/bin/hdfs dfsadmin -report && sleep 10 > /dev/null &"
  #for i in {1..2};
  #do
  ssh -o StrictHostKeyChecking=no -A `whoami`@stbl1230n00.blue.ygrid.yahoo.com "nohup $HADOOP_PREFIX/sbin/start-dfs.sh && sleep 10 > /dev/null &"
  ssh -o StrictHostKeyChecking=no -A `whoami`@stbl1230n01.blue.ygrid.yahoo.com "nohup $HADOOP_HOME/sbin/yarn-daemon.sh --config $HADOOP_HOME/etc/hadoop start resourcemanager && sleep 10 > /dev/null &"
  #done
  #for i in {1..4};
  #do
  #  ssh -o StrictHostKeyChecking=no -A `whoami`@stbl1230n0$i.blue.ygrid.yahoo.com "nohup $HADOOP_HOME/sbin/yarn-daemon.sh --config $HADOOP_HOME/etc/hadoop start nodemanager && sleep 10 > /dev/null &"
  #done
  ssh -o StrictHostKeyChecking=no -A `whoami`@stbl1230n00.blue.ygrid.yahoo.com "nohup $HADOOP_PREFIX/sbin/start-yarn.sh && sleep 10 > /dev/null &"
}

setup_zookeeper_quorum() {
  # TODO: Replace for loops based on file list or env variables
  for i in {5..7};
  #for i in {5..5};
  do
    # Required for zookeeper server id's
    ZK_ID=`expr $i - 4`
    ssh -o StrictHostKeyChecking=no -A `whoami`@stbl1230n0$i.blue.ygrid.yahoo.com "rm -rf $ZK_DIR"
    ssh -o StrictHostKeyChecking=no -A `whoami`@stbl1230n0$i.blue.ygrid.yahoo.com "mkdir -p $ZK_DIR"
    ssh -o StrictHostKeyChecking=no -A `whoami`@stbl1230n0$i.blue.ygrid.yahoo.com "echo $ZK_ID > $ZK_DIR/myid"
  done
}

setup_kafka_instances() {
  # TODO: Replace for loops based on file list or env variables
  for i in {5..9};
  #for i in {5..5};
  do
    scp ./server.properties stbl1230n0$i.blue.ygrid.yahoo.com:$KAFKA_DIR/config/
    BROKER_ID=`expr $i - 5`
    ssh -o StrictHostKeyChecking=no -A `whoami`@stbl1230n0$i.blue.ygrid.yahoo.com "sed -i -e s/broker.id=0/broker.id=$BROKER_ID/ $KAFKA_DIR/config/server.properties > /dev/null 2>&1 &"
    ssh -o StrictHostKeyChecking=no -A `whoami`@stbl1230n0$i.blue.ygrid.yahoo.com "rm -rf /tmp/kafka-logs > /dev/null 2>&1 &"
  done
}

start_zookeeper_quorum() {
  # TODO: Replace for loops based on file list or env variables
  for i in {5..7};
  #for i in {5..5};
  do
    echo "Starting zookeeper on host stbl1230n0$i.blue.ygrid.yahoo.com"
    ssh -o StrictHostKeyChecking=no -A `whoami`@stbl1230n0$i.blue.ygrid.yahoo.com "JAVA_HOME=$YJAVA_HOME nohup $KAFKA_DIR/bin/zookeeper-server-start.sh $KAFKA_DIR/config/zookeeper.properties > /dev/null 2>&1 &"
  done
}

stop_zookeeper_quorum() {
  for i in {5..7};
  #for i in {5..5};
  do
    ssh -o StrictHostKeyChecking=no -A `whoami`@stbl1230n0$i.blue.ygrid.yahoo.com "nohup sh $ROOT/stream-bench.sh STOP_ZK > /dev/null 2>&1 &"
  done
}

create_kafka_topic() {
  ssh -o StrictHostKeyChecking=no -A `whoami`@stbl1230n05.blue.ygrid.yahoo.com "JAVA_HOME=$YJAVA_HOME nohup $KAFKA_DIR/bin/kafka-topics.sh --create --zookeeper $ZK_CONNECTIONS --replication-factor 1 --partitions $PARTITIONS --topic $TOPIC > /dev/null 2>&1 &"
}

start_kafka_instances() {
  # TODO: Replace for loops based on file list or env variables
  for i in {5..9};
  #for i in {5..5};
  do
    echo "Starting kafka instance on host stbl1230n0$i.blue.ygrid.yahoo.com"
    ssh -o StrictHostKeyChecking=no -A `whoami`@stbl1230n0$i.blue.ygrid.yahoo.com "JAVA_HOME=$YJAVA_HOME nohup $KAFKA_DIR/bin/kafka-server-start.sh $KAFKA_DIR/config/server.properties > /dev/null 2>&1 &"
  done
  create_kafka_topic
}

stop_kafka_instances() {
  for i in {5..9};
  #for i in {5..5};
  do
    ssh -o StrictHostKeyChecking=no -A `whoami`@stbl1230n0$i.blue.ygrid.yahoo.com "KAFKA_DIR=$KAFKA_DIR JAVA_HOME=$YJAVA_HOME nohup sh $ROOT/stream-bench.sh STOP_KAFKA > /dev/null 2>&1 &"
  done
}

# Storm start and stop
start_storm_cluster() {
  ssh -o StrictHostKeyChecking=no -A `whoami`@$ADMIN_HOST "JAVA_HOME=$YJAVA_HOME nohup $STORM_DIR/bin/storm nimbus > /dev/null 2>&1 &"
  ssh -o StrictHostKeyChecking=no -A `whoami`@$ADMIN_HOST "JAVA_HOME=$YJAVA_HOME nohup $STORM_DIR/bin/storm ui > /dev/null 2>&1 &"
  ssh -o StrictHostKeyChecking=no -A `whoami`@$ADMIN_HOST "JAVA_HOME=$YJAVA_HOME nohup $STORM_DIR/bin/storm logviewer > /dev/null 2>&1 &"
  ssh -o StrictHostKeyChecking=no -A `whoami`@stbl1230n01.blue.ygrid.yahoo.com "JAVA_HOME=$YJAVA_HOME nohup $STORM_DIR/bin/storm supervisor > /dev/null 2>&1 &"
  #ssh -o StrictHostKeyChecking=no -A `whoami`@stbl1230n02.blue.ygrid.yahoo.com "JAVA_HOME=$YJAVA_HOME nohup $STORM_DIR/bin/storm supervisor > /dev/null 2>&1 &"
}

start_storm_topology() {
  ssh -o StrictHostKeyChecking=no -A `whoami`@$ADMIN_HOST "JAVA_HOME=$YJAVA_HOME nohup $STORM_DIR/bin/storm jar $ROOT/storm-benchmarks/target/storm-benchmarks-0.1.0.jar storm.benchmark.AdvertisingTopology test-topo -conf $CONF_FILE > /dev/null 2>&1"
  sleep 15
}

stop_storm_topology() {
  ssh -o StrictHostKeyChecking=no -A `whoami`@$ADMIN_HOST "JAVA_HOME=$YJAVA_HOME nohup $STORM_DIR/bin/storm kill -w 0 test-topo  > /dev/null 2>&1 &"
  sleep 10
}

start_trident_storm_topology() {
  ssh -o StrictHostKeyChecking=no -A `whoami`@$ADMIN_HOST "JAVA_HOME=$YJAVA_HOME nohup $STORM_DIR/bin/storm jar $ROOT/storm-benchmarks/target/storm-benchmarks-0.1.0.jar storm.benchmark.AdvertisingTridentTopology test-topo -conf $CONF_FILE > /dev/null 2>&1"
  sleep 15
}

stop_trident_storm_topology() {
  ssh -o StrictHostKeyChecking=no -A `whoami`@$ADMIN_HOST "JAVA_HOME=$YJAVA_HOME nohup $STORM_DIR/bin/storm kill -w 0 test-topo  > /dev/null 2>&1 &"
  sleep 10
}

stop_storm_cluster() {
  ssh -o StrictHostKeyChecking=no -A `whoami`@$ADMIN_HOST "STORM_DIR=$STORM_DIR nohup sh $ROOT/stream-bench.sh STOP_STORM > /dev/null 2>&1 &"
  ssh -o StrictHostKeyChecking=no -A `whoami`@stbl1230n01.blue.ygrid.yahoo.com "STORM_DIR=$STORM_DIR nohup sh $ROOT/stream-bench.sh STOP_STORM > /dev/null 2>&1 &"
  #ssh -o StrictHostKeyChecking=no -A `whoami`@stbl1230n02.blue.ygrid.yahoo.com "STORM_DIR=$STORM_DIR nohup sh $ROOT/stream-bench.sh STOP_STORM > /dev/null 2>&1 &"
}

# Flink start and stop
# Add slots in slave config file for flink
start_flink_cluster() {
  ssh -o StrictHostKeyChecking=no -A `whoami`@$ADMIN_HOST "JAVA_HOME=$YJAVA_HOME nohup $FLINK_DIR/bin/start-cluster.sh > /dev/null 2>&1 &"
}

stop_flink_cluster() {
  ssh -o StrictHostKeyChecking=no -A `whoami`@$ADMIN_HOST "JAVA_HOME=$YJAVA_HOME nohup $FLINK_DIR/bin/stop-cluster.sh > /dev/null 2>&1 &"
}

start_flink_topology() {
  ssh -o StrictHostKeyChecking=no -A `whoami`@$ADMIN_HOST "JAVA_HOME=$YJAVA_HOME nohup $FLINK_DIR/bin/flink run $ROOT/flink-benchmarks/target/flink-benchmarks-0.1.0.jar --confPath $CONF_FILE > /dev/null 2>&1 &"
  echo "Starting flink topology"
}

stop_flink_topology() {
  ssh -o StrictHostKeyChecking=no -A `whoami`@$ADMIN_HOST "JAVA_HOME=$YJAVA_HOME FLINK_DIR=$FLINK_DIR nohup sh $ROOT/stream-bench.sh STOP_FLINK_PROCESSING > /dev/null 2>&1 &"
  echo "Stopping flink topology"
}

start_flink_yarn_topology() {
  echo "Starting flink yarn topology"
  #ssh -o StrictHostKeyChecking=no -A `whoami`@$ADMIN_HOST "JAVA_HOME=$YJAVA_HOME HADOOP_CLASSPATH=$HADOOP_CLASSPATH nohup $FLINK_DIR/bin/yarn-session.sh -jm 1024m -tm 374000m"
  #ssh -o StrictHostKeyChecking=no -A `whoami`@$ADMIN_HOST "JAVA_HOME=$YJAVA_HOME HADOOP_CLASSPATH=$HADOOP_CLASSPATH nohup $FLINK_DIR/bin/yarn-session.sh -jm 1024m -tm 374000m > /dev/null 2>&1 &"
  #ssh -o StrictHostKeyChecking=no -A `whoami`@$ADMIN_HOST "JAVA_HOME=$YJAVA_HOME HADOOP_CLASSPATH=$HADOOP_CLASSPATH nohup $FLINK_DIR/bin/flink run -m yarn-cluster -ys 144 -yjm 1024m -ytm 374000m $ROOT/flink-benchmarks/target/flink-benchmarks-0.1.0.jar --confPath $CONF_FILE > /dev/null 2>&1 &"
  ssh -o StrictHostKeyChecking=no -A `whoami`@$ADMIN_HOST "JAVA_HOME=$YJAVA_HOME HADOOP_CLASSPATH=$HADOOP_CLASSPATH nohup $FLINK_DIR/bin/flink run -m yarn-cluster $ROOT/flink-benchmarks/target/flink-benchmarks-0.1.0.jar --confPath $CONF_FILE > /dev/null 2>&1 &"
  sleep 30
}

start_spark_yarn_topology() {
  echo "Starting spark on yarn topology"
  echo "Starting ss topology"
   JARS="/tmp/ss_jars/com.github.luben_zstd-jni-1.4.4-3.jar,/tmp/ss_jars/org.apache.commons_commons-pool2-2.6.2.jar,/tmp/ss_jars/org.apache.kafka_kafka-clients-2.4.1.jar,/tmp/ss_jars/org.apache.spark_spark-token-provider-kafka-0-10_2.12-3.0.0.jar,/tmp/ss_jars/org.apache.spark_spark-sql-kafka-0-10_2.12-3.0.0.jar,/tmp/ss_jars/org.spark-project.spark_unused-1.0.0.jar,/tmp/ss_jars/org.slf4j_slf4j-api-1.7.30.jar,/tmp/ss_jars/org.lz4_lz4-java-1.7.1.jar,/tmp/ss_jars/org.xerial.snappy_snappy-java-1.1.7.5.jar"
  #ssh -o StrictHostKeyChecking=no `whoami`@$ADMIN_HOST "JAVA_HOME=$YJAVA_HOME HADOOP_CONF_DIR=/home/schintap/hadoop-2.8.3/etc/hadoop HADOOP_CLASSPATH=$HADOOP_CLASSPATH nohup $SPARK_DIR/bin/spark-submit --class spark.benchmark.structuredstreaming.KafkaRedisSSContinuousAdvertisingStream --master yarn --deploy-mode cluster --num-executors 1 --conf spark.executor.memory=340000m --conf spark.executor.cores=72 --jars $JARS $ROOT/spark-ss-benchmarks/target/spark-ss-benchmarks-0.1.0.jar $CONF_FILE > /dev/null 2>&1 &"
   ssh -o StrictHostKeyChecking=no `whoami`@$ADMIN_HOST "JAVA_HOME=$YJAVA_HOME HADOOP_HOME=/home/schintap/hadoop-2.8.3 HADOOP_CONF_DIR=/home/schintap/hadoop-2.8.3/etc/hadoop HADOOP_CLASSPATH=$HADOOP_CLASSPATH nohup $SPARK_DIR/bin/spark-submit --class spark.benchmark.structuredstreaming.KafkaRedisSSContinuousAdvertisingStream --master yarn --deploy-mode cluster --num-executors 1 --conf spark.executor.memory=340000m --conf spark.executor.cores=72 --conf spark.driver.extraJavaOptions='-XX:+AggressiveOpts -XX:+UnlockDiagnosticVMOptions -XX:+UnlockExperimentalVMOptions -XX:+TraceClassLoading' --conf spark.executor.extraJavaOptions='-XX:+AggressiveOpts -XX:+UnlockDiagnosticVMOptions -XX:+UnlockExperimentalVMOptions -XX:+TraceClassLoading' --jars $JARS $ROOT/spark-ss-benchmarks/target/spark-ss-benchmarks-0.1.0.jar $CONF_FILE > /dev/null 2>&1 &"
  #ssh -o StrictHostKeyChecking=no `whoami`@$ADMIN_HOST "nohup $SPARK_DIR/bin/spark-submit --master spark://localhost:7077 -jars $JARS --conf spark.executor.memory=384000m --conf spark.executor.cores=72 --conf spark.executor.extraJavaOptions=-XX:+TraceClassUnloading --conf spark.driver.extraJavaOptions=-XX:+TraceClassUnloading --class spark.benchmark.structuredstreaming.KafkaRedisSSContinuousAdvertisingStream $ROOT/spark-ss-benchmarks/target/spark-ss-benchmarks-0.1.0.jar $CONF_FILE > /dev/null 2>&1 &"
  #ssh -o StrictHostKeyChecking=no `whoami`@$ADMIN_HOST "nohup $SPARK_DIR/bin/spark-submit --master yarn -jars $JARS --conf spark.executor.memory=384000m --conf spark.executor.cores=72 --conf spark.executor.extraJavaOptions=-XX:+TraceClassUnloading --conf spark.driver.extraJavaOptions=-XX:+TraceClassUnloading --class spark.benchmark.structuredstreaming.KafkaRedisSSContinuousAdvertisingStream $ROOT/spark-ss-benchmarks/target/spark-ss-benchmarks-0.1.0.jar $CONF_FILE > /dev/null 2>&1 &"
  #ssh -o StrictHostKeyChecking=no `whoami`@$ADMIN_HOST "nohup $SPARK_DIR/bin/spark-submit --master yarn -jars $JARS --num-executors 1 --conf spark.executor.memory=374000m --conf spark.executor.cores=72 --class spark.benchmark.structuredstreaming.KafkaRedisSSContinuousAdvertisingStream $ROOT/spark-ss-benchmarks/target/spark-ss-benchmarks-0.1.0.jar $CONF_FILE > /dev/null 2>&1 &"
  sleep 30
}

test_ssh() {
    OP="SPARK_YARN"
    setup_yarn_cluster
    start_yarn_cluster
    run_streaming_job 50000 $OP worker1
   #start_flink_yarn_topology
   #start_yarn_cluster
   #JARS="/tmp/ss_jars/com.github.luben_zstd-jni-1.4.4-3.jar,/tmp/ss_jars/org.apache.commons_commons-pool2-2.6.2.jar,/tmp/ss_jars/org.apache.kafka_kafka-clients-2.4.1.jar,/tmp/ss_jars/org.apache.spark_spark-token-provider-kafka-0-10_2.12-3.0.0.jar,/tmp/ss_jars/org.apache.spark_spark-sql-kafka-0-10_2.12-3.0.0.jar,/tmp/ss_jars/org.spark-project.spark_unused-1.0.0.jar,/tmp/ss_jars/org.slf4j_slf4j-api-1.7.30.jar,/tmp/ss_jars/org.lz4_lz4-java-1.7.1.jar,/tmp/ss_jars/org.xerial.snappy_snappy-java-1.1.7.5.jar"


   #ssh -o StrictHostKeyChecking=no `whoami`@$ADMIN_HOST "JAVA_HOME=$YJAVA_HOME HADOOP_HOME=/home/schintap/hadoop-2.8.3 HADOOP_CONF_DIR=/home/schintap/hadoop-2.8.3/etc/hadoop HADOOP_CLASSPATH=$HADOOP_CLASSPATH nohup $SPARK_DIR/bin/spark-submit --class spark.benchmark.structuredstreaming.KafkaRedisSSContinuousAdvertisingStream --master yarn --deploy-mode cluster --num-executors 1 --conf spark.executor.memory=340000m --conf spark.executor.cores=72 --jars $JARS $ROOT/spark-ss-benchmarks/target/spark-ss-benchmarks-0.1.0.jar $CONF_FILE"

   #stop_yarn_cluster
   #ssh -o StrictHostKeyChecking=no -A `whoami`@stbl1230n01.blue.ygrid.yahoo.com 'nohup rm -rf ~/hadoop-2.8.3'
   #ssh -o StrictHostKeyChecking=no -A `whoami`@$ADMIN_HOST "JAVA_HOME=$YJAVA_HOME HADOOP_CLASSPATH=$HADOOP_CLASSPATH nohup $FLINK_DIR/bin/flink run -m yarn-cluster -ys 72 -yjm 1024m -ytm 374000m $ROOT/flink-benchmarks/target/flink-benchmarks-0.1.0.jar --confPath $CONF_FILE"
}

stop_flink_yarn_topology() {
  ssh -o StrictHostKeyChecking=no -A `whoami`@$ADMIN_HOST "JAVA_HOME=$YJAVA_HOME FLINK_DIR=$FLINK_DIR nohup sh $ROOT/stream-bench.sh STOP_FLINK_YARN_PROCESSING > /dev/null 2>&1 &"
  sleep 30
  ssh -o StrictHostKeyChecking=no -A `whoami`@stbl1230n00.blue.ygrid.yahoo.com "nohup killall java && killall java && sleep 10 > /dev/null &"
  echo "Stopping flink yarn topology"
}

stop_spark_yarn_topology() {
  ssh -o StrictHostKeyChecking=no -A `whoami`@stbl1230n00.blue.ygrid.yahoo.com "nohup killall java && killall java && sleep 10 > /dev/null &"
  echo "Stopping spark yarn topology"
}

# Spark start and stop
# Check if we have slave config file
start_spark_cluster() {
  if [[ "BEAM" = $1 ]];
  then
    SPARK_VERSION=2.4.6
    SPARK_DIR="$ROOT/spark-$SPARK_VERSION-bin-hadoop2.7"
  fi
  printf "export JAVA_HOME=$YJAVA_HOME\nexport SPARK_HOME=$SPARK_DIR\nexport SPARK_CONF_DIR=$SPARK_DIR/conf" > ./bashrc
  for i in {0..9};
  do
    scp ./bashrc stbl1230n0$i.blue.ygrid.yahoo.com:~
    ssh -o StrictHostKeyChecking=no -A `whoami`@stbl1230n0$i.blue.ygrid.yahoo.com "nohup mv bashrc ~/.bashrc > /dev/null 2>&1 &"
  done
  ssh -o StrictHostKeyChecking=no -A `whoami`@$ADMIN_HOST "JAVA_HOME=$YJAVA_HOME SPARK_HOME=$SPARK_DIR SPARK_CONF_DIR=$SPARK_HOME/conf nohup sh $SPARK_DIR/sbin/start-master.sh -h localhost -p 7077 > /dev/null 2>&1 &"
  sleep 30
  ssh -o StrictHostKeyChecking=no `whoami`@stbl1230n00.blue.ygrid.yahoo.com "JAVA_HOME=$YJAVA_HOME SPARK_HOME=$SPARK_DIR SPARK_CONF_DIR=$SPARK_HOME/conf nohup sh $SPARK_DIR/sbin/start-slave.sh spark://localhost:7077 > /dev/null 2>&1 &"
  sleep 30
}

stop_spark_cluster() {
  ssh -o StrictHostKeyChecking=no `whoami`@stbl1230n00.blue.ygrid.yahoo.com "JAVA_HOME=$YJAVA_HOME nohup sh $ROOT/stream-bench.sh STOP_SPARK  > /dev/null 2>&1 &"
}

start_spark_topology() {
  ssh -o StrictHostKeyChecking=no `whoami`@$ADMIN_HOST "nohup $SPARK_DIR/bin/spark-submit --master spark://localhost:7077 --conf spark.executor.memory=384000m --conf spark.executor.cores=72 --class spark.benchmark.dstream.KafkaRedisDStreamAdvertisingStream $ROOT/spark-dstream-benchmarks/target/spark-dstream-benchmarks-0.1.0.jar $CONF_FILE > /dev/null 2>&1 &"
}

stop_spark_topology() {
  ssh -o StrictHostKeyChecking=no `whoami`@$ADMIN_HOST "JAVA_HOME=$YJAVA_HOME nohup sh $ROOT/stream-bench.sh STOP_DSTREAM_SPARK_PROCESSING > /dev/null 2>&1 &"
}

start_ss_spark_topology() {
  echo "Starting ss topology"
  JARS="/home/schintap/ss_jars/com.github.luben_zstd-jni-1.4.4-3.jar,\
/home/schintap/ss_jars/org.apache.commons_commons-pool2-2.6.2.jar,\
/home/schintap/ss_jars/org.apache.kafka_kafka-clients-2.4.1.jar,\
/home/schintap/ss_jars/org.apache.spark_spark-sql-kafka-0-10_2.12-3.0.0.jar,\
/home/schintap/ss_jars/org.apache.spark_spark-token-provider-kafka-0-10_2.12-3.0.0.jar,\
/home/schintap/ss_jars/org.lz4_lz4-java-1.7.1.jar,\
/home/schintap/ss_jars/org.slf4j_slf4j-api-1.7.30.jar,\
/home/schintap/ss_jars/org.spark-project.spark_unused-1.0.0.jar,\
/home/schintap/ss_jars/org.xerial.snappy_snappy-java-1.1.7.5.jar"
  #ssh -o StrictHostKeyChecking=no `whoami`@$ADMIN_HOST "nohup $SPARK_DIR/bin/spark-submit --master spark://localhost:7077 -jars $JARS --conf spark.executor.memory=384000m --conf spark.executor.cores=72 --conf spark.executor.extraJavaOptions=-XX:+TraceClassUnloading --conf spark.driver.extraJavaOptions=-XX:+TraceClassUnloading --class spark.benchmark.structuredstreaming.KafkaRedisSSContinuousAdvertisingStream $ROOT/spark-ss-benchmarks/target/spark-ss-benchmarks-0.1.0.jar $CONF_FILE > /dev/null 2>&1 &"
  ssh -o StrictHostKeyChecking=no `whoami`@$ADMIN_HOST "nohup $SPARK_DIR/bin/spark-submit --master spark://localhost:7077 -jars $JARS --conf spark.executor.memory=384000m --conf spark.executor.cores=72 --conf spark.executor.extraJavaOptions=-XX:+TraceClassUnloading --conf spark.driver.extraJavaOptions=-XX:+TraceClassUnloading --class spark.benchmark.structuredstreaming.KafkaRedisSSContinuousAdvertisingStream $ROOT/spark-ss-benchmarks/target/spark-ss-benchmarks-0.1.0.jar $CONF_FILE > /dev/null 2>&1 &"
}

stop_ss_spark_topology() {
  ssh -o StrictHostKeyChecking=no `whoami`@$ADMIN_HOST "JAVA_HOME=$YJAVA_HOME nohup sh stream-bench.sh STOP_SS_SPARK_PROCESSING  > /dev/null 2>&1 &"
}

start_beam_spark_topology() {
  SPARK_VERSION=2.4.6
  SPARK_DIR="$ROOT/spark-$SPARK_VERSION-bin-hadoop2.7"
  ssh -o StrictHostKeyChecking=no `whoami`@$ADMIN_HOST "nohup $SPARK_DIR/bin/spark-submit --master spark://localhost:7077 --conf spark.executor.memory=384000m --conf spark.executor.cores=72 --class apache.beam.AdvertisingBeamStream $ROOT/apache-beam-validator/target/apache-beam-validator-0.1.0.jar --runner=SparkRunner --batchIntervalMillis=3000 --beamConf=/home/schintap/streaming-benchmarks/conf/localConf.yaml  > /dev/null 2>&1 &"
  echo "Starting beam flink topology"
}

stop_beam_spark_topology() {
  ssh -o StrictHostKeyChecking=no `whoami`@$ADMIN_HOST "JAVA_HOME=$YJAVA_HOME nohup sh $ROOT/stream-bench.sh STOP_BEAM_SPARK_PROCESSING > /dev/null 2>&1 &"
}

start_beam_flink_topology() {
  FLINK_VERSION=1.9.0
  FLINK_DIR="$ROOT/flink-$FLINK_VERSION"
  ssh -o StrictHostKeyChecking=no `whoami`@$ADMIN_HOST  "JAVA_HOME=$YJAVA_HOME FLINK_DIR=$FLINK_DIR nohup $FLINK_DIR/bin/flink run -c apache.beam.AdvertisingBeamStream $ROOT/apache-beam-validator/target/apache-beam-validator-0.1.0.jar --runner=FlinkRunner --streaming --parallelism=72 --beamConf=/home/schintap/streaming-benchmarks/conf/localConf.yaml > /dev/null 2>&1 &"
}

stop_beam_flink_topology() {
  ssh -o StrictHostKeyChecking=no `whoami`@$ADMIN_HOST "JAVA_HOME=$YJAVA_HOME FLINK_DIR=$FLINK_DIR nohup sh $ROOT/stream-bench.sh STOP_BEAM_FLINK_PROCESSING  > /dev/null 2>&1 &"
}

start_redis() {
  # Using yum package manager to install available 3.x redis version on grid
  # Latest redis 6.x runs into issues with instruction sets on ylinux box
  ssh -o StrictHostKeyChecking=no -A `whoami`@$ADMIN_HOST "sudo yum -y install redis > /dev/null 2>&1 &"
  stop_redis
  # Disable protected mode for it to be accessible from across the nodes
  ssh -o StrictHostKeyChecking=no -A `whoami`@$ADMIN_HOST "redis-server --protected-mode no > /dev/null 2>&1 &"
  create_redis_campaigns
}

create_redis_campaigns() {
  # Cleanup redis and create new campaigns
  echo "Creating new campaigns in redis"
  ssh -o StrictHostKeyChecking=no -A `whoami`@$ADMIN_HOST "cd $ROOT/data && ROOT=$ROOT JAVA_CMD=$YJAVA_HOME/bin/java nohup lein run -n --configPath $ROOT/conf/localConf.yaml > /dev/null 2>&1 &"
}

stop_redis() {
  ssh -o StrictHostKeyChecking=no -A `whoami`@$ADMIN_HOST "nohup sh $ROOT/stream-bench.sh STOP_REDIS > /dev/null 2>&1 &"
}

start_load() {
  LOAD=`expr $1 / $PRODUCERS`
  # Create result dir
  dt=`date -u`
  test=`echo $1" "$2" "$dt | tee -a ysar_timestamps.txt`
  create_redis_campaigns
  if [[ "STORM" = "$2" ]];
  then
    stop_storm_topology
    start_storm_topology
  elif [[ "TRIDENT_STORM" = "$2" ]];
  then
    stop_trident_storm_topology
    start_trident_storm_topology
  elif [[ "FLINK" = "$2" ]];
  then
    stop_flink_topology
    start_flink_topology
  elif [[ "FLINK_YARN" = "$2" ]];
  then
    stop_flink_yarn_topology
    start_flink_yarn_topology
  elif [[ "SPARK_YARN" = "$2" ]];
  then
    stop_spark_yarn_topology
    start_spark_yarn_topology
  elif [[ "SPARK" = "$2" ]];
  then
    stop_spark_topology
    start_spark_topology
  elif [[ "SS_SPARK" = "$2" ]];
  then
    start_ss_spark_topology
    stop_ss_spark_topology
  elif [[ "BEAM_FLINK" = "$2" ]];
  then
    stop_beam_flink_topology
    start_beam_flink_topology
  elif [[ "BEAM_SPARK" = $2 ]];
  then
    stop_beam_spark_topology
    start_beam_spark_topology
  fi

  ssh -o StrictHostKeyChecking=no -A `whoami`@$ADMIN_HOST "nohup mkdir -p ~/results/$2/$1/$3 > /dev/null 2>&1 &"

  echo "Generating $1 events/sec"
  # Lets have five producers
  PRODS=`expr $PRODUCERS - 1`
  for i in $(seq 0 $PRODS);
  do
    echo "Starting producer $i on stbl1230n0$i.blue.ygrid.yahoo.com"
    ssh -o StrictHostKeyChecking=no -A `whoami`@stbl1230n0$i.blue.ygrid.yahoo.com "LOAD=$LOAD ROOT=$ROOT JAVA_CMD=$YJAVA_HOME/bin/java nohup sh $ROOT/stream-bench.sh START_LOAD > /dev/null 2>&1 &"
  done
}

stop_load() {
  PRODS=`expr $PRODUCERS - 1`
  for i in $(seq 0 $PRODS);
  do
    echo "Stopping producer $i on stbl1230n0$i.blue.ygrid.yahoo.com"
    ssh -o StrictHostKeyChecking=no -A `whoami`@stbl1230n0$i.blue.ygrid.yahoo.com "ROOT=$ROOT JAVA_CMD=$YJAVA_HOME/bin/java nohup sh $ROOT/stream-bench.sh STOP_LOAD > /dev/null 2>&1 &"
  done
}

init_setup() {
  echo "Commencing initial setup"
  rm -rf streaming-benchmarks*
  git clone git@git.ouroath.com:schintap/streaming-benchmarks.git -b bench_journey_cluster_setup
  cd streaming-benchmarks
  sh stream-bench.sh SETUP
  cd ..
  zip -r  streaming-benchmarks.zip streaming-benchmarks
  for i in {0..9};
  do
    scp streaming-benchmarks.zip stbl1230n0$i.blue.ygrid.yahoo.com:~
    ssh -o StrictHostKeyChecking=no -A `whoami`@stbl1230n0$i.blue.ygrid.yahoo.com "nohup rm -rf $ROOT > /dev/null 2>&1 &"
    ssh -o StrictHostKeyChecking=no -A `whoami`@stbl1230n0$i.blue.ygrid.yahoo.com "nohup unzip -o ~/streaming-benchmarks.zip > /dev/null 2>&1 &"
    # Already installed commenting it out
    #ssh -o StrictHostKeyChecking=no -A `whoami`@stbl1230n0$i.blue.ygrid.yahoo.com 'nohup yinst i yjava_jdk-8.0_8u252b09.5462251 > /dev/null 2>&1 &'
    #ssh -o StrictHostKeyChecking=no -A `whoami`@stbl1230n0$i.blue.ygrid.yahoo.com 'nohup yinst i yjava_maven > /dev/null 2>&1 &'
  done
  echo "Initial setup complete"
}

setup_configs() {
  for i in {0..9};
  do
    scp ./benchmarkConf.yaml stbl1230n0$i.blue.ygrid.yahoo.com:$ROOT/conf/
    scp ./localConf.yaml stbl1230n0$i.blue.ygrid.yahoo.com:$ROOT/conf/
    scp ./storm.yaml stbl1230n0$i.blue.ygrid.yahoo.com:$STORM_DIR/conf/storm.yaml
    scp ./zookeeper.properties stbl1230n0$i.blue.ygrid.yahoo.com:$KAFKA_DIR/config/
    scp ./flink_slaves stbl1230n0$i.blue.ygrid.yahoo.com:$FLINK_DIR/conf/
    scp ./flink-conf.yaml stbl1230n0$i.blue.ygrid.yahoo.com:$FLINK_DIR/conf/
    scp ./bashrc stbl1230n0$i.blue.ygrid.yahoo.com:~
    ssh -o StrictHostKeyChecking=no -A `whoami`@stbl1230n0$i.blue.ygrid.yahoo.com "mv bashrc ~/.bashrc"
    ssh -o StrictHostKeyChecking=no -A `whoami`@stbl1230n0$i.blue.ygrid.yahoo.com "mv $FLINK_DIR/conf/flink_slaves $FLINK_DIR/conf/slaves"
    scp ./spark_slaves stbl1230n0$i.blue.ygrid.yahoo.com:$SPARK_DIR/conf/
    ssh -o StrictHostKeyChecking=no -A `whoami`@stbl1230n0$i.blue.ygrid.yahoo.com "mv $SPARK_DIR/conf/spark_slaves $SPARK_DIR/conf/slaves"
    scp ./spark-env.sh stbl1230n0$i.blue.ygrid.yahoo.com:$SPARK_DIR/conf/
  done
}

stop_and_clean() {
  # Stop load first
  stop_load
  if [[ "STORM" = "$2" ]];
  then
    # wait for few minutes for storm to catch up may be 30 seconds
    sleep 120
    echo "Stopping Storm topology and clean up"
    stop_storm_topology
  elif [[ "TRIDENT_STORM" = "$2" ]];
  then
    sleep 120
    echo "Stopping Storm Trident topology and clean up"
    stop_trident_storm_topology
  elif [[ "FLINK" = "$2" ]];
  then
    sleep 120
    echo "Stopping Flink topology and clean up"
    stop_flink_topology
  elif [[ "FLINK_YARN" = "$2" ]];
  then
    sleep 120
    echo "Stopping Flink Yarn topology and clean up"
    stop_flink_yarn_topology
  elif [[ "SPARK_YARN" = "$2" ]];
  then
    sleep 120
    echo "Stopping Spark Yarn topology and clean up"
    stop_spark_yarn_topology
  elif [[ "SPARK" = "$2" ]];
  then
    sleep 120
    echo "Stopping Spark topology and clean up"
    stop_spark_topology
  elif [[ "SS_SPARK" = "$2" ]];
  then
    sleep 120
    echo "Stopping SS Spark topology and clean up"
    stop_ss_spark_topology
  elif [[ "BEAM_FLINK" = "$2" ]];
  then
    sleep 120
    echo "Stopping Beam Flink topology and clean up"
    stop_beam_flink_topology
  elif [[ "BEAM_SPARK" = "$2" ]];
  then
    sleep 120
    echo "Stopping Beam Spark topology and clean up"
    stop_beam_spark_topology
  fi

  # Wait for messages to clean up retention period expiry 15 min retention
  # This way we dont have to stop kafka hosts and restart them
  #sleep 900


  stop_kafka_instances
  stop_zookeeper_quorum
  stop_redis
  setup_zookeeper_quorum
  setup_kafka_instances
  start_redis
  start_zookeeper_quorum
  start_kafka_instances

  # move results for graphs seen/updated to results/s<framework>/load/seen,updated
  ssh -o StrictHostKeyChecking=no -A `whoami`@$ADMIN_HOST "nohup mv $ROOT/data/seen.txt ~/results/$2/$1/$3/  > /dev/null 2>&1 &"
  ssh -o StrictHostKeyChecking=no -A `whoami`@$ADMIN_HOST "nohup mv $ROOT/data/updated.txt ~/results/$2/$1/$3/ > /dev/null 2>&1 &"
}

run_streaming_job() {
  echo "$1:$2:$3"
  start_load $1 $2 $3
  sleep $TEST_TIME
  #sleep 300
  stop_and_clean $1 $2 $3
  #if [[ "STORM" = $2 ]];
  #then
  #  ADMIN_HOST="stbl1230n01.blue.ygrid.yahoo.com"
  #fi
  #collect_ysar_stats $1 $2 $ADMIN_HOST
}

collect_ysar_stats() {
  ssh -o StrictHostKeyChecking=no -A `whoami`@$3 "nohup mkdir -p ~/ysar_stats > /dev/null 2>&1 &"
  ssh -o StrictHostKeyChecking=no -A `whoami`@$3 "nohup ysar -int 5 > ~/ysar_stats/ysar_$2_$1 &"
}

run() {
  OP=$1
  WRKS=$2
  if [[ "SETUP" = "$OP" ]];
  then
    echo "Setup initialized"
    #init_setup
    #setup_configs
    #setup_lein
    #collect_ysar_stats 50000 STORM $ADMIN_HOST
    setup_zookeeper_quorum
    setup_yarn_cluster
    setup_zookeeper_quorum
    setup_kafka_instances
    start_redis
    start_zookeeper_quorum
    start_kafka_instances
  elif [[ "SSH_TEST" = "$OP" ]];
  then
    test_ssh
  elif [[ "STOP_LOAD" = "$OP" ]];
  then
    echo "Stopping Load"
    stop_load
  elif [[ "SETUP_CONFIGS" = "$OP" ]];
  then
    setup_configs
  elif [[ "DRYRUN" = "$OP" ]];
  then
    start_storm_cluster
    run_streaming_job 50000 "STORM"
    stop_storm_cluster
    start_flink_cluster
    run_streaming_job 50000 "FLINK"
    stop_flink_cluster
    start_flink_cluster
    run_streaming_job 50000 "BEAM_FLINK"
    stop_flink_cluster
    start_spark_cluster
    run_streaming_job 50000 "SPARK"
    stop_spark_cluster
    start_spark_cluster
    run_streaming_job 50000 "SS_SPARK"
    stop_spark_cluster
    start_spark_cluster
    run_streaming_job 50000 "BEAM_SPARK"
    stop_spark_cluster
  elif [[ "RUN_STORM_SUITE" = "$OP" ]];
  then
    echo "Running storm benchmark suite..."
    OP="STORM"
    start_storm_cluster
    #run_streaming_job 50000 $OP
    #run_streaming_job 70000 $OP
    run_streaming_job 90000 $OP
    run_streaming_job 110000 $OP
    run_streaming_job 130000 $OP
    run_streaming_job 135000 $OP
    run_streaming_job 150000 $OP
    run_streaming_job 170000 $OP
    stop_storm_cluster
    echo "Storm benchmark suite completed..."
  elif [[ "RUN_TRIDENT_STORM_SUITE" = "$OP" ]];
  then
    echo "Running storm benchmark suite..."
    OP="TRIDENT_STORM"
    start_storm_cluster
    run_streaming_job 50000 $OP
    stop_storm_cluster

    start_storm_cluster
    run_streaming_job 70000 $OP
    stop_storm_cluster

    start_storm_cluster
    run_streaming_job 90000 $OP
    stop_storm_cluster

    start_storm_cluster
    run_streaming_job 110000 $OP
    stop_storm_cluster

    start_storm_cluster
    run_streaming_job 130000 $OP
    stop_storm_cluster

    start_storm_cluster
    run_streaming_job 150000 $OP
    stop_storm_cluster

    start_storm_cluster
    run_streaming_job 170000 $OP
    stop_storm_cluster

    echo "Storm benchmark suite completed..."
  elif [[ "RUN_FLINK_SUITE" = "$OP" ]];
  then
    echo "Running Flink benchmark suite..."
    OP="FLINK"
    start_flink_cluster
    run_streaming_job 50000 $OP
    run_streaming_job 70000 $OP
    run_streaming_job 90000 $OP
    run_streaming_job 110000 $OP
    run_streaming_job 130000 $OP
    run_streaming_job 135000 $OP
    run_streaming_job 150000 $OP
    run_streaming_job 170000 $OP
    stop_flink_cluster
  elif [[ "RUN_FLINK_YARN_SUITE" = "$OP" ]];
  then
    echo "Running Flink on Yarn benchmark suite..."
    OP="FLINK_YARN"
    setup_yarn_cluster
    start_yarn_cluster
    run_streaming_job 50000 $OP $WRKS
    stop_yarn_cluster

    setup_yarn_cluster
    start_yarn_cluster
    run_streaming_job 70000 $OP $WRKS
    stop_yarn_cluster

    setup_yarn_cluster
    start_yarn_cluster
    run_streaming_job 90000 $OP $WRKS
    stop_yarn_cluster

    setup_yarn_cluster
    start_yarn_cluster
    run_streaming_job 110000 $OP $WRKS
    stop_yarn_cluster

    setup_yarn_cluster
    start_yarn_cluster
    run_streaming_job 130000 $OP $WRKS
    stop_yarn_cluster

    setup_yarn_cluster
    start_yarn_cluster
    run_streaming_job 135000 $OP $WRKS
    stop_yarn_cluster

    setup_yarn_cluster
    start_yarn_cluster
    run_streaming_job 150000 $OP $WRKS
    stop_yarn_cluster

    setup_yarn_cluster
    start_yarn_cluster
    run_streaming_job 170000 $OP $WRKS
    stop_yarn_cluster
    elif [[ "RUN_SPARK_YARN_SUITE" = "$OP" ]];
  then
    echo "Running Spark on Yarn benchmark suite..."
    OP="SPARK_YARN"
    setup_yarn_cluster
    start_yarn_cluster
    run_streaming_job 50000 $OP $WRKS
    stop_yarn_cluster

    setup_yarn_cluster
    start_yarn_cluster
    run_streaming_job 70000 $OP $WRKS
    stop_yarn_cluster

    setup_yarn_cluster
    start_yarn_cluster
    run_streaming_job 90000 $OP $WRKS
    stop_yarn_cluster

    setup_yarn_cluster
    start_yarn_cluster
    run_streaming_job 110000 $OP $WRKS
    stop_yarn_cluster

    setup_yarn_cluster
    start_yarn_cluster
    run_streaming_job 130000 $OP $WRKS
    stop_yarn_cluster

    setup_yarn_cluster
    start_yarn_cluster
    run_streaming_job 135000 $OP $WRKS
    stop_yarn_cluster

    setup_yarn_cluster
    start_yarn_cluster
    run_streaming_job 150000 $OP $WRKS
    stop_yarn_cluster

    setup_yarn_cluster
    start_yarn_cluster
    run_streaming_job 170000 $OP $WRKS
    stop_yarn_cluster
  elif [[ "RUN_SPARK_SUITE" = "$OP" ]];
  then
    echo "Running Spark benchmark suite..."
    OP="SPARK"
    start_spark_cluster
    run_streaming_job 50000 $OP
    run_streaming_job 70000 $OP
    run_streaming_job 90000 $OPZ
    run_streaming_job 110000 $OP
    run_streaming_job 130000 $OP
    run_streaming_job 135000 $OP
    run_streaming_job 150000 $OP
    run_streaming_job 170000 $OP
    stop_spark_cluster
  elif [[ "RUN_SS_SPARK_SUITE" = "$OP" ]];
  then
    echo "Running Spark benchmark suite..."
    OP="SS_SPARK"
    start_spark_cluster
    run_streaming_job 50000 $OP
    run_streaming_job 70000 $OP
    run_streaming_job 90000 $OP
    run_streaming_job 110000 $OP
    run_streaming_job 130000 $OP
    run_streaming_job 135000 $OP
    run_streaming_job 150000 $OP
    run_streaming_job 170000 $OP
    stop_spark_cluster
  elif [[ "RUN_SPARK_BEAM_SUITE" = "$OP" ]];
  then
    echo "Running Spark benchmark suite..."
    export SPARK_VERSION=2.4.6
    OP="BEAM_SPARK"
    start_spark_cluster BEAM
    run_streaming_job 50000 $OP
    run_streaming_job 70000 $OP
    run_streaming_job 90000 $OP
    run_streaming_job 130000 $OP
    run_streaming_job 135000 $OP
    run_streaming_job 150000 $OP
    run_streaming_job 170000 $OP
    stop_spark_cluster
  elif [[ "RUN_FLINK_BEAM_SUITE" = "$OP" ]];
  then
   echo "Running Beam Flink benchmark suite..."
   export FLINK_VERSION=1.9.0
   OP="BEAM_FLINK"
   start_flink_cluster
   run_streaming_job 50000 $OP
   run_streaming_job 70000 $OP
   run_streaming_job 90000 $OP
   run_streaming_job 110000 $OP
   run_streaming_job 130000 $OP
   run_streaming_job 135000 $OP
   run_streaming_job 150000 $OP
   run_streaming_job 170000 $OP
   stop_flink_cluster
  elif [[ "STOP_ALL" = "$OP" ]];
  then
    stop_yarn_cluster
    stop_kafka_instances
    stop_zookeeper_quorum
    stop_redis
  else
    echo "Note: You can run this from your mac or admin host stbl1230n00.blue.ygrid.yahoo.com"
    echo "Storm -> sh setup_cluster.sh RUN_STORM_SUITE"
    echo "Storm -> sh setup_cluster.sh RUN_TRIDENT_STORM_SUITE"
    echo "Spark -> sh setup_cluster.sh RUN_SPARK_SUITE"
    echo "SS Spark -> sh setup_cluster.sh RUN_SS_SPARK_SUITE"
    echo "Flink -> sh setup_cluster.sh RUN_FLINK_SUITE"
    echo "Flink on Yarn -> sh setup_cluster.sh RUN_FLINK_YARN_SUITE"
    echo "Flink on Yarn -> sh setup_cluster.sh RUN_SPARK_YARN_SUITE"
    echo "Beam Flink -> sh setup_cluster.sh RUN_FLINK_BEAM_SUITE"
    echo "Beam Spark -> sh setup_cluster.sh RUN_SPARK_BEAM_SUITE"
    echo "Dryrun to test setup, this runs all frameworks at 50000 events/s -> sh setup_cluster.sh DRYRUN"
    echo "Update configs and set up the cluster with new changes -> sh setup_cluster.sh SETUP_CONFIGS"
    echo "Stopping producers -> sh setup_cluster.sh STOP_LOAD"
    echo "Stopping kafka, quorum and other procs -> sh setup_cluster.sh STOP_ALL"
  fi
}

if [[ $# -lt 1 ]];
then
  run "HELP"
else
  while [[ $# -gt 0 ]];
  do
    run "$1" "$2"
    shift
  done
fi


