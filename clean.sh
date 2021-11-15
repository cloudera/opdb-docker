#!/bin/sh

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

AUTO_ADDED_PACKAGES=`apt-mark showauto`

#apt-get remove --purge -y $HBASE_BUILD_PACKAGES $AUTO_ADDED_PACKAGES

# Install the run-time dependencies
apt-get install $minimal_apt_get_args $HBASE_RUN_PACKAGES

rm -rf /tmp/* /var/tmp/*

apt-get clean
rm -rf /var/lib/apt/lists/*


rm -rf /opt/*.tar.gz
rm -rf /root/.m2/
rm -rf /opt/omid/omid-tso-server-hbase2.x-*-bin.tar.gz
rm -rf /opt/phoenix-omid-*/tso-server/target/omid-tso-server-hbase2.x-*-bin.tar.gz
rm -rf /opt/phoenix-omid-*/examples/target/omid-examples-*-bin.tar.gz
rm -rf /opt/phoenix-omid-*/benchmarks/target/omid-benchmarks-*-bin.tar.gz
