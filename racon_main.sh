#!/bin/bash

source ./*.cfg
outdir=`pwd`
bin_path=$(cd `dirname $0`; pwd)
soft_path=$bin_path/../soft
export PATH=$bin_path:$PATH
export PATH=$soft_path/minimap2:$PATH
export PATH=$soft_path/racon/racon/build/vendor/rampler/bin/:$PATH
export PATH=$soft_path/racon/racon/build/bin/:$PATH
if [ $fasta_dir"x" == "x" ];then
	fasta_dir=0fasta
fi
prefix=$prefix

#1map
mkdir 1mapping
cd ./1mapping
mkdir pafs
echo "?export PATH=$soft_path/minimap2:\$PATH" > ${prefix}_racon_map.txt
for fasta in `ls $outdir/$fasta_dir/fastas/*.fasta`;do
	file=`basename $fasta .fasta`
	echo "minimap2 --secondary=no -t $a_p -x map-pb $ref $fasta >./pafs/${file}.paf" >> ${prefix}_racon_map.txt
done
python $bin_path/sgearray.py -l vf=$a_vf,p=$a_p -q $q -P $P ${prefix}_racon_map.txt
cat $outdir/1mapping/pafs/*.paf > ./all.paf

#2split_ref
cd $outdir
split_size=$((200*1000000))
mkdir 2split_ref
cd 2split_ref
echo "?export PATH=$soft_path/racon/racon/build/vendor/rampler/bin/:\$PATH" >${prefix}_split.txt
echo "rampler split $ref $split_size" >> ${prefix}_split.txt
python $bin_path/sgearray.py -l vf=3g,p=1 -q $q -P $P ${prefix}_split.txt


#3extract
cd $outdir
mkdir 3extract
cd 3extract
echo "?export PATH=$soft_path/racon/racon/build/bin/:\$PATH" >${prefix}_extract.txt
for sfa in `ls $outdir/2split_ref/|grep "fasta$"`;do
	sfadir=`basename $sfa .fasta`
	echo "mkdir $sfadir && cd $sfadir && ln -s $outdir/2split_ref/$sfa $sfa" >> ${prefix}_extract.txt
	echo "sh $bin_path/ctgname.sh ./$sfa" >> ${prefix}_extract.txt
	echo "python $bin_path/readsname.py $outdir/1mapping/all.paf $sfadir" >>${prefix}_extract.txt
	echo "sort -u ${sfadir}.mapped.reads > ${sfadir}.readlist" >>${prefix}_extract.txt
	echo "python $bin_path/extract_reads.py $outdir/fasta_dir/all.fasta ${sfadir}.readlist" >>${prefix}_extract.txt
done
python $bin_path/sgearray.py -l vf=3g,p=1 -q $q -P $P -c 5 ${prefix}_extract.txt

#4main
cd $outdir
mkdir 4main
cd 4main
for sfa in `ls $outdir/2split_ref/|grep "fasta$"`;do
	sfadir=`basename $sfa .fasta`
	mapfasta=${sfadir}_mappedread.fasta
	echo "mkdir $sfadir && cd $sfadir && racon -t $r_p $outdir/3extract/$sfadir/$mapfasta $outdir/1mapping/all.paf $outdir/2split_ref/$sfa > ./${sfadir}_c.fasta" >> ${prefix}_main.txt
done
python $bin_path/sgearray.py -l vf=$r_vf,p=$r_p -q $q -P $P ${prefix}_main.txt
cat $outdir/4main/*/*_c.fasta > $outdir/${prefix}_out.fasta
echo "all done"



