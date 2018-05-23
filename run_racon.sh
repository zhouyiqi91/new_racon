#!/bin/bash
#########################################################################
# File Name: run_racon.sh
# Author:zyq
# Created Time: Wed 02 May 2018 11:17:55 AM CST
#########################################################################

source ./*.cfg
bin_path=$(cd `dirname $0`; pwd)
nohup sh $bin_path/racon_main.sh & 

 
