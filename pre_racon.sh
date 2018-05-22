#!/bin/bash
#########################################################################
# File Name: pre_racon.sh
# Author:zyq
# Created Time: Wed 02 May 2018 11:17:55 AM CST
#########################################################################

source ./*.cfg
outdir=`pwd`
bin_path=$(cd `dirname $0`; pwd)
soft_path=$bin_path/soft
export PATH=$bin_path:$PATH
export PATH=$bin_path/soft/minimap2:$PATH

mkdir ./0fasta
cd ./0fasta
mkdir fastas
for bam in `ls $bam_dir/*.bam`;do
	echo "bam2fasta.sh $bam $outdir/0fasta/fastas $a_p $ref" >> pre_work.sh
done

python $bin_path/qsub-sge.pl -l vf=$a_vf,p=$a_p -q $q -P $P ./pre_work.sh 

echo "cat $outdir/0fasta/fastas/*.fasta > $outdir/0fasta/all.fasta" > cat.sh 
python $bin_path/sgearray.py -l vf=1g,p=1 -q $q -P $P ./cat.sh









