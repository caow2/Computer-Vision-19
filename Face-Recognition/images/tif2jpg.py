import os, sys
from PIL import Image

dirnum = "3"
for infile in os.listdir("./" + dirnum):
    print("file : " + infile)
    if infile[-3:] == "tif" or infile[-3:] == "bmp" :
       # print "is tif or bmp"
       outfile = dirnum + "jpeg/" + infile[:-3] + "jpeg"
       im = Image.open(dirnum + "/" + infile)
       print("new filename : " + outfile)
       out = im.convert("L")
       out.save(outfile, "JPEG", quality=100)