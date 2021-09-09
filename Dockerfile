# HBase, Phoenix and Omid in Docker


# http://docs.docker.io/en/latest/use/builder/

FROM ubuntu:bionic

COPY *.sh /build/
COPY */*.sh /build/


ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64
ENV HBASE_VERSION 2.4.5
ENV HBASE_PHOENIX_VERSION 2.4
ENV PHOENIX_VERSION 5.1.2
ENV OMID_VERSION 1.0.2
ENV QUERYSERVER_VERSION 6.0.0
ENV PHOENIX_CLASS_PATH /opt/hbase/lib/:/opt/phoenix/
ENV HADOOP_CONF_DIR /opt/hbase/conf
ENV HBASE_CONF_DIR "$HADOOP_CONF_DIR"
ENV PHOENIX_LIB_DIR /opt/phoenix
ENV OMID_DIR /opt/omid

CMD java -XX:+PrintFlagsFinal $JAVA_OPTIONS -jar java-container.jar

VOLUME /data

ADD ./config-files/changes.patch /changes.patch

RUN /build/prepare-omid.sh
RUN /build/prepare-hbase.sh
RUN /build/prepare-phoenix.sh
RUN cd /opt/hbase && /build/build-hbase.sh
RUN cd / && /build/build-phoenix.sh
RUN /build/build-omid.sh

ADD ./config-files/hbase-site.xml /opt/hbase/conf/hbase-site.xml

ADD ./config-files/hbase-site.xml /opt/phoenix/hbase-site.xml

ADD ./config-files/zoo.cfg /opt/hbase/conf/zoo.cfg

ADD ./config-files/hbase-omid-client-config.yml /opt/hbase/conf/hbase-omid-client-config.yml

ADD ./opdb-start /opt/opdb-start

ADD ./phoenix/phoenix-sqlline /bin/phoenix-sqlline

ADD ./phoenix/phoenix-sqlline-thin /bin/phoenix-sqlline-thin

RUN /build/clean.sh
RUN rm -rf /build

# REST API
EXPOSE 8080
# REST Web UI at :8085/rest.jsp
EXPOSE 8085
# Phoenix querry server
EXPOSE 8765
# Thrift API
EXPOSE 9090
# Thrift Web UI at :9095/thrift.jsp
EXPOSE 9095
# HBase's Embedded zookeeper cluster
EXPOSE 2181
# HBase Master web UI at :16010/master-status;  ZK at :16010/zk.jsp
EXPOSE 16010
# Hbase Master
EXPOSE 16000
# Regions servers
EXPOSE 16020
#Regionserver UI
EXPOSE 16030


ENTRYPOINT ["/opt/opdb-start"]
