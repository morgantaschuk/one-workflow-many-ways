#!/bin/bash

set -eo pipefail

#get the directory that this script is in
#no matter where it's called from
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# requires Java JDK8
# https://stackoverflow.com/questions/7334754/correct-way-to-check-java-version-from-bash-script
JAVA_VER=$(java -version 2>&1 | sed -n ';s/.* version "\(.*\)\.\(.*\)\..*"/\1\2/p;')
if [ ! "$JAVA_VER" -ge 18 ]; then 
    sudo apt-get install -qq oracle-java8-installer oracle-java8-set-default
fi
# get cromwell if necessary
if [ ! -f cromwell-30.2.jar ]; then
    wget 'https://github.com/broadinstitute/cromwell/releases/download/30.2/cromwell-30.2.jar'
fi

java -jar cromwell-30.2.jar run -i "${DIR}/wdl/local_bamqc_inputs.json" "${DIR}/wdl/bamqc.wdl"

