#!/bin/bash

set -e

export HOME="/github/workspace"
chmod +x "/usr/src/kafka-gitops"

# If a working directory is detected as input
if [ -n "$INPUT_WORKINGDIRECTORY" ]
then
  cd "$INPUT_WORKINGDIRECTORY"
fi

# Do stuff
message=$(/usr/src/kafka-gitops -f state.yaml --no-delete plan)
echo "::set-output name=plan_output::$message"

# If a working directory is detected as input, revert to the
# original directory before continuing with the workflow
if [ -n "$INPUT_WORKINGDIRECTORY" ]
then
  cd $HOME
fi
