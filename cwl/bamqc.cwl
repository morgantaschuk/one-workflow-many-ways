class: CommandLineTool
cwlVersion: v1.0
doc: "Run bamqc"
requirements:
  - class: ShellCommandRequirement
inputs:
  samtools:
    type: string
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

stdout: thing.json
outputs:
  outjson:
    type: stdout

arguments:
  - {valueFrom: $(inputs.samtools)}
  - view
  - {valueFrom: $(inputs.bamfile)}
  - {valueFrom: " | ", shellQuote: false}
  - perl
  - {valueFrom: $(inputs.bamqc_pl)}
  - -r
  - {valueFrom: $(inputs.bedfile)}
