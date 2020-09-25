#!/bin/bash

set -e

export HOME="/github/workspace"
chmod +x "/usr/local/bin/kafka-gitops"

export KAFKA_SECURITY_PROTOCOL="SASL_SSL"
export KAFKA_SASL_MECHANISM="PLAIN"
export KAFKA_SSL_ENDPOINT_IDENTIFICATION_ALGORITHM="HTTPS"

export KAFKA_BOOTSTRAP_SERVERS="$INPUT_KAFKA_BOOTSTRAP_SERVERS"
export KAFKA_SASL_JAAS_USERNAME="$INPUT_KAFKA_SASL_JAAS_USERNAME"
export KAFKA_SASL_JAAS_PASSWORD="$INPUT_KAFKA_SASL_JAAS_PASSWORD"
export XX_CCLOUD_EMAIL="$INPUT_XX_CCLOUD_EMAIL"
export XX_CCLOUD_PASSWORD="$INPUT_XX_CCLOUD_PASSWORD"

# If a working directory is detected as input
if [ -n "$INPUT_WORKINGDIRECTORY" ]
then
  cd "$INPUT_WORKINGDIRECTORY"
fi

# Do stuff
#message=$(kafka-gitops -f state.yaml --no-delete plan)
message=$(kafka-gitops -f state.yaml validate)
echo "::set-output name=plan_output::$message"

# If a working directory is detected as input, revert to the
# original directory before continuing with the workflow
if [ -n "$INPUT_WORKINGDIRECTORY" ]
then
  cd $HOME
fi
