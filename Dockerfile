# Copyright 2021 Cloudera, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Apache HBase, Apache Phoenix and Apache Omid in Docker

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

RUN /build/prepare-hbase.sh
RUN /build/prepare-phoenix.sh
RUN /build/prepare-omid.sh
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

# HBase REST API
EXPOSE 8080
# HBase REST Web UI at :8085/rest.jsp
EXPOSE 8085
# Phoenix Query Server
EXPOSE 8765
# HBase Thrift API
EXPOSE 9090
# HBase Thrift Web UI at :9095/thrift.jsp
EXPOSE 9095
# HBase's Embedded zookeeper cluster
EXPOSE 2181
# HBase Master web UI at :16010/master-status;  ZK at :16010/zk.jsp
EXPOSE 16010
# Hbase Master
EXPOSE 16000
# RegionsServers
EXPOSE 16020
# RegionServer UI
EXPOSE 16030


ENTRYPOINT ["/opt/opdb-start"]
