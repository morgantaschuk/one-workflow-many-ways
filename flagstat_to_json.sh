#!/bin/bash

set -euo pipefail

SAMTOOLS=$1
BAM=$2


echo "{ $($SAMTOOLS flagstat $BAM 2>&1 | perl -pe 's|(\d+ \+ \d+)\s+(.*)\R|"$2": "$1",|g' | sed 's/.$//') }"
