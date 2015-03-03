#!/usr/bin/python

#batch download files from urls according to  .txt file
import re
import urllib.request

file = open("weipai.txt")
line = file.readline()

pattern =  re.compile("^http:.*.mov$")
count = 0

while line:
    result = pattern.match(line)
    
    if result:
        try:
            status_code = urllib.request.urlopen(line).getcode()
        except Exception:
            line = file.readline()
            continue
        
        if status_code and status_code == 200:
            print("Downloading from " + line)
            urllib.request.urlretrieve(line, "donwload/00" + str(count) + ".mov")
            count += 1
        
    line = file.readline()
    
file.close()

