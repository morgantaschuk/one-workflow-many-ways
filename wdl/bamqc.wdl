

workflow BamQC {
    String SAMTOOLS
    File BAMFILE

    call flagstat {
        input : samtools=SAMTOOLS, bamfile=BAMFILE
    }
    call bamqc { 
        input : samtools=SAMTOOLS, bamfile=BAMFILE, xtra_json=flagstat.flagstat_json
    }
}

task flagstat {
    String samtools
    File flagstat_to_json
    File bamfile
    String dollar="$"
    String outfile="flagstat.json"

    command {
        bash ${flagstat_to_json} ${samtools} ${bamfile} > ${outfile}
    }

    output {
        File flagstat_json = "${outfile}"
    }

}

task bamqc {
    String samtools
    File bamqc_pl
    File bamfile
    File bedfile
    String outjson
    String xtra_json

    command {
        eval '${samtools} view ${bamfile} | perl ${bamqc_pl} -r ${bedfile} -j "${xtra_json}" > ${outjson}'
    }
    output {
        File out = "${outjson}"
    }
}

