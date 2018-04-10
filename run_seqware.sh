#!/bin/bash

set -eo pipefail

#get the directory that this script is in
#no matter where it's called from
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
#for caching purposes, make sure there is a local .m2 directory
MVN_REPO="${HOME}/.m2"
[ -d "${MVN_REPO}" ] || mkdir -p "${MVN_REPO}"

#Build the workflow
docker run -it --rm -v "${DIR}/seqware":/usr/src/workflow -v "${MVN_REPO}":/root/.m2 -w /usr/src/workflow maven:3.3-jdk-8 mvn clean install

mkdir -p "${DIR}/seqware_datastore" && chmod a+wrx "${DIR}/seqware_datastore"

docker run --rm -h master -t -v "${DIR}":"/mnt/workflows" -v "${DIR}/seqware_datastore":"/mnt/datastore" -i seqware/seqware_whitestar:1.1.2-java8 \
    bash /mnt/workflows/seqware/launch_workflow.sh
