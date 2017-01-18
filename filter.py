import sys
import csv

output=[]
with open(sys.argv[1], 'r') as csvfile:
    spamreader = list(csv.reader(csvfile, delimiter=',', quotechar='|'))
    pos=0
    for i in spamreader:
        time = i[1]
        output.append([pos,i[12],time,i[12],i[13]])
        pos += 1
        output.append([pos,i[16],time,i[16],i[17]])
        pos += 1
        output.append([pos,i[32],time,i[32],i[33]])
        pos += 1
        output.append([pos,i[34],time,i[34],i[35]])
        pos += 1

with open(sys.argv[2], 'w') as csvfile:
    writer = csv.writer(csvfile)
    writer.writerows(output)
