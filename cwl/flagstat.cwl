cwlVersion: v1.0
class: CommandLineTool

hints:
  SoftwareRequirement:
    packages:
      samtools:
        specs: [ "https://identifiers.org/rrid/RRID:SCR_002105" ]
        version: [ "0.1.19+" ]

inputs:
  - id: bamfile
    type: File
    inputBinding:
      position: 1
outputs:
  - id: flagstat_file
    type: stdout

arguments:
  - samtools
  - flagstat
