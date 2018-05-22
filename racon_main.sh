#!/bin/bash
#########################################################################
# File Name: run_racon.sh
# Author: libenping
# mail: libenping@novogene.com
# Created Time: Wed 09 May 2018 10:44:38 AM CST
#########################################################################

source ./*.cfg
outdir=`pwd`
bin_path=$(cd `dirname $0`; pwd)
soft_path=$bin_path/soft
export PATH=$bin_path:$PATH
export PATH=$bin_path/soft/minimap2:$PATH

mkdir mapping
mkdir mapping/shell
cd ./mapping/shell
for fasta in `ls $fasta_dir/*.fasta`;do
	file=$(basename fasta .fasta)
	echo "minimap2 --secondary=no -t $a_p -x map-pb $ref $fasta >$outdir/mapping/${file}.paf" >> mapping.sh
done
perl $bin_path/qsub-sge.pl --resource vf=$a_vf,p=$a_p --verbose --queue $q --project $P ./mapping.sh
cd $outdir


