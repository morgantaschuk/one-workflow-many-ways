#!/bin/bash

set -eo pipefail

# install cwltool
virtualenv -p python2 venv
source venv/bin/activate
pip install cwlref-runner

#get the directory that this script is in
#no matter where it's called from
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# cwltool needs absolute paths, so replace the paths in the json file
perl -p -e "s|REPLACEME|${DIR}|g" "${DIR}/cwl/bamqc.yml" > "${DIR}/cwl/local_bamqc.yml"

# run
cwl-runner "${DIR}/cwl/bamqc.cwl" "${DIR}/cwl/local_bamqc.yml"
