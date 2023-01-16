<p align="center">
  <img width="300"  src="https://raw.githubusercontent.com/banijolly/genepi-box/main/logo.png">
</p>

## About
<b>Gen</b>etic <b>Epi</b>demiology in a <b>Box</b><br> 
genepi-box is a tool developed for automating genome assembly and analysis of SARS-CoV-2 genomes to aid epidemiology and surveillance.<br>
<br>
The tool takes in as input:<br>
- A zip file (in .zip format) for paired-end short read sequencing data files (FASTQ files) of SARS-CoV-2 samples <br>
- The sample sheet used for demultiplexing the sequencing run from BCL to FASTQ files (in .csv format)
- A metadata file containing details of the samples (a tab separated text file). A sample metadata file ([Metadata_Sample.tsv](https://github.com/banijolly/genepi-box/blob/main/Metadata_Sample.tsv)) is available in the repository. The header of the file (the first row) should remain the same. Second row of the sample metadata file contains examples of what values can be entered, this row can be deleted while adding new data. User can add their own data to the subsequent rows.
- A configuration file (text format) to set the options for running the analysis. A default configuration file ([config.txt](https://github.com/banijolly/genepi-box/blob/main/config.txt)) is available in the repository and can be edited to set run parameters to 'on' or 'off'

The tool will output a summary report for the analysis, including:<br>
- Detecting mutations<br>
- Assignment of lineages to the samples using [Pangolin](https://cov-lineages.org/resources/pangolin.html)<br>
- Generating a phylogentic build for the samples using [Nextstrain](https://nextstrain.org/sars-cov-2/) <br>
- Creating an interactive chart for visualizing lineage prevalences in the samples over time<br>
After installation, the tool can be opened as a web-page on the user's system

<b>The tool will work on a workstation/server with 64 bit Linux-based operating system, and has been validated on Ubuntu (16.04 LTS) Linux Distribution.</b>

## Quickstart

### Requirements
- git
- anaconda or miniconda

### Installation
Clone the genepi-box repository to your system using ```git clone https://github.com/banijolly/genepi-box.git ```
To use conda, download and install the latest version of [Anaconda](https://www.anaconda.com/distribution/) or [Miniconda](https://docs.conda.io/en/main/miniconda.html) to the <b>home directory of your system.</b>

Navigate into the cloned directory on your system:
``` cd genepi-box ```

The tool can be installed by running the setup.sh installation script given in the repository. To install, run the following command:
For Anaconda:

``` ./setup.sh ```

For Miniconda:
``` ./setup_miniconda.sh ```

### Running
To activate the conda environment, run:
``` conda activate genepi-box ```


After successful installation, the tool may be run by executing the command:
``` ./start.sh ```

This will initiate a local web-server on your system.
To open the tool interface, open the link  http://localhost:2000 on a web browser. The web-page is best suited to view on Google Chrome.


## About the Protocol
The **Computational Protocol for Assembly and Analysis of SARS-nCoV-2 Genomes** has been compiled by VS-Lab at [CSIR-Insitute of Genomics an Integrative Biology](https://www.igib.res.in/) as an effort to aid analysis and interpretation of the sequencing data of SARS-CoV-2 using easy-to-use open source utilities using both reference-guided and de novo based strategies.

This README document illustrates the prerequisites and installations steps required to run the pipeline for paired-end samples. For a detailed description of the steps involved in this protocol along with the commands used, please read the [Analysis Steps](https://github.com/banijolly/Genepi/blob/master/Analysis_Steps.md) document.

More information about the lab and our work on COVID-19 can be found at the [lab website](http://vinodscaria.genomes.in/).
