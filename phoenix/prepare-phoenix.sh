#!/bin/sh -xe

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

. /build/config.sh

apt-get update -y
apt-get install $minimal_apt_get_args $PHOENIX_BUILD_PACKAGES

cd /opt/

curl -SL $PHOENIX_DIST/phoenix-$PHOENIX_VERSION/phoenix-hbase-$HBASE_PHOENIX_VERSION-$PHOENIX_VERSION-bin.tar.gz | tar -x -z

mv phoenix-hbase-$HBASE_PHOENIX_VERSION-$PHOENIX_VERSION-bin phoenix

curl -SL $PHOENIX_DIST/phoenix-queryserver-$QUERYSERVER_VERSION/phoenix-queryserver-$QUERYSERVER_VERSION-bin.tar.gz | tar -x -z

cp -R phoenix-queryserver-*/* phoenix
