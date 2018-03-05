#!/bin/bash

set -eo pipefail

# install cwltool
virtualenv -p python3 venv
source venv/bin/activate
pip install 'toil[wdl]'

#get the directory that this script is in
#no matter where it's called from
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# run WDL
toil-wdl-runner "${DIR}/wdl/bamqc.wdl" "${DIR}/wdl/local_bamqc_inputs.json"
