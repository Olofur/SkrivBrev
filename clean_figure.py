#!/usr/bin/python

# # -*- coding: utf-8 -*-
# author:oh

'Clean up figures'

# It is convenient to combine with a scanning software, for example through
# google drive, to get written text that can easily be inserted into latex 
# documents with minimal graphical artifacts.

from pdf2image import convert_from_path

image = convert_from_path('./Figures/signature.pdf', fmt='ppm', transparent=False)

img = image[0].convert('RGBA')

Data = img.getdata()

new_data = []
for item in Data:
    if item[0] >= 240 and item[1] >= 240 and item[2] >= 240:
        new_data.append((255,255,255,0)) # Transparent pixel
    else:
        new_data.append(item)

img.putdata(new_data)
img.save('./Figures/signature.png', 'PNG')
