#!/bin/bash

set -eo pipefail

#get the directory that this script is in
#no matter where it's called from
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# install cwltool
virtualenv -p python3 venv
source venv/bin/activate
pip install 'cwltool[deps]'


# run
cwltool "${DIR}/cwl/workflow.cwl" "${DIR}/cwl/local_workflow.yml"
