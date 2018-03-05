#!/bin/bash

set -eo pipefail

# install cwltool
virtualenv -p python2 venv
source venv/bin/activate
pip install 'toil[cwl]'

#get the directory that this script is in
#no matter where it's called from
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# run CWL
toil-cwl-runner "${DIR}/cwl/workflow.cwl" "${DIR}/cwl/local_workflow.yml"
