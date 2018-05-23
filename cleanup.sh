#!/bin/bash
#########################################################################
# File Name: cleanup.sh
# Author: libenping
# mail: libenping@novogene.com
# Created Time: Tue 22 May 2018 05:28:42 PM CST
#########################################################################

if [ ! -f nohup.out ];then
	echo "wrong dir"
	exit
fi
ls|grep -vE "run_racon.cfg|0fasta" |xargs rm -r
