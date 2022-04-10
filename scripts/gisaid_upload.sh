#!/bin/bash
echo ------------------------------------------------------------------
echo "Preparing GISAID Submissions"  >> LOGFILE.now
echo ------------------------------------------------------------------


cd GISAID_Files
cli2 authenticate --database EpiCoV --client_id $1 --username $2 --password "$3"

cli2 upload --metadata "EpiCoV_Submission_"$(date +%Y-%m-%d)"_Metadata.csv" --fasta "EpiCoV_Submission_"$(date +%Y-%m-%d)".fasta"

cat logfile.log >> ../LOGFILE.now
echo ------------------------------------------------------------------  >> ../LOGFILE.now
echo "Submitted Files to GISAID" >> ../LOGFILE.now
echo ------------------------------------------------------------------  >> ../LOGFILE.now

