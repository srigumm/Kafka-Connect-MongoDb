#
# Copyright 2018 Confluent Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

FROM confluentinc/cp-kafka-connect:5.2.1

#Set the environment variable
ENV CONNECT_PLUGIN_PATH="/usr/share/java,/usr/share/confluent-hub-components"

#Install your plugin
RUN confluent-hub install --no-prompt hpgrahsl/kafka-connect-mongodb:1.3.1

WORKDIR /usr/share/confluent-hub-components
COPY src/kafka-mongodb-connector/MongoDbSinkConnector.properties /usr/

#Note: Here, we have put all required settings into one file, you can seggregate these into worker properties file and connector property file.
WORKDIR /usr
ENTRYPOINT ["./bin/connect-standalone", "/usr/MongoDbSinkConnector.properties", "/usr/MongoDbSinkConnector.properties"]
