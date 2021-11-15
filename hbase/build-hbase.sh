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

here=$(pwd)

# delete files that are not needed to run hbase
rm -rf docs *.txt LEGAL
rm -f */*.cmd

# Set Java home for hbase servers
sed -i "s,^. export JAVA_HOME.*,export JAVA_HOME=$JAVA_HOME," conf/hbase-env.sh
#make sure hbase will start in distributed mode but zookeeper is 1 daemon and no mneed for ssh
sed -E -i 's/(.*)hbase\-daemons\.sh(.*zookeeper)/\1hbase-daemon.sh\2/g' bin/start-hbase.sh
# Set interactive shell defaults
cat > /etc/profile.d/defaults.sh <<EOF
JAVA_HOME=$JAVA_HOME
export JAVA_HOME
EOF

cd /usr/bin
ln -sf $here/bin/* .
