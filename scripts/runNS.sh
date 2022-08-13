#!/bin/bash
cd NextstrainRun

echo "Running Nextclade and running Nextstrain for creating build" $1 >> ../LOGFILE.now

nextclade dataset get --name 'sars-cov-2' --output-dir 'data/sars-cov-2'

nextclade run  --input-dataset data/sars-cov-2 --output-all NextCladeOutput ../MasterFiles/sequences_master.fasta

build=$1
git clone https://github.com/nextstrain/ncov.git "ns_ncov_"$(date +%Y-%m-%d)

cd "ns_ncov_"$(date +%Y-%m-%d)
cp ../../MasterFiles/nextstrain-metadata_master.tsv data/metadata.tsv
cat ../../MasterFiles/nextstrain-reference.fasta ../../MasterFiles/sequences_master.fasta > data/sequences.fasta

mkdir my_profiles/example

cp ../Custom/* my_profiles/example/
cat ../Custom/builds.yaml | sed "s/EXAMPLEBUILDNAME/$build/g" >  my_profiles/example/builds.yaml

snakemake --profile my_profiles/example -p

echo "Nextstrain Run completed" $1 >> ../../LOGFILE.now
