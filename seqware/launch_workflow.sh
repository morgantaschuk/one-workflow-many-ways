#!/bin/bash 

set -eo pipefail

#Intending this to be run on the Docker container

export PERL5LIB="$PERL5LIB:/mnt/workflows/gsi-website/gsi-website/lib:/mnt/workflows/bamqc/lib"

seqware bundle launch --dir /mnt/workflows/seqware/target/Workflow_Bundle_BamQC_1.0_SeqWare_1.1.0 --no-metadata \
            --override bamfile="/mnt/workflows/bamqc/t/test/neat_5x_EX_hg19_chr21.bam" \
            --override bedfile="/mnt/workflows/bamqc/t/test/SureSelect_All_Exon_V4_Covered_Sorted_chr21.bed" \
            --override flagstat2json="/mnt/workflows/flagstat2json.sh" \
            --override bamqc_pl="/mnt/workflows/bamqc/bamqc.pl" \
            --override output_prefix="/mnt/datastore/"
