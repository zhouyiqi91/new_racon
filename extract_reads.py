import sys

fastafile=sys.argv[1]
namefile=sys.argv[2]
outfile=namefile.split(".")[0]+"_mappedread.fasta"
writefile=open(outfile,'w')
namelist={}
with open(namefile) as names:
	for line in names:
		line=line.strip("\n")
		line=line.strip(" ")
		namelist[line] = 1

write_next=False
with open(fastafile) as fastas:
	for line in fastas:
		line=line.strip("\n")
		line=line.strip(" ")
		if write_next:
			writefile.write(line+"\n")
			write_next=False
		if line[0] == ">":
			line=line.strip(">")
			if line in namelist:
				writefile.write(">"+line+"\n")
				write_next=True

writefile.close()

