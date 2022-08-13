#!/bin/bash
cut -f1 MasterFiles/metadata-master.tsv  | grep -v SAMPLE_ID > LineageTracker/IDs
cd LineageTracker/
sed -i 's/_consensus//g' ../MasterFiles/sequences_master.fasta 
pangolin ../MasterFiles/sequences_master.fasta 
for i in `cat IDs`; do grep -w $i lineage_report.csv;done | cut -d "," -f2 | tr "," "\t" | sed '1s/^/Lineage\n/g' > Lineages
paste ../MasterFiles/metadata-master.tsv Lineages | awk 'BEGIN { FS="\t"; OFS="," } {  rebuilt=0
  for(i=1; i<=NF; ++i) {
    if ($i ~ /,/ && $i !~ /^".*"$/) { 
      gsub("\"", "\"\"", $i)
      $i = "\"" $i "\""
      rebuilt=1 
    }
  }
  if (!rebuilt) { $1=$1 }
  print
}' > metadata-lineagetracker_master.csv

