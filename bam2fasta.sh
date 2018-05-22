#!/bin/bash
# Created Time: Wed 02 May 2018 11:22:41 AM CST
# convert bam to fasta
# usage: bam2fasta.sh *.bam output_dir

file=$(basename $1 .bam)
samtools view $1|awk  '{print ">"$1;print $10}' > $2/${file}.fasta
#minimap2 --secondary=no -t $3 -x map-pb $4 $2/${file}.fasta >$2/${file}.paf
