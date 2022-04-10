#!/bin/bash
echo ------------------------------------------------------------------ >> ../LOGFILE.now
echo "Combining all FASTA Files and storing output in Combined_Fasta_sequences.fasta" >> ../LOGFILE.now
echo ------------------------------------------------------------------  >> ../LOGFILE.now

mkdir FASTAS

for i in `cat SAMPLE_IDs`
do
cp Variant_calling_output_*/"$i"_*fasta FASTAS/"$i"_consensus.fasta
done

cd FASTAS
python ../scripts//change_header.py .
rm -rf *fasta
cat *fa > Combined_Fasta_sequences.fasta

rm -rf *fa

fold -100 Combined_Fasta_sequences.fasta > ../../GISAID_Files/Combined_Fasta_sequences.fasta

sed 's/_consensus//g' Combined_Fasta_sequences.fasta | fold -100 > temp
mv temp ../Combined_Fasta_sequences.fasta
cd ../
rm -rf FASTAS

