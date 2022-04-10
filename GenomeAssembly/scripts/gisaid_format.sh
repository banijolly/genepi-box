#!/bin/bash
cd ../GISAID_Files
echo "Formatting Data for GISAID Submission"  >> ../LOGFILE.now
cat ../uploads/Metadata_input.tsv | grep -v "Virus name" | awk -F"\t" '{print ">"$1":>"$15"_consensus"}' > .change

uname=$(cat ../config.txt  | grep -v "#" | grep  username | cut -d "=" -f2)


python scripts/formatHeaders.py .change Combined_Fasta_sequences.fasta /dev/stdout | sed 's/_consensus//g' > "EpiCoV_Submission_"$(date +%Y-%m-%d)".fasta"
cat $1  |  grep -v "Virus name" | awk -F"\t" -v r="EpiCoV_Submission_"$(date +%Y-%m-%d)".fasta" -v uname=$uname '{print uname"\t"r"\t"$1"\t"$2"\t"$3"\t"$4"\t"$5" / "$6"\t\t"$8"\t\t\t"$9"\t"$10"\t"$11"\t\t\t\t\t"$12"\t\t\t"$13"\t"$13"\t"$15"\t"$16"\t"$17"\t\t"$18"\t\t"}' > ../GISAID_Files/.temp


cat ../GISAID_Files/.epicov_header ../GISAID_Files/.temp | awk 'BEGIN { FS="\t"; OFS="," } {  rebuilt=0
  for(i=1; i<=NF; ++i) {
    if ($i ~ /,/ && $i !~ /^".*"$/) { 
      gsub("\"", "\"\"", $i)
      $i = "\"" $i "\""
      rebuilt=1 
    }
  }
  if (!rebuilt) { $1=$1 }
  print
}' > ../GISAID_Files/"EpiCoV_Submission_"$(date +%Y-%m-%d)"_Metadata.csv"
