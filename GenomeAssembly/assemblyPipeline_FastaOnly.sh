#!/bin/bash 
start=`date +%s`
usage()
{
  echo "Usage: ./run_PE.sh -d <Directory of fasta files> -s <sample sheet> -m <metadata file> -r <Path to reference genome FAS
TA File>  -h <help>"
  exit 2
}



cat ../uploads/Metadata_input.tsv  | cut -f15 | grep -vi originating > SAMPLE_IDs
OUT=$(date "+%Y.%m.%d-%H.%M.%S")

while getopts d:r:s:m:h: option 
do 
 case "${option}" 
 in 
 d) DIRECTORY=${OPTARG};;
 r) REFERENCE=${OPTARG};;
 s) SAMPLE_SHEET=${OPTARG};;
 m) METADATA=${OPTARG};;

 h|?) usage ;; esac
done


mkdir PANGO_reports_$OUT


cp $DIRECTORY Combined_Fasta_sequences.fasta
sed -i 's/>.*/&_consensus/' Combined_Fasta_sequences.fasta
cp Combined_Fasta_sequences.fasta ../GISAID_Files/Combined_Fasta_sequences.fasta

pangolin Combined_Fasta_sequences.fasta --outfile lineage-report.csv


printf "Sample ID\tLineage\tTotal Reads R1\tTotal Reads R2\tTrimmed Reads R1\tTrimmed Reads R2\tHISAT2_alignment_percentage\tX coverage\tGenome coverage\tVCF Variant Count\tNs in FASTA\tNucleotide Mutations\tAA_Mutations\n" > SampleSummary.txt

for i in `cat SAMPLE_IDs`
do
	lineage=$(cat lineage-report.csv | grep -P "^"$i"_consensus," | cut -d "," -f2)
	printf $i"\t"$lineage"\t.\t.\t.\t.\t.\t.\t.\t.\t.\t.\t."
       	printf "\n"
done >> SampleSummary.txt

for i in `cat SAMPLE_IDs`; do grep -w $i $METADATA ; done | cut -f4,7   | sed '1s/^/Collection Date\tLocation\n/g' > .dates

cp SampleSummary.txt .tmp2
paste .tmp2 .dates > SampleSummary.txt

rm .dates .tmp2


#fold -100 Combined_Fasta_sequences.fasta > ../GISAID_Files/Combined_Fasta_sequences.fasta

./scripts/gisaid_format.sh $METADATA
./scripts/masterfiles_update.sh $METADATA

end=`date +%s`

runtime=$((end-start))

echo ------------------------------------------------------------------ >> ../LOGFILE.now
echo All done >> ../LOGFILE.now
echo Time Taken: $runtime seconds >> ../LOGFILE.now
echo ------------------------------------------------------------------ >> ../LOGFILE.now
