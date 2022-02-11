# OPDB Docker

This configuration builds a docker container to run Apache HBase, Apache Zookeeper, Apache Omid and Apache Phoenix.

Prerequisites
-----------
Run

    $ sudo vim /etc/hosts
    
and add
    
    127.0.0.1       localhost opdb-docker


The opdb-docker runs many services in the same container so it is recommended to increase the Docker resource configuration under Preferences > Resources to the following:
* CPUs: 6
* Memory: 10 GB
* Swap: 1.5 GB
* Disk image size: 64 GB

Setting smaller amounts may cause issues with memory allocation.

Build Image
-----------

    $ docker build -t opdb-docker .


Run OPDB docker
---------

    $ docker run -p 8765:8765 -p 8080:8080 -p 8085:8085 -p 9090:9090 \
        -p 9095:9095 -p 2181:2181 -p 16010:16010 -p 16020:16020 -p 16000:16000 \
        -p 16030:16030 -d -h "opdb-docker"  --name opdb-docker opdb-docker

You can log in to the docker and run Apache Phoenix or Apache Hbase
---------

    $ docker exec -it opdb-docker /bin/bash
    $ phoenix-sqlline
    $ hbase shell


HBase Thrift and REST servers
---------

HBase Thrift and HBase REST servers are not started automatically. To start them run the following commands:

    $ docker exec opdb-docker /opt/hbase/bin/hbase-daemon.sh start thrift
    $ docker exec opdb-docker /opt/hbase/bin/hbase-daemon.sh start rest

Similarly stop these services with:

    $ docker exec opdb-docker /opt/hbase/bin/hbase-daemon.sh stop thrift
    $ docker exec opdb-docker /opt/hbase/bin/hbase-daemon.sh stop rest

