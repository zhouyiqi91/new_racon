#!/bin/bash
#########################################################################
# File Name: readsname.py
# 1:all.paf 2.split_ref
######################################################################

import sys

paf=sys.argv[1]
ctgname=sys.argv[2]+".ctgname"
out=sys.argv[2]+".mapped.reads"

readdic={}
ctglist=[]
with open(ctgname) as ctg:
	for line in ctg:
		line=line.strip("\n")
		line=line.strip(">")
		ctglist.append(line)
	
		
with open(paf) as pafs:
	for line in pafs:
		ctgname=line.split("\t")[5]
		#print ctgname
		if ctgname in ctglist:
			readname=line.split("\t")[0]
			readdic[readname] = 0

with open(out,'w') as outfile:
	for key in readdic.keys():
		outfile.write(key+"\n")

