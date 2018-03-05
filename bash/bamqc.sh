#!/bin/bash

set -eo pipefail

BAM=$1
BED=$2
OUT="$(basename $BAM).json"
FLAGSTAT="$(basename $BAM)_flagstat.json"

# samtools flagstat, convert to 'json' format
echo "{ $(samtools flagstat "${BAM}" 2>&1 | perl -pe 's|(\d+ \+ \d+)\s+(.*)\R|"$2": "$1",|g' | sed 's/.$//') }" > "${FLAGSTAT}"

# run bamqc
samtools view "${BAM}" | perl bamqc/bamqc.pl -r "${BED}" -j "${FLAGSTAT}" > "${OUT}" 2> "${OUT}.stdout"

echo "Wrote to ${OUT}"
