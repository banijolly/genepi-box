#!/bin/bash

echo "Updating Master data files"  >> ../LOGFILE.now
cat SampleSummary.txt | grep -v "Sample ID" |  awk -F"\t" '{print $1"\t"$15"\t"$14"\t"$14"\t"$13}' >> ../MasterFiles/metadata-master.tsv

cat Combined_Fasta_sequences.fasta >> ../MasterFiles/sequences_master.fasta

cat $1 |grep -v "Virus name" |  awk -F"\t"  -v r=$(date "+%Y-%m-%d") '{print $15"\tncov\t?\t?\t"$4"\t"$5"\t"$6"\t"$7"\t?\t"$5"\t"$6"\t"$7"\tgenome\t29903\t"$8"\t"$10"\t"$9"\t"$13"\t"$16"\t"$18"\t?\t?\t"r}' >> ../MasterFiles/nextstrain-metadata_master.tsv
