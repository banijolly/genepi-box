#!/bin/bash
for i in `cat SAMPLE_IDs`; do printf $i"\t"; vars=$(cat "Variant_calling_output_"$OUT"/"$i".vcf" | grep -v "##" | cut -f1,2,4,5,10 | awk -F":" '($7=="100%" || $7>50)' | cut -f1,2,3,4 | tr "\n" "," | sed 's/\t/:/g'); printf $vars"\n"; done > Nucleotide_Mutations.txt

sed -i 's/NC_045512.2://g' Nucleotide_Mutations.txt
sed -i 's/,$//g' Nucleotide_Mutations.txt


cat Variant_calling_output_$OUT/*.vcf | grep -v "#" | awk -F"\t" '{print "1\t"$2"\t.\t"$4"\t"$5"\t.\t.\t.\t"}' | grep -v "," |sort | uniq > vars_combined.vcf

echo "otherinfo" > otherinfo

cat Variant_calling_output_$OUT/*.vcf | grep -v "#" | awk -F"\t" '{print "1\t"$2"\t.\t"$4"\t"$5"\t.\t.\t.\t"$2":"$4":"$5 }' | grep -v "," |sort | uniq | cut -f9 >> otherinfo

perl annovar/convert2annovar.pl --format vcf4 vars_combined.vcf --outfile VARS.avi

perl annovar/table_annovar.pl VARS.avi annovar/NCOVDB/ --buildver covid --outfile ANNOTATED_VARS --protocol refGene --operation g --nastring . --remove --otherinfo


cut -f10,11 ANNOTATED_VARS.covid_multianno.txt | cut -d":" -f1,5  | cut -d"," -f1 | sed 's/p\.//g' | cut -f1 > V1
paste V1 otherinfo > AA_VARS.txt

rm V1



python var_changeToAA.py AA_VARS.txt Nucleotide_Mutations.txt PROTEIN_VARS.txt


x=$(cut -f2 PROTEIN_VARS.txt | tr "," "\n" | grep "[0-9].OR\|[0-9].\." | cut -d":" -f1 | sort | uniq | sed "s/^/sed 's\//g" | sed 's/\./\\./g'|sed "s/$/\/\\/g'/g" | sed "s/ORF1a\//ORF1a\/ORF1a/g"|tr "\n" "|"); y=$(printf "cat PROTEIN_VARS.txt| $x  sed 's/\.,//g' | sed 's/,\.$//g' |sed 's/,$//g' >prot.txt")
eval $y
mv prot.txt AA_Mutations.txt
rm PROTEIN_VARS.txt AA_VARS.txt ANNOTATED_VARS.covid_multianno.txt vars_combined.vcf otherinfo VARS.avi

sed -i '1s/^/Sample ID\tNucleotide Mutations\n/' Nucleotide_Mutations.txt
sed -i '1s/^/Sample ID\tAA Mutations\n/' AA_Mutations.txt

paste  SampleSummary.txt  <(awk -F"\t" '{print $2}' Nucleotide_Mutations.txt) > .tmp
paste  .tmp  <(awk -F"\t" '{print $2}' AA_Mutations.txt)> .tmp2
mv .tmp2 SampleSummary.txt
