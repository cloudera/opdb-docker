# OPDB Docker
===============

This configuration builds a docker container to run Apache HBase, Apache Zookeeper, Apache Omid and Apache Phoenix.


Before you begin
-----------
Run

    $ sudo vim /etc/hosts
    
and add
    
    127.0.0.1       localhost opdb-docker


It is recommended to run the container with at least the following resources:
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

    $ docker run -p 8765:8765 -p 8080:8080 -p 8085:8085 -p 9090:9090 -p 9095:9095 -p 2181:2181 -p 16010:16010 -p 16020:16020 -p 16000:16000 -p 16030:16030 -d -h "opdb-docker"  --name opdb-docker opdb-docker

You can log in to the docker and run Apache Phoenix or Apache Hbase
---------

    $ docker exec -it opdb-docker /bin/bash

    $ phoenix-sqlline

    $ hbase shell


Thrift and REST server
---------

Thrift or REST servers are not started by default, but You can start them easily by running:

    $ docker exec opdb-docker /opt/hbase/bin/hbase-daemon.sh start thrift

or

    $ docker exec opdb-docker /opt/hbase/bin/hbase-daemon.sh start rest

Similarly You can stop them with:

    $ docker exec opdb-docker /opt/hbase/bin/hbase-daemon.sh stop thrift

or

    $ docker exec opdb-docker /opt/hbase/bin/hbase-daemon.sh stop rest

