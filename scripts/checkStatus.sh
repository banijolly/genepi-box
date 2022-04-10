#!/bin/bash
ns=$1
gsd=$2

printf "<b>The pipeline has finished running. Please check the log file to know the status of the run.</b><br>Download Output Files:<br><a href='../LOGFILE.now' download ><u>Run Log</u></a>  /  <a href='../run.log' download ><u>Detailed Run Log</u></a><br><a href='../GenomeAssembly/SampleSummary.txt' download><u>Analysis Summary File</u></a><br><a href='../GenomeAssembly/Combined_Fasta_sequences.fasta' download><u>Combined FASTA Sequences File</u></a><br>" > .status

if [[ $ns == "on" ]] && [[ $gsd == "on" ]]
then
	auspice view --datasetDir NextstrainRun/"ns_ncov_"$(date +%Y-%m-%d)/auspice > /dev/null 2>run.log &
	pID=$(echo "$!")
	printf "<br><a href="../GISAID_Files/EpiCoV_Submission_2022-04-10_Metadata.csv" download><u>GISAID Metadata</u></a> <a href="../GISAID_Files/EpiCoV_Submission_2022-04-10.fasta" download><u>GISAID FASTA Sequences File</u></a><br>" >> .status
	printf "<br><a href='localhost:4000' target='_blank'> <u> Click here to view Nextstrain build for the run</u>" >> .status
elif [[ $ns == "on" ]]
then
        auspice view --datasetDir NextstrainRun/"ns_ncov_"$(date +%Y-%m-%d)/auspice > /dev/null 2>run.log &
        pID=$(echo "$!")
        printf "<br><a href='localhost:4000' target='_blank'> <u> Click here to view Nextstrain build for the run</u>" >> .status
else
	printf "" >> .status
fi
