#!/bin/bash
#########################################################################
# File Name: extract.sh
# Author: libenping
# mail: libenping@novogene.com
# Created Time: Wed 09 May 2018 11:16:07 AM CST
#########################################################################

#input: 1.split_split_ref.fasta 2.all.paf 3.fasta_dir

source ../*.cfg
bin_path=$(cd `dirname $0`; pwd)
split_ref=$1
dir_name=$(basename $1 )
mkdir $dir_name
cd $dir_name
mkdir shell
mkdir reads
cd shell
ln -s $split_ref $dir_name
sh $bin_path/ctgname.sh $dir_name
python $bin_path/readsname.py $2 ${dir_name}
index=0
for fasta in `ls $3/*.fasta`;do
	index=$((index+1))
	echo "python $bin_path/extract_reads.py $fasta ${dir_name}.mapped.reads >../reads/${index}_reads.fasta" >> ${dir_name}_reads.sh
done
$bin_path/qsub-sge.pl -l vf=$a_vf,p=1 -q $q -P $P ./${dir_name}_reads.sh
cat ../reads/*.fasta > ../${dir_name}_map_all.fasta

