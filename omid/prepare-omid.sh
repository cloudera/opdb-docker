#!/bin/sh -xe

apt-get update
apt-get install maven -y

#apt-get install $OMID_BUILD_PACKEGES
apt-get install openjdk-8-jdk -y
update-alternatives --set java /usr/lib/jvm/java-8-openjdk-amd64/jre/bin/java

apt-get install git -y
