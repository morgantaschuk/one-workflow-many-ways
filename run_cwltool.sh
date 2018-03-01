#!/bin/bash

set -eo pipefail

# install cwltool
virtualenv -p python2 venv
source venv/bin/activate
pip install cwlref-runner

# cwltool needs absolute paths, so replace the paths in the json file
perl -p -e "s|REPLACEME|$(pwd)|g" 'cwl/bamqc.yml' > 'cwl/local_bamqc.yml'

# run
cwl-runner 'cwl/bamqc.cwl' 'cwl/local_bamqc.yml'
