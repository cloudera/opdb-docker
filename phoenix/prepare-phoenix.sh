#!/bin/sh -xe

. /build/config.sh

apt-get update -y
apt-get install $minimal_apt_get_args $PHOENIX_BUILD_PACKAGES

cd /opt/

curl -SL $PHOENIX_DIST/phoenix-$PHOENIX_VERSION/phoenix-hbase-$HBASE_PHOENIX_VERSION-$PHOENIX_VERSION-bin.tar.gz | tar -x -z

mv phoenix-hbase-$HBASE_PHOENIX_VERSION-$PHOENIX_VERSION-bin phoenix

curl -SL https://apache.claz.org/phoenix/phoenix-queryserver-$QUERYSERVER_VERSION/phoenix-queryserver-$QUERYSERVER_VERSION-bin.tar.gz | tar -x -z

cp -R phoenix-queryserver-*/* phoenix
