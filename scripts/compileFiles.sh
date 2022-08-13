#!/bin/bash
ts=$1

mkdir "RunFiles/Run_"$ts
mkdir "RunFiles/Run_"$ts"/GenomeAssembly_Files" "RunFiles/Run_"$ts"/Nextstrain_Files" "RunFiles/Run_"$ts"/GISAID_Files" "RunFiles/Run_"$ts"/LineageTracker_Files"

gsdMeta=$(ls -1 GISAID_Files/Epi*Metadata*csv)
gsdFasta=$(ls -1 GISAID_Files/Epi*fasta)


mv GenomeAssembly/*_output_* GenomeAssembly/*txt GenomeAssembly/*fasta GenomeAssembly/SAMPLE_IDs GenomeAssembly/PANGO* GenomeAssembly/Picard_metrics_* "RunFiles/Run_"$ts"/GenomeAssembly_Files"

mv NextstrainRun/NextCladeOutput/nextclade.tsv   "RunFiles/Run_"$ts"/Nextstrain_Files"
mv NextstrainRun/ns_ncov_* "RunFiles/Run_"$ts"/Nextstrain_Files"
mv GISAID_Files/.change "RunFiles/Run_"$ts"/GISAID_Files"
mv GISAID_Files/Combined_Fasta_sequences.fasta "RunFiles/Run_"$ts"/GISAID_Files"
mv "$gsdFasta" "RunFiles/Run_"$ts"/GISAID_Files"
mv "$gsdMeta" "RunFiles/Run_"$ts"/GISAID_Files"
mv GISAID_Files/failed.out "RunFiles/Run_"$ts"/GISAID_Files"
mv GISAID_Files/gisaid.authtoken "RunFiles/Run_"$ts"/GISAID_Files"
mv GISAID_Files/logfile.log  "RunFiles/Run_"$ts"/GISAID_Files" 
mv GISAID_Files/.temp "RunFiles/Run_"$ts"/GISAID_Files"


mv LineageTracker/IDs LineageTracker/Lineages LineageTracker/lineage_report.csv "RunFiles/Run_"$ts"/LineageTracker_Files"
mv run.log "RunFiles/Run_"$ts
