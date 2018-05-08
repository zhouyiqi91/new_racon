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

#ascii=97
mkdir ./pre_racon
mkdir ./scripts
mkdir all
cd scripts
for bam in `ls $bam_dir/*.bam`;do
	#t=`printf "%x" $ascii`  
	#prefix=`printf "\\x$t"`
	echo "bam2fasta.sh $bam $outdir/pre_racon $a_p $ref" >> pre_work.sh
	#ascii=$((ascii+1))
done

perl $bin_path/qsub-sge.pl --resource vf=$a_vf,p=$a_p --verbose --queue $q --project $P ./pre_work.sh 

echo "cat $outdir/pre_racon/*.fasta > $outdir/all/all.fasta" > cat.sh 
echo "cat $outdir/pre_racon/*.paf > $outdir/all/all.paf" >> cat.sh
perl $bin_path/qsub-sge.pl --resource vf=1g,p=1 --queue $q --project $P ./cat.sh



