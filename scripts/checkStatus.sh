#!/bin/bash
ns=$1
gsd=$2
ts=$3
outFolder="RunFiles/Run_"$ts

gsdMeta=$(ls -1 $outFolder/GISAID_Files/Epi*Metadata.csv)
gsdFasta=$(ls -1 $outFolder/GISAID_Files/Epi*fasta)
nsDir=$(ls -1 $outFolder/Nextstrain_Files | grep -v clade)
ncFile=$(ls -1 $outFolder/Nextstrain_Files/nextclade.tsv)
<<<<<<< HEAD
printf "<b>The pipeline has finished running. Please check the log file to know the status of the run.</b><br>Download Output Files:<br><a href='../LOGFILE.now' download ><u>Run Log</u></a>  /  <a href='../"$outFolder"/run.log' download ><u>Detailed Run Log</u></a><br><br><br><a href='http://localhost:2000/lineageTracker.html' target='_blank'> <u> Click here to view Lineage Tracker</u><br>" > .status
=======
printf "<b>The pipeline has finished running. Please check the log file to know the status of the run.</b><br>Download Output Files:<br><a href='../LOGFILE.now' download ><u>Run Log</u></a>  /  <a href='../"$outFolder"/run.log' download ><u>Detailed Run Log</u></a><br><a href='../"$outFolder"/GenomeAssembly_Files/SampleSummary.txt' download><u>Analysis Summary File</u></a><br><a href='../"$outFolder"/GenomeAssembly_Files/Combined_Fasta_sequences.fasta' download><u>Combined FASTA Sequences File</u></a><br><br><a href='http://localhost:2000/lineageTracker.html' target='_blank'> <u> Click here to view Lineage Tracker</u><br>" > .status
>>>>>>> 15c263e2b21dfc75311e43f3eeeb3d77f1d077b5

if [[ $ns == "on" ]] && [[ $gsd == "on" ]]
then
	HOST="localhost" auspice view --datasetDir $outFolder/Nextstrain_Files/$nsDir/auspice > /dev/null 2>run.log &
	pID=$(echo "$!")
	printf "<br><a href='../"$gsdMeta"' download><u>GISAID Metadata</u></a> <a href='../"$gsdFasta"' download><u>GISAID FASTA Sequences File</u></a><br>" >> .status
        printf "<br><a href='../"$ncFile"' download><u>Nextclade Report File</u></a><br>" >> .status
	printf "<br><a href='http://localhost:4000' target='_blank'> <u> Click here to view Nextstrain build for the run</u>" >> .status
elif [[ $ns == "on" ]]
then
        HOST="localhost" auspice view --datasetDir $nsDir/auspice > /dev/null 2>run.log &
	pID=$(echo "$!")
        printf "<br><a href='../"$ncFile"' download><u>Nextclade Report File</u></a><br>" >> .status
	printf "<br><a href='http://localhost:4000' target='_blank'> <u> Click here to view Nextstrain build for the run</u>" >> .status
else
	printf "" >> .status
fi

