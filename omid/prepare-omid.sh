#!/bin/sh -xe

. /build/config.sh

apt-get update

apt-get install $OMID_BUILD_PACKEGES -y
update-alternatives --set java /usr/lib/jvm/java-8-openjdk-amd64/jre/bin/java
