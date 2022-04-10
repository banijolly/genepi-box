#!/bin/bash
rm uploads/*zip
rm LOGFILE.now
rm .status
printf "Analysis is running <img height='10%%' src='../images/loading.gif'>\n" > .status
touch LOGFILE.now

printf "#!/bin/bash\n" > run.sh
printf "cd GenomeAssembly\n" >> run.sh
printf "./assemblyPipeline.sh -d ../uploads/Fastq_1/ -s ../uploads/SampleSheet.csv -m ../uploads/Metadata_input.tsv -r resources/NC_045512.2.fasta\n" >> run.sh
printf "cd ../\n" >> run.sh

printf "./scripts/lineagetracker_metacombine.sh\n" >> run.sh



ns=$(cat config.txt | grep -v "##" | grep nextstrain| cut -d "=" -f2 )
build=$(cat config.txt | grep -v "##" | grep buildName | cut -d "=" -f2)
pattern=" |'"

if [[ $ns == "on" ]]
then
        if [[ $build == "" ]] || [[ $build =~ $pattern ]]
                then
                printf "ERROR while reading parameters for running Nextstrain in the config file.\nPlease provide the build name for running Nextstrain in the correct format in the configuration file. Build name should contain no spaces or tabs. If running Nextstrain is not required, please set the option to 'off' in the configuration file \n" > LOGFILE.now
                rm run.sh uploads/* 
		exit 1
        else
		printf "./scripts/runNS.sh "$build"\n" >> run.sh

	fi
else
if [[ $ns == "off" ]]
then
	printf "## No-Run-NS\n" >> run.sh
else
	printf "ERROR in parameter Nextstrain in configuration file. Please set the nextstrain option to either 'on' or 'off' in the file as required.\n" >> LOGFILE.now
        rm run.sh uploads/*
	exit 1
fi
fi

gsd=$(cat config.txt | grep -v "##" | grep gisaid| cut -d "=" -f2 )
ID=$(cat config.txt | grep -v "##" | grep client-ID| cut -d "=" -f2 )
uname=$(cat config.txt | grep -v "##" | grep username| cut -d "=" -f2 )
passwd=$(cat config.txt | grep -v "##" | grep password| cut -d "=" -f2 )


if [[ $gsd == "on" ]]
then
	if [[ $ID == "" ]] || [[ $uname == "" ]] || [[ $passwd == "" ]]
		then
		printf "ERROR while reading parameters for running GISAID submission in the config file.\nPlease provide the correct credentials for submitting data to GISAID. If GISAID submissions is not required, please set the option to 'off' in the configuration file \n" >> LOGFILE.now
                rm run.sh uploads/*
		exit 1
	else
		printf "./scripts/gisaid_upload.sh "$ID" "$uname" "$passwd"\n" >> run.sh
	fi
else
if [[ $gsd == "off" ]]
then
        printf "## No-Run-GSD\n" >> run.sh
else
        printf "ERROR in parameter GISAID configuration file. Please set the nextstrain option to either 'on' or 'off' in the file as required.\n" >> LOGFILE.now
		rm run.sh uploads/*
		exit 1

fi
fi

printf "ts=\$(ls -1 GenomeAssembly/ | grep PANGO  | cut -d '_' -f3)\n" >> run.sh

printf "./scripts/compileFiles.sh \$ts \n" >> run.sh
printf "./scripts/checkStatus.sh "$ns" "$gsd" \$ts\n" >> run.sh

chmod +x run.sh
./run.sh
