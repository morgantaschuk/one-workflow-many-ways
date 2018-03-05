#!/bin/bash

set -eo pipefail

# This needs to stay in the root of one-workflow-many-ways

#get the directory that this script is in
#no matter where it's called from
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# the inputs need absolute paths, so replace the paths in the json file
perl -p -e "s|REPLACEME|${DIR}|g" "${DIR}/cwl/workflow.yml" > "${DIR}/cwl/local_workflow.yml"
perl -p -e "s|REPLACEME|${DIR}|g" "${DIR}/wdl/bamqc_inputs.json" > "${DIR}/wdl/local_bamqc_inputs.json"

