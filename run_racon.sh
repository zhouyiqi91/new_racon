#!/bin/bash
#########################################################################
# File Name: run_racon.sh
# Author:zyq
# Created Time: Wed 02 May 2018 11:17:55 AM CST
#########################################################################

source ./*.cfg
bin_path=$(cd `dirname $0`; pwd)
#check pre
if [ $fasta_dir"x" == "x" ];then
	nohup sh $bin_path/pre_racon.sh &
	while true;do
		if [ -f "0fasta/pre_done.txt" ];then
			break
		fi
	sleep 1m
	done
fi

nohup sh $bin_path/racon_main.sh & 

 
