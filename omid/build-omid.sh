#!/bin/sh -xe

. /build/config.sh

cd /opt

curl -SL $PHOENIX_DIST/phoenix-omid-$OMID_VERSION/phoenix-omid-$OMID_VERSION-src.tar.gz | tar -x -z

cd phoenix-omid-$OMID_VERSION/tso-server

# patching to fix issue with jcommander. will be obsolete when $OMID_VERSION is updated to 1.0.3
# once Apache Omid 1.0.3 is released, this can be removed along with config-files/changes.patch
mv /changes.patch .
patch pom.xml changes.patch
rm -rf changes.patch

cd ..
mvn clean install -Phbase-2 -DskipTests


cd ..
mkdir omid
cp -r ./phoenix-omid-$OMID_VERSION/tso-server/target/omid-tso-server-hbase2.x-$OMID_VERSION-bin.tar.gz omid
cd omid
tar xzf omid-tso-server-hbase2.x-$OMID_VERSION-bin.tar.gz
cp -r omid-tso-server-hbase2.x-$OMID_VERSION/* .
chmod +x /opt/omid/bin/omid.sh
