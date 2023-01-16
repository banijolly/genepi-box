#!/bin/bash
echo "Setting up analysis environment"

conda install  -n base -c conda-forge mamba --yes

mamba env create -f environment.yml

source ~/miniconda3/etc/profile.d/conda.sh
conda activate genepi-box

git clone https://github.com/cov-lineages/pangolin.git
cd pangolin
pip install .

cd ..
rm -rf pangolin

cd GISAID_Files
pip install --user ./gisaid_cli2
cp ~/.local/bin/cli2 ~/miniconda3/envs/genepi-box/bin/

cd ..
cp scripts/php.ini ~/miniconda3/envs/genepi-box/lib

echo "Enviroment set up complete"
