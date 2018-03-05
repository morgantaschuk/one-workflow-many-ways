#!/bin/bash

set -eo pipefail

#get the directory that this script is in
#no matter where it's called from
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

BAM="${DIR}/bamqc/t/test/neat_5x_EX_hg19_chr21.bam"
BED="${DIR}/bamqc/t/test/SureSelect_All_Exon_V4_Covered_Sorted_chr21.bed"

# 1: bam; 2: bed
bash "${DIR}/bash/bamqc.sh" "${BAM}" "${BED}"

