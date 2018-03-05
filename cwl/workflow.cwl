#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: Workflow
inputs:
  bamfile:
    type: File
  bedfile:
    type: File
  bamqc_pl:
    type: File
  flagstat2json:
    type: File

outputs:
  bamqc_json:
    type: File
    outputSource: bamqc/outjson
  flagstatjson:
    type: File
    outputSource: flagstat_json/flagstat_json

steps:
  flagstat:
    run: flagstat.cwl
    in:
      bamfile: bamfile
    out: [flagstat_file]

  flagstat_json:
    run: flagstat2json.cwl
    in:
      flagstat_file: flagstat/flagstat_file
      flagstat2json: flagstat2json
    out: [flagstat_json]

  bamqc:
    run: bamqc.cwl
    in:
      bamfile: bamfile
      bedfile: bedfile
      bamqc_pl: bamqc_pl
      xtra_json: flagstat_json/flagstat_json
    out: [ outjson ]
