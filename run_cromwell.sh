#!/bin/bash

set -eo pipefail

#get the directory that this script is in
#no matter where it's called from
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# requires Java JDK8
sudo apt-get install -qq oracle-java8-installer
jdk_switcher use oraclejdk8
# get cromwell if necessary
if [ ! -f cromwell-30.2.jar ]; then
    wget 'https://github.com/broadinstitute/cromwell/releases/download/30.2/cromwell-30.2.jar'
fi

# cromwell needs absolute paths, so replace the paths in the json file
perl -p -e "s|REPLACEME|${DIR}|g" "${DIR}/wdl/bamqc_inputs.json" > "${DIR}/wdl/local_bamqc_inputs.json"


java -jar cromwell-30.2.jar run -i "${DIR}/wdl/local_bamqc_inputs.json" "${DIR}/wdl/bamqc.wdl"

