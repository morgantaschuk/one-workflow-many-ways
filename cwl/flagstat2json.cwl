cwlVersion: v1.0
class: CommandLineTool
inputs:
  - id: flagstat_file
    type: File
    inputBinding:
      position: 1
  - id: flagstat2json
    type: File

outputs:
  - id: flagstat_json
    type: stdout

arguments:
  - bash
  - {valueFrom: $(inputs.flagstat2json)}
