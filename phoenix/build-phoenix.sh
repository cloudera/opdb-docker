#!/bin/sh -xe

. /build/config.sh

here=$(pwd)

# delete files that are not needed to run hbase
cd /opt
cp phoenix/phoenix-server-hbase-$HBASE_PHOENIX_VERSION-$PHOENIX_VERSION.jar /opt/hbase/lib
