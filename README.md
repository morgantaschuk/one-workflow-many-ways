# one-workflow-many-ways
Implementing bamqc over and over again to get an idea of how easy or hard it is for a beginner to implement a basic workflow in different workflow systems.

## The Workflow

1. Run `samtools flagstat` and perform some command-line operations to turn it into a JSON file
2. Run `bamqc.pl`, a script we created in-house, in order to pull some stats about a BAM file. This step also takes in the JSON from the first step and includes it in the results.

An example result file is here: [results/neat_5x_EX_hg19_chr21.json](results/neat_5x_EX_hg19_chr21.json).

## Continuous Integration Misused

Rather than needing to re-install all the software dependencies for every workflow system all the time, I am misusing [TravisCI](https://travis-ci.org/) for this purpose. The base [.travis.yml](.travis.yml) installs the dependencies for the actual tools (see 'Requirements' below). Each of the 'run_X.sh' scripts in the root directory installs the dependencies for each workflow system and then actually launches the tools.

So far I have the following implemented:
- bash run with bash
- [Workflow Description Language (WDL)](https://software.broadinstitute.org/wdl/) run with [Cromwell](http://cromwell.readthedocs.io/en/develop/)
- [common workflow language (CWL)](https://github.com/common-workflow-language/common-workflow-language) run with [cwltool](https://github.com/common-workflow-language/cwltool)
- [common workflow language (CWL)](https://github.com/common-workflow-language/common-workflow-language) run with [Toil](https://toil.readthedocs.io)
- WDL with Toil: broken, see the wiki for details

See the last runs here: [![Build Status](https://travis-ci.org/morgantaschuk/one-workflow-many-ways.svg)](https://travis-ci.org/morgantaschuk/one-workflow-many-ways) https://travis-ci.org/morgantaschuk/one-workflow-many-ways

## Download

To clone this repository and get all the submodules

    git clone --recurse-submodules git@github.com:morgantaschuk/one-workflow-many-ways.git

## Requirements

This is only required if you plan to run this on your own machine. Most of the time I will be using TravisCI for the same (see above). See [.travis.yml](.travis.yml) for Ubuntu installation tips.

* perl 5.26+
* samtools
* R-base
* bamqc and gsi-website (git submodules) installed

## Run

Setup: `bash replacepaths.sh`

Then launch any of the `run_X.sh` commands. They take no arguments

**Bash**

    bash run_bash.sh

**CWL on cwltool**

    bash run_cwltool.sh

**WDL on Cromwell**

    bash run_cromwell.sh

**CWL on Toil**

    bash run_toil_cwl.sh


## Clean up all the things

The various workflow systems produces a *lot* of files in this directory. To torch 'em all, use:

    git clean -f -x

To refresh the submodules after something messes with them

    git submodule update --remote bamqc gsi-website

# Thoughts and Results

Check the wiki: https://github.com/morgantaschuk/one-workflow-many-ways/wiki
