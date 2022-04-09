#!/bin/bash
cut -f1 MasterFiles/metadata-master.tsv  | grep -v SAMPLE_ID > LineageTracker/IDs
cd LineageTracker/
pangolin ../MasterFiles/sequences_master.fasta 
for i in `cat IDs`; do grep -w $i lineage_report.csv;done | cut -d "," -f2 | tr "," "\t" | sed '1s/^/Lineage\n/g' > Lineages
paste ../MasterFiles/metadata-master.tsv Lineages > metadata-lineagetracker_master.tsv

