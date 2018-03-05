class: CommandLineTool
cwlVersion: v1.0
doc: "Run bamqc"
requirements:
  - class: ShellCommandRequirement


hints:
  SoftwareRequirement:
    packages:
      samtools:
        specs: [ "https://identifiers.org/rrid/RRID:SCR_002105" ]
        version: [ "0.1.19+" ]


inputs:
  bamfile:
    type: File
  bamqc_pl:
    type: File
  bedfile:
    type: File
  xtra_json:
    type: File?
    inputBinding:
      position: 1

stdout: bamqc_result.json
outputs:
  outjson:
    type: stdout

arguments:
  - samtools
  - view
  - {valueFrom: $(inputs.bamfile)}
  - {valueFrom: " | ", shellQuote: false}
  - perl
  - {valueFrom: $(inputs.bamqc_pl)}
  - -r
  - {valueFrom: $(inputs.bedfile)}
