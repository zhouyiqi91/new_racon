#!/bin/bash
#########################################################################
# File Name: ctgname.sh
# Author: libenping
# mail: libenping@novogene.com
# Created Time: Fri 04 May 2018 04:30:20 PM CST
#########################################################################
file=$1
prefix=`basename $file .fasta`
awk -F "" '{if ($1==">") {print $0}}' $file >${prefix}.ctgname
