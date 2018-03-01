#!/bin/bash

set -eo pipefail

# requires Java JDK8

# get cromwell if necessary
if [ ! -f cromwell-30.2.jar ]; then
    wget 'https://github.com/broadinstitute/cromwell/releases/download/30.2/cromwell-30.2.jar'
fi

# cromwell needs absolute paths, so replace the paths in the json file
perl -p -e "s|REPLACEME|$(pwd)|g" 'wdl/bamqc_inputs.json' > 'wdl/local_bamqc_inputs.json'


java -jar cromwell-30.2.jar run -i 'wdl/local_bamqc_inputs.json' 'wdl/bamqc.wdl'

