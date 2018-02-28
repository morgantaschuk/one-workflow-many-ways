# one-workflow-many-ways
Implementing bamqc over and over again


Requirements
* perl 5.26+
* samtools
* bamqc and gsi-website (git submodules) installed

To get all the dependencies

    git clone --recurse-submodules git@github.com:morgantaschuk/one-workflow-many-ways.git



WDL
===

The file wdl/bam_inputs.json needs to have the absolute paths specified or it chokes.

If everthing is installed correctly, this should work;

    java -jar ../cromwell/cromwell-30.1.jar run -i wdl/bamqc_inputs.json wdl/bamqc.wdl



