import sys,os

mappingFile = sys.argv[1]
inFile = sys.argv[2]
outFile = sys.argv[3]

d = {}
with open(mappingFile) as f:
     for line in f:
             (key, val) = line.split()
             val=val.replace(":", ":")
             d[(key)] = val

fout = open(outFile, "wt")
with open(inFile, 'r') as f:
    s = f.read()
    for key in d:
        s = s.replace(d[key], key)
    fout.write(s)
