#!/bin/bash

set -euo pipefail

# Usage: flagstat2json.sh FILE_flagstat.txt
# Usage: samtools flagstat FILE | flagstat2json.sh

FLAGSTAT=""

#read in either from a file or stdin
while read line
do
   FLAGSTAT="${FLAGSTAT}$(echo $line | perl -pe 's|(\d+ \+ \d+)\s+(.*)\R|"$2": "$1",|g')"
done < "${1:-/dev/stdin}"

#trim the last comma
OUT=$(echo ${FLAGSTAT} |  sed 's/.$//')

#put braces around the whole thing
echo "{${OUT}}"
