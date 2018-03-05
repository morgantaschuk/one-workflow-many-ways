#!/bin/bash

set -eo pipefail

# install cwltool
virtualenv -p python3 venv
source venv/bin/activate
pip install 'cwltool[deps]'

#get the directory that this script is in
#no matter where it's called from
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# cwltool needs absolute paths, so replace the paths in the json file
perl -p -e "s|REPLACEME|${DIR}|g" "${DIR}/cwl/workflow.yml" > "${DIR}/cwl/local_workflow.yml"

# run
cwltool "${DIR}/cwl/workflow.cwl" "${DIR}/cwl/local_workflow.yml"
