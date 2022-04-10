#!/bin/bash
cd NextstrainRun

echo "Running Nextstrain for creating build" $1 >> ../LOGFILE.now

build=$1
git clone https://github.com/nextstrain/ncov.git "ns_ncov_"$(date +%Y-%m-%d)

cd "ns_ncov_"$(date +%Y-%m-%d)
cp ../../MasterFiles/nextstrain-metadata_master.tsv data/metadata.tsv
cat ../../MasterFiles/nextstrain-reference.fasta ../../MasterFiles/sequences_master.fasta > data/sequences.fasta

cp ../Custom/builds.yaml my_profiles/example/builds.yaml
sed -i "s/EXAMPLEBUILDNAME/$build/g" my_profiles/example/builds.yaml 
cp ../Custom/description.md my_profiles/example/
snakemake --profile my_profiles/example -p

echo "Nextstrain Run completed" $1 >> ../../LOGFILE.now
