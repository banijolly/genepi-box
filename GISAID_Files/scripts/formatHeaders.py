import sys,os

mappingFile = sys.argv[1]
inFile = sys.argv[2]
outFile = sys.argv[3]
x=1
d = {}
with open(mappingFile) as f:
     for line in f:
             (key, val) = line.split(":")
             val=val.replace("\n", "")
             d[(key)] = val

fout = open(outFile, "wt")
with open(inFile, 'r') as f:
    s = f.read()
    for key in d:
        #print(x)
        s = s.replace(d[key], key)
        x=x+1
    fout.write(s)
